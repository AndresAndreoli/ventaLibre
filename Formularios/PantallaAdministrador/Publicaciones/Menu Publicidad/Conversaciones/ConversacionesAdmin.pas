unit ConversacionesAdmin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MEArticulosPublicados, TiposYconstantes, MEUsuario, Login, MEConversaciones,TDACola,TDAColasParciales;

type
  TformConversacionesAdmin = class(TForm)
    comboboxVendedor: TComboBox;
    comboboxComprador: TComboBox;
    comboboxArticulo: TComboBox;
    listboxConversaciones: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    btnVolver: TButton;
    btnAgregar: TButton;
    procedure btnVolverClick(Sender: TObject);
    procedure comboboxVendedorCloseUp(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnAgregarClick(Sender: TObject);
    procedure listboxConversacionesDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure listboxConversacionesMeasureItem(Control: TWinControl;
      Index: Integer; var Height: Integer);
  private
    procedure recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion;  Vendedor: integer);
    function obtenerIDArticulo(mensaje:string):string;
  public
    { Public declarations }
  end;

var
  formConversacionesAdmin: TformConversacionesAdmin;

implementation

uses PublicacionesAdmin;

{$R *.dfm}

procedure TformConversacionesAdmin.btnVolverClick(Sender: TObject);
begin
  listBoxConversaciones.Clear;
  formConversacionesAdmin.close;
  formPublicacionesAdmin.show;
end;

procedure TformConversacionesAdmin.comboboxVendedorCloseUp(
  Sender: TObject);
var
  Vendedor: integer;
begin
  if (comboboxVendedor.ItemIndex<>0) then
  begin
    comboboxArticulo.Clear;
    formConversacionesAdmin.comboboxArticulo.Items.Add('Ninguno');
    MEUsuario.AbrirMe(Usuario);
    MEUsuario.Buscar(Usuario, trim(comboboxVendedor.Items[comboboxVendedor.ItemIndex]), vendedor);
    MEUsuario.CerrarMe(Usuario);

    MEArticulosPublicados.abrir(Publicado);
    recorrerArbol(Publicado, MEArticulosPublicados.raizCategoria(Publicado),vendedor);
    MEArticulosPublicados.cerrar(Publicado);

    formConversacionesAdmin.comboboxArticulo.ItemIndex:= 0;
  end
  else begin
    formConversacionesAdmin.comboboxArticulo.Clear;
    formConversacionesAdmin.comboboxArticulo.Items.Add('Ninguno');
    formConversacionesAdmin.comboboxArticulo.ItemIndex:= 0;
  end
end;

// Recorrido PreOrden RECURSIVO
procedure TformConversacionesAdmin.recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; Vendedor: integer);
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;

begin
  If pos<>MEArticulosPublicados.posNula(Arbol) then
  begin
    MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);
    if (regDatos.IDVendedor = vendedor) then
      if (regDatos.estadoPublicacion=1) then // 1 = publicaciones publicadas.
    begin
      comboboxArticulo.Items.Add(regInd.Clave+'  | '+regDatos.NombreArticulo);
    end;

    recorrerArbol(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), vendedor);
    recorrerArbol(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), vendedor);
  end;
end; //recorrerArbol

procedure TformConversacionesAdmin.Button1Click(Sender: TObject);
var
  idVendedor, idCliente, pos, contador, posPub, idArticulo: integer;
  reg: MEUsuario.tiporegListaDatosHash;

  idArticuloInd: string;
  posConv, posEnconlar, posInd: integer;
  cortar, cortarDatos: boolean;
  regNuloIndice: MEConversaciones.tipoRegIndice;
  regNuloDatos, regDat: MEConversaciones.TipoRegDatos;
  regInd: MEConversaciones.tipoRegIndice;
  pregunta, respuesta: string;
  regPubInd: MEArticulosPublicados.tipoRegIndice;
  regPubDat: MEArticulosPublicados.tipoREgDatos;
begin
  listboxConversaciones.Clear;
  if (comboboxVendedor.ItemIndex=0) or (comboboxComprador.ItemIndex=0) or (comboboxArticulo.ItemIndex=0) then
    showmessage('Seleccione las opciones.')
  else if (comboboxVendedor.Items[comboboxVendedor.ItemIndex]=comboboxComprador.items[comboboxComprador.ItemIndex]) then
    showmessage('Seleccione diferencies usuarios.')
  else
  begin
    contador:=0;
    MEUsuario.AbrirMe(Usuario);
    MEUsuario.Buscar(Usuario, comboboxVendedor.Items[comboboxVendedor.itemindex], pos);
    MEUsuario.CapturarInfo(Usuario, reg, pos);
    idVendedor:= reg.IDUsuario;

    MEUsuario.Buscar(Usuario, comboboxComprador.Items[comboboxComprador.itemindex], pos);
    MEUsuario.CapturarInfo(Usuario, reg, pos);
    idCliente:= reg.IDUsuario;
    MEUsuario.CerrarMe(Usuario);

    idArticuloInd:= obtenerIDArticulo(comboboxArticulo.Items[comboboxArticulo.itemindex]);
    
    MEArticulosPublicados.abrir(Publicado);
    MEArticulosPublicados.buscarCategorias(Publicado, idArticuloInd, posPub);
    MEArticulosPublicados.capturarCategorias(Publicado, posPub, regPubInd);
    MEArticulosPublicados.capturarArticulo(Publicado, regPubInd, regPubDat);
    MEArticulosPublicados.cerrar(Publicado);
    idArticulo:= strtoint(regPubDat.clave);
    MEConversaciones.abrir(Conversaciones);

    //showmessage('idArticulo '+inttostr(idArticulo)+' idCliente '+inttostr(idCliente));
  if MEConversaciones.buscar(Conversaciones, idArticulo, idCliente, posConv) then
  begin
    cortar:= false;
    regNuloDatos.clave:=-1;
    regNuloDatos.siguiente:=-1;
    regInd:= MEConversaciones.obtenerIndice(Conversaciones, posConv);
    TDAColasParciales.encolar(Conversaciones, regNuloDatos, regInd, posConv);
    while not cortar do
    begin
        TDAColasParciales.Frente(Conversaciones, regDat, regInd);
        TDAColasParciales.Decolar(Conversaciones, regInd, posConv);
        if regDat.clave<>-1 then
        begin
          pregunta:= inttostr(regDat.clave)+'|'+inttostr(regInd.idCliente)+'|    '+DateTimeToStr(regDat.fecha)+#13;
          pregunta:= pregunta+'Pregunta: '+#13+regDat.mensajeComprador;
          listBoxConversaciones.Items.Add(pregunta);
          contador:=contador+1;
          if not (trim(regDat.mensajeVendedor)='') then
          begin
            respuesta:= 'Respuesta: '+#13;
            respuesta:= respuesta+regDat.mensajeVendedor;
            listBoxConversaciones.Items.Add(respuesta);
          end;
          TDAColasParciales.Encolar(Conversaciones, regDat, regInd, posConv);
        end
        else
          cortar:= true;
      end;//While
  end;// Encontro
  MEConversaciones.cerrar(Conversaciones);
  end;

  // Comprobar si hubo mensajes
  if not ((comboboxVendedor.ItemIndex=0) or (comboboxComprador.ItemIndex=0) or (comboboxArticulo.ItemIndex=0)) then
    if (contador=0) then
      showmessage('No hay conversaciones.');
end;

function TformConversacionesAdmin.obtenerIDArticulo(mensaje:string):string;
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
  obtenerIDArticulo:=trim(devolver);
end; //obtenerID

procedure TformConversacionesAdmin.btnAgregarClick(Sender: TObject);
var
  regVendedor, regComprador: MEUsuario.tiporegListaDatosHash;
  pos, posEnc: integer;
  idArticulo: string;
  regIndPub: MEArticulosPublicados.tipoRegIndice;
  regDatPub: MEArticulosPublicados.tipoRegDatos;
  regConInd: MEConversaciones.tipoRegIndice;
  regConDat: MEConversaciones.tipoRegDatos;

  posConv, posEnconlar, posInd, posMensaje: integer;
  cortar, cortarDatos, respondio: boolean;
  regNuloIndice: MEConversaciones.tipoRegIndice;
  regNuloDatos: MEConversaciones.TipoRegDatos;
  regInd: MEConversaciones.tipoRegIndice;
  regDat: MEConversaciones.tipoRegDatos;
  pregunta, respuesta: string;
begin
if (comboboxVendedor.ItemIndex=0) or (comboboxComprador.ItemIndex=0) or (comboboxArticulo.ItemIndex=0) then
    showmessage('Seleccione las opciones.')
  else if (comboboxVendedor.Items[comboboxVendedor.ItemIndex]=comboboxComprador.items[comboboxComprador.ItemIndex]) then
    showmessage('Seleccione diferencies usuarios.')
  else
  begin
    //Usuarios
    MEUsuario.abrirME(usuario);
    MEUsuario.Buscar(Usuario, comboboxVendedor.Items[comboboxVendedor.itemindex], pos);
    MEUsuario.CapturarInfo(Usuario, regVendedor, pos);
    MEUsuario.Buscar(Usuario, comboboxComprador.Items[comboboxComprador.itemindex], pos);
    MEUsuario.CapturarInfo(Usuario, regComprador, pos);
    MEUsuario.CerrarMe(usuario);

    //Articulo
    idArticulo:= obtenerIDArticulo(comboboxArticulo.Items[comboboxArticulo.itemindex]);
    MEArticulosPublicados.abrir(Publicado);
    MEArticulosPublicados.buscarCategorias(Publicado, idArticulo, pos);
    MEArticulosPublicados.capturarCategorias(Publicado, pos, regIndPub);
    MEArticulosPublicados.capturarArticulo(Publicado, regIndPub, regDatPub);
    MEArticulosPublicados.cerrar(Publicado);

    // Agregar conversacion
    //showmessage('ID ARTICULo '+(regDatPub.Clave));
    regConInd.clave:=strtoint(regDatPub.Clave);
    regConInd.idCliente:= regComprador.IDUsuario;
    regConDat.mensajeComprador:='Hola. Me llamo '+regComprador.nombre+' - Fecha: '+datetimetostr(now);
    MEConversaciones.abrir(Conversaciones);

    if MEConversaciones.buscar(Conversaciones, strtoint(regDatPub.Clave), regComprador.IDUsuario, posEnc) then
      MEConversaciones.insertarMensaje(Conversaciones,regConDat,regConInd,posEnc)
    else
      MEConversaciones.insertar(Conversaciones, regConInd, regConDat);

    if MEConversaciones.buscar(Conversaciones, strtoint(regDatPub.Clave), regComprador.IDUsuario, posEnc) then
    begin
      regNuloDatos.clave:=-1;
      regNuloDatos.siguiente:=-1;
      cortar:= false;
      respondio:= false;
      regInd:= MEConversaciones.obtenerIndice(Conversaciones, posEnc);
      TDAColasParciales.Encolar(Conversaciones, regNuloDatos, regInd, posEnc);
      while not cortar do
      begin
          posInd:= TDAColasParciales.Frente(Conversaciones, regDat, regInd);
          TDAColasParciales.Decolar(Conversaciones, regInd, posEnc);
          if regDat.clave<>-1 then
          begin
            if (regDat.clave=regConInd.ultimoNumero) then
            begin
              if(trim(regDat.mensajeVendedor)='') then
              begin
                regDat.mensajeVendedor:= 'Gracias. Me llamo '+regVendedor.nombre+' - Vendo '+regDatPub.NombreArticulo;
                respondio:=true;
              end;
            end;// Es mensaje
            TDAColasParciales.Encolar(Conversaciones, regDat, regInd, posEnc);
          end
          else
            cortar:= true;
      end;//While
    end;// Encontro
    MEConversaciones.cerrar(Conversaciones);
  end;//If Completado ComboBox
end;

procedure TformConversacionesAdmin.listboxConversacionesDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
aItem : String;
begin
aItem := listBoxConversaciones.Items[Index];
DrawText(listBoxConversaciones.Canvas.Handle,PChar(aItem), StrLen(PChar(aItem)), Rect, DT_WORDBREAK);
end;

procedure TformConversacionesAdmin.listboxConversacionesMeasureItem(
  Control: TWinControl; Index: Integer; var Height: Integer);
var
aItem : String;
aRect: TRect;
begin
aRect := listBoxConversaciones.ClientRect;
aItem := listBoxConversaciones.Items[Index];
Height := DrawText(listBoxConversaciones.Canvas.Handle,PChar(aItem), StrLen(PChar(aItem)),aRect,DT_WORDBREAK);

end;

end.
