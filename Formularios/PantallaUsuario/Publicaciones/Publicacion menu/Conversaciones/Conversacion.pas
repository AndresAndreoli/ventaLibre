unit Conversacion;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MEConversaciones, Login, TDACola, TDAColasParciales, MEArticulosPublicados;

type
  TformConversaciones = class(TForm)
    listBoxConversaciones: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    editRespuesta: TEdit;
    btnResponder: TButton;
    btnVolver: TButton;
    editMensaje: TMemo;
    labelIDMensaje: TLabel;
    labelIDCliente: TLabel;
    procedure btnVolverClick(Sender: TObject);
    procedure listBoxConversacionesDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure listBoxConversacionesMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure listBoxConversacionesDblClick(Sender: TObject);
    procedure btnResponderClick(Sender: TObject);
  private
    function obtenerMensaje(mensaje:string):string;
    function obtenerComprador(mensaje:string):string;
  public
    { Public declarations }
  end;

var
  formConversaciones: TformConversaciones;

implementation

uses Menu, Publicaciones;

{$R *.dfm}

procedure TformConversaciones.btnVolverClick(Sender: TObject);
begin
  formConversaciones.close;
  formMenuUsuario.close;
  formPublicaciones.show;
  listBoxConversaciones.items.clear;
  editMensaje.Text:='';
  editRespuesta.Text:='';
end;

procedure TformConversaciones.listBoxConversacionesDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
aItem : String;
begin
aItem := listBoxConversaciones.Items[Index];
DrawText(listBoxConversaciones.Canvas.Handle,PChar(aItem), StrLen(PChar(aItem)), Rect, DT_WORDBREAK);
end;


procedure TformConversaciones.listBoxConversacionesMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
var
aItem : String;
aRect: TRect;
begin
aRect := listBoxConversaciones.ClientRect;
aItem := listBoxConversaciones.Items[Index];
Height := DrawText(listBoxConversaciones.Canvas.Handle,PChar(aItem), StrLen(PChar(aItem)),aRect,DT_WORDBREAK);

end;


procedure TformConversaciones.listBoxConversacionesDblClick(
  Sender: TObject);
  var
  pregunta: string;

  idMensaje, idComprador: integer;
begin
pregunta:= listBoxConversaciones.Items[listBoxConversaciones.itemindex];
if not (AnsiContainsStr(pregunta, 'Respuesta:')) then
begin
  idComprador:= strtoint(obtenerComprador(pregunta));
  idMensaje:= strtoint(obtenerMensaje(pregunta));
  labelIDMensaje.Caption:= inttostr(idMensaje);
  labelIDCliente.Caption:= inttostr(idComprador);
  editMensaje.Text:= pregunta;
end;
end;

function TformConversaciones.obtenerMensaje(mensaje:string):string;
var
  i: integer;
  devolver: string;
begin
  devolver:='';
  i:=1;
  while not(mensaje[i]='|') do
  begin
    devolver:=devolver+mensaje[i];
    i:=i+1;
  end;//while
  obtenerMensaje:=devolver;
end; //obtenerMensaje

function TformConversaciones.obtenerComprador(mensaje:string):string;
var
  i: integer;
  devolver: string;
begin
  devolver:='';
  i:=pos('|', mensaje)+1;
  while not(mensaje[i]='|') do
  begin
    devolver:= devolver+mensaje[i];
    i:=i+1;
  end;//while
  obtenerComprador:=devolver;
end;
procedure TformConversaciones.btnResponderClick(Sender: TObject);
var
  posConv, posEnconlar, posInd, pos, posMensaje, idArticulo: integer;
  cortar, cortarDatos, respondio: boolean;
  regNuloIndice: MEConversaciones.tipoRegIndice;
  regNuloDatos, regDat: MEConversaciones.TipoRegDatos;
  regInd: MEConversaciones.tipoRegIndice;
  pregunta, respuesta, idArticuloInd: string;
  regPubInd: MEArticulosPublicados.tipoRegIndice;
  regPubDat: MEArticulosPublicados.tipoRegDatos;
begin
if (trim(editMensaje.Text)='') then
  showmessage('Seleccione un mensaje')
else if (trim(editRespuesta.Text)='') then
  showmessage('Agregue una respuesta')
else begin
  idArticuloInd:= FormMenuUsuario.labelCodigo.Caption;

  MEArticulosPublicados.abrir(Publicado);
  MEArticulosPublicados.buscarCategorias(Publicado, idArticuloInd, pos);
  MEArticulosPublicados.capturarCategorias(Publicado, pos, regPubInd);
  MEArticulosPublicados.capturarArticulo(Publicado, regPubInd, regPubDat);

  idArticulo:= strtoint(regPubDat.Clave);

  MEConversaciones.abrir(Conversaciones);

  if MEConversaciones.buscarConversacion(Conversaciones, idArticulo, posConv) then
  begin
    regNuloIndice.clave:=-1;
    regNuloIndice.siguiente:=-1;
    cortar:= false;
    respondio:= false;
    TDACola.encolar(Conversaciones, regNuloIndice, pos);
    while not cortar do
    begin
        posInd:= TDACola.Frente(Conversaciones, regInd);
        TDACola.Decolar(Conversaciones);
         //showmessage('paso 0');
        if (regInd.clave=idArticulo) and (regInd.idCliente=strtoint(labelIDCliente.Caption)) then
        begin
          //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ RECORRER CONVERSACION
          cortarDatos:= false;
          regNuloDatos.clave:= -1;
          regNuloDatos.siguiente:= -1;
          regInd:= MEConversaciones.obtenerIndice(Conversaciones, posInd);
          TDAColasParciales.Encolar(Conversaciones, regNuloDatos, regInd, posInd);
          while not cortarDatos do
          begin
            TDAColasParciales.Frente(Conversaciones, regDat, regInd);
            TDAColasParciales.Decolar(Conversaciones, regInd, posInd);
            if regDat.clave<>-1 then
            begin
              if (regDat.clave=strtoint(labelIDMensaje.Caption)) then
              begin
                if(trim(regDat.mensajeVendedor)='') then
                begin
                  regDat.mensajeVendedor:= editRespuesta.Text;
                  respondio:=true;
                end else begin
                  showmessage('La pregunta ya fue respondida.');
                  editRespuesta.Text:='';
                  end;
              end;// Es mensaje
              TDAColasParciales.Encolar(Conversaciones, regDat, regInd, posInd);
            end
            else
              cortarDatos:= true;
          end;//While
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        end; // Es articulo
        if regInd.clave<>-1 then
          TDACola.Encolar(Conversaciones, regInd, posEnconlar)
        else
          cortar:= true;
    end; // While CORTAR
  end;// Encontro


  formConversaciones.editMensaje.Text:='';
  //if not MEConversaciones.buscar(Conversaciones, strtoint(labeIDArticulo.caption), reg.IDUsuario, pos) then  messagedlg('Error. Reenvie el mensaje.',mtWarning, mbokcancel,0);;
  MEConversaciones.cerrar(Conversaciones);
end;// Enviar mensaje

if (respondio) then
begin
  formConversaciones.Close;
  listboxConversaciones.Items.Clear;
  editMensaje.Clear;
  editRespuesta.Text:='';
  formMenuUsuario.clickConversacion;
end;
end;

end.



