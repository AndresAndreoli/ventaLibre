unit PubSeleccionada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, MEConversaciones, MEUsuario, TDAColasParciales, TiposYconstantes, MEArticulosPublicados,MEVentas, MECategorias, TDAColaV, TDAColasParcialesV;

type
  TformPubComprar = class(TForm)
    imgArticulo: TImage;
    labelTitulo: TLabel;
    editDescripcion: TMemo;
    Label1: TLabel;
    labelEstado: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    listPreguntas: TListBox;
    Label5: TLabel;
    editPreguntar: TEdit;
    btnPreguntar: TButton;
    panelPrecio: TPanel;
    btnComprar: TButton;
    Label6: TLabel;
    Label7: TLabel;
    labelVencimiento: TLabel;
    MainMenu1: TMainMenu;
    Volver1: TMenuItem;
    labelVendedor: TLabel;
    labelComprador: TLabel;
    labeIDArticulo: TLabel;
    labelIDVendedor: TLabel;
    labelClaveArticulo: TLabel;
    Label9: TLabel;
    procedure Volver1Click(Sender: TObject);
    procedure editPreguntarClick(Sender: TObject);
    procedure btnPreguntarClick(Sender: TObject);
    procedure btnComprarClick(Sender: TObject);
    procedure listPreguntasDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure listPreguntasMeasureItem(Control: TWinControl;
      Index: Integer; var Height: Integer);
  private
    { Private declarations }
  public
    procedure cargarChat();
  end;

var
  formPubComprar: TformPubComprar;

implementation

uses PantallaUsuario, Login;

{$R *.dfm}

procedure TformPubComprar.Volver1Click(Sender: TObject);
begin
  formPubComprar.close;
  formUsuario.show;
  editPreguntar.Text:='Pregunta';
  editPreguntar.Font.Color:= clMedGray;
end;

procedure TformPubComprar.editPreguntarClick(Sender: TObject);
begin
  editPreguntar.Text:='';
  editPreguntar.Font.Color:= clWindowText;
end;

procedure TformPubComprar.btnPreguntarClick(Sender: TObject);
var
  regDat: MEConversaciones.tipoRegDatos;
  regInd: MEConversaciones.tipoRegIndice;
  pos: integer;
  reg: MEUsuario.tiporegListaDatosHash;
  mensaje: string;
begin
if (trim(editPreguntar.Text)='') then
  showmessage('Coloca un mensaje.')
else
begin
  MEConversaciones.abrir(Conversaciones);
  regDat.mensajeComprador:= editPreguntar.Text;
  MEUsuario.AbrirMe(Usuario);
  MEUsuario.Buscar(Usuario, labelComprador.Caption, pos);
  MEUsuario.CapturarInfo(Usuario, reg, pos);
  mensaje:= FormatDateTime('dd/mm/yyyy hh:mm', now)+ '   |   '+reg.nombre+':'+#13;
  mensaje:= mensaje +editPreguntar.Text;
  listPreguntas.Items.Add(mensaje);
  MEUsuario.CerrarMe(Usuario);
  // showmessage('id articulo '+(labeIDArticulo.caption)+' idCliente '+inttostr(reg.IDUsuario));
  //if  MEConversaciones.buscar(Conversaciones, strtoint(labeIDArticulo.caption), reg.IDUsuario, pos) then showmessage('true') else showmessage('false');
  if not MEConversaciones.buscar(Conversaciones, strtoint(labeIDArticulo.caption), reg.IDUsuario, pos) then
  begin
    regInd.clave:= strtoint(labeIDArticulo.caption);
    regInd.idCliente:= reg.IDUsuario;
    MEConversaciones.insertar(Conversaciones, regInd, regDat);
  end
  else begin
    MEConversaciones.insertarMensaje(Conversaciones, regDat, regInd, pos);
  end;

  if not MEConversaciones.buscar(Conversaciones, strtoint(labeIDArticulo.caption), reg.IDUsuario, pos) then
   messagedlg('Error. Reenvie el mensaje.',mtWarning, mbokcancel,0)
  else
    editPreguntar.Text:= '';

  MEConversaciones.cerrar(Conversaciones);
end;
end;

procedure TformPubComprar.btnComprarClick(Sender: TObject);
var
  pos: integer;
  regPubInd: MEArticulosPublicados.tipoRegIndice;
  regPubDat: MEArticulosPublicados.tipoRegDatos;
  regVenDat: MEVentas.tipoRegDatos;
  regVenInd: MEVentas.tipoRegIndice;
  regUsuDat, regUsuDat2: MEUsuario.tiporeglistadatoshash;
  regCatDat: MECategorias.tipoRegDatos;
  vendido: boolean;
begin
//++++++++++++++++++++++++++++++++++++++++++++++++++++++ CORROBORAR QUE EL ARTICULO NO HAYA SIDO YA COMPRADO
  MEArticulosPublicados.abrir(Publicado);
  MEArticulosPublicados.buscarCategorias(Publicado, labelClaveArticulo.Caption, pos);
  MEArticulosPublicados.capturarCategorias(Publicado, pos, regPubInd);
  MEArticulosPublicados.capturarArticulo(Publicado, regPubind, regPubDat);
  if regPubDat.estadoPublicacion<>1 then
    vendido:= true else vendido:= false;
  MEArticulosPublicados.cerrar(Publicado);

  if not vendido then
  begin

    if messagedlg('Deseas comprar el articulo?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) = mrYes then
    begin
      // Comprador
      MEUsuario.AbrirMe(Usuario);
      MEUsuario.Buscar(Usuario, labelComprador.Caption, pos);
      MEUsuario.CapturarInfo(Usuario, regUsuDat, pos);
      MEUsuario.Buscar(Usuario, labelVendedor.Caption, pos);
      MEUsuario.CapturarInfo(Usuario, regUsuDat2, pos);
      MEUsuario.CerrarMe(Usuario);

      // Articulo
      MEArticulosPublicados.abrir(Publicado);
      MEArticulosPublicados.buscarCategorias(Publicado, labelClaveArticulo.Caption, pos);
      MEArticulosPublicados.capturarCategorias(Publicado, pos, regPubInd);
      MEArticulosPublicados.capturarArticulo(Publicado, regPubind, regPubDat);
      regPubDat.estadoPublicacion:=3; //Vendido
      regPubDat.fechacierre:= now(); //La guardo para utilizarla despues
      regPubDat.IDcomprador:= regUsuDat.IDUsuario;
      regPubDat.mailComprador:= labelComprador.Caption;
      regPubDat.mailVendedor:= labelVendedor.Caption;
      MEArticulosPublicados.modificar(Publicado, regPubInd, regPubDat);
      MEArticulosPublicados.cerrar(Publicado);

      // Categoria
      MECategorias.AbrirMe(Categoria);
      MECategorias.Buscar(Categoria, regPubDat.IDCategoria, pos);
      MECategorias.Capturar(Categoria, pos, regCatDat);
      MECategorias.CerrarMe(Categoria);

      // Construyo Registro Datos Ventas
      //regVenDat.IDComprador:= regUsuDat.IDUsuario;
      regVenDat.ClaveComprador:= labelComprador.Caption;
      regVenDat.Clave:= strtoint(labeIDArticulo.Caption);
      regVenDat.nombreArticulo:= regPubDat.NombreArticulo;
      regVenDat.precioVenta:= regPubDat.precio;
      regVenDat.fechaPublicacion:= regPubDat.fechapublicacion;
      regVenDat.fechaVenta:= now();
      regVenDat.tipoArticulo:= regPubDat.tipoArticulo;
      regVenDat.porcentajeComision:= regCatDat.comision;
      regVenDat.comisionCobrada:= false;
      regVenDat.calificacion:= 0;
      regVenDat.IDVendedor:= regUsuDat2.IDUsuario;
      regVenInd.clave:= regUsuDat.IDUsuario;

      MEVentas.abrir(Venta);

      if not MEVentas.buscar(Venta, regUsuDat.IDUsuario, pos) then
        MEVentas.insertar(Venta, regVenInd, regVenDat)
      else
        MEVentas.insertarVenta(Venta, regVenDat, regVenInd, pos);

      MEVentas.cerrar(Venta);

      showmessage('Articulo comprado exitosamente');
      formPubComprar.Close;
      formLogin.cargarPublicacionesInicio();
      formUsuario.show;
      editPreguntar.Text:='';
    end;//If - Confimacion compra
  end else//   If vendido
  begin
    showmessage('Articulo no disponible para su compra.');
    formPubComprar.Close;
    formLogin.cargarPublicacionesInicio();
    formUsuario.show;
    editPreguntar.Text:='';
  end;

end;

procedure TformPubComprar.cargarChat();
var
  mensaje: string;
  posUsu, posConv, idComprador: integer;
  regUsu: MEUsuario.tiporegListaDatosHash;
  regInd: MEConversaciones.tipoRegIndice;
  regDat, regNulo: MEConversaciones.tipoRegDatos;
  corte: boolean;
begin
  listPreguntas.Clear;
  if not (formUsuario.btnRegistrarse.Visible) then
  begin
    MEUsuario.AbrirMe(Usuario);
    MEUsuario.Buscar(Usuario, formUsuario.labelMail.Caption, posUsu);
    MEUsuario.CapturarInfo(Usuario, regUsu, posUsu);
    idComprador:= regUsu.IDUsuario;
    MEUsuario.CerrarMe(Usuario);

    MEConversaciones.abrir(Conversaciones);

    if MEConversaciones.buscar(Conversaciones, strtoint(labeIDArticulo.caption), idComprador, posConv) then
    begin
    corte:= false;
    regNulo.clave:= -1;
    regNulo.siguiente:= -1;
    regInd:= MEConversaciones.obtenerIndice(Conversaciones, posConv);
    TDAColasParciales.Encolar(Conversaciones, regNulo, regInd, posConv);
    while not corte do
    begin
      TDAColasParciales.Frente(Conversaciones, regDat, regInd);
      TDAColasParciales.Decolar(Conversaciones, regInd, posConv);
      if regDat.clave<>-1 then
      begin
         mensaje:= FormatDateTime('dd/mm/yyyy hh:mm', now)+ '   |   '+regUsu.nombre+':'+#13;
         mensaje:= mensaje +'Pregunta: '+regDat.mensajeComprador;
         listPreguntas.Items.Add(mensaje);

         if not (regDat.mensajeVendedor='') then
         begin
           mensaje:= 'Respuesta:'+#13;
           mensaje:= mensaje + regDat.mensajeVendedor;
           listPreguntas.Items.Add(mensaje);
         end;

        TDAColasParciales.Encolar(Conversaciones, regDat, regInd, posConv);
      end
      else
        corte:=true;
    end; //While-corte

    end; // Conversacion Encontrada

    MEConversaciones.cerrar(Conversaciones)
  end;
end;

procedure TformPubComprar.listPreguntasDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
  var
aItem : String;
begin
aItem := listPreguntas.Items[Index];
DrawText(listPreguntas.Canvas.Handle,PChar(aItem), StrLen(PChar(aItem)), Rect, DT_WORDBREAK);
end;

procedure TformPubComprar.listPreguntasMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
var
aItem : String;
aRect: TRect;
begin
aRect := listPreguntas.ClientRect;
aItem := listPreguntas.Items[Index];
Height := DrawText(listPreguntas.Canvas.Handle,PChar(aItem), StrLen(PChar(aItem)),aRect,DT_WORDBREAK);

end;

end.
