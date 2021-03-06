unit Menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MEArticulosPublicados, MECategorias, Login, MEConversaciones, TDACola, TDAColasParciales, MEusuario;

type
  TformMenuUsuario = class(TForm)
    btnActivar: TButton;
    btnPausar: TButton;
    btnDetalles: TButton;
    btnConversaciones: TButton;
    labelCodigo: TLabel;
    labelEstado: TLabel;
    procedure btnDetallesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPausarClick(Sender: TObject);
    procedure btnActivarClick(Sender: TObject);
    procedure btnConversacionesClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure clickConversacion();
  end;

var
  formMenuUsuario: TformMenuUsuario;

implementation

uses PublicacionSeleccionada, Publicaciones, PantallaUsuario, Conversacion;

{$R *.dfm}

procedure TformMenuUsuario.btnDetallesClick(Sender: TObject);
var
  regInd: MEArticulosPublicados.tipoRegIndice;
  regDatos: MEArticulosPublicados.tipoRegDatos;
  regCat: MECategorias.tipoRegDatos;
  pos: integer;
  regCate: MECategorias.tipoRegDatos;
begin
  if (formMenuUsuario.labelEstado.caption='Pausado') or  (formMenuUsuario.labelEstado.caption='Bloqueado') or  (formMenuUsuario.labelEstado.caption='Anulado') or  (formMenuUsuario.labelEstado.caption='Vendido') then
    begin
      formPubSeleccionada.btnModificar.Enabled:= false;
      formPubSeleccionada.btnEliminar.Enabled:= false;
    end
    else
    begin
      formPubSeleccionada.btnModificar.Enabled:= true;
      formPubSeleccionada.btnEliminar.Enabled:= true;
    end;
  if formMenuUsuario.Caption<>'' then
  begin
    formPublicaciones.Enabled:= true;
    formMenuUsuario.Close;
    formPubSeleccionada.show;
    MEArticulosPublicados.abrir(Publicado);

    formPubSeleccionada.labelPosNodo.Caption:= formMenuUsuario.labelCodigo.Caption;

    MEArticulosPublicados.buscarCategorias(Publicado, formMenuUsuario.labelCodigo.Caption , pos);
    MEArticulosPublicados.capturarCategorias(Publicado, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Publicado, regInd, regDatos);

    formPubSeleccionada.CheckBoxMostrarImg.checked:= false;
    formPubSeleccionada.editTitulo.Text:= regDatos.nombreArticulo;
    formPubSeleccionada.editDescripcion.Text:= regDatos.descripcion;
    formPubSeleccionada.editFechaCreacion.Text:= datetostr(regDatos.fechapublicacion);
    formPubSeleccionada.Calendario.Date:= regDatos.fechacierre;
    if regDatos.tipoArticulo=1 then
    begin
      formPubSeleccionada.RadioButtonNuevo.Checked:= false;
      formPubSeleccionada.RadioButtonUsado.Checked:= true;
    end
    else
    begin
      formPubSeleccionada.RadioButtonNuevo.Checked:= true;
      formPubSeleccionada.RadioButtonUsado.Checked:= false;
    end;


    MECategorias.AbrirMe(Categoria);
    MECategorias.Buscar(Categoria, regDatos.IDCategoria, pos);
    MECategorias.Capturar(Categoria, pos, regCate);
    MECategorias.CerrarMe(Categoria);
    formPubSeleccionada.labelCat.caption:= regCate.categoria;
    formPubSeleccionada.labelIDCategoria.Caption:= inttostr(regDatos.IDCategoria);

    formPubSeleccionada.imgPublicacion.Picture.LoadFromFile(regDatos.nombreFoto);
    formPubSeleccionada.labelGuardarImg.Caption:= regDatos.nombreFoto;
    formPubSeleccionada.editPrecio.Text:= floattostr(regDatos.precio);

    MEArticulosPublicados.cerrar(Publicado);
  end;

end;

procedure TformMenuUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  formMenuUsuario.Hide;
  formPublicaciones.enabled:= true;
  formPublicaciones.show;
end;

procedure TformMenuUsuario.btnPausarClick(Sender: TObject);
var
  pos: integer;
  regInd: MEArticulosPublicados.tipoRegIndice;
  regDatos: MEArticulosPublicados.tipoRegDatos;
begin
MEArticulosPublicados.abrir(Publicado);
MEArticulosPublicados.buscarCategorias(Publicado, labelCodigo.Caption, pos);
MEArticulosPublicados.capturarCategorias(Publicado, pos, regInd);
MEArticulosPublicados.capturarArticulo(Publicado, regInd, regDatos);
regDatos.estadoPublicacion:= 2; // publicacion pausada
regDatos.Clave :=          regDatos.Clave;


MEArticulosPublicados.modificar(Publicado, regInd, regDatos);
MEArticulosPublicados.cerrar(Publicado);

formUsuario.cargarPublicaciones();

formMenuUsuario.Close;
formPublicaciones.Enabled:= true;
formPublicaciones.show;
end;

procedure TformMenuUsuario.btnActivarClick(Sender: TObject);
var
  pos: integer;
  regInd: MEArticulosPublicados.tipoRegIndice;
  regDatos: MEArticulosPublicados.tipoRegDatos;
begin
MEArticulosPublicados.abrir(Publicado);
MEArticulosPublicados.buscarCategorias(Publicado, labelCodigo.Caption, pos);
MEArticulosPublicados.capturarCategorias(Publicado, pos, regInd);
MEArticulosPublicados.capturarArticulo(Publicado, regInd, regDatos);
regDatos.estadoPublicacion:= 1; // Publicacion publicada.


MEArticulosPublicados.modificar(Publicado, regInd, regDatos);
MEArticulosPublicados.cerrar(Publicado);

formUsuario.cargarPublicaciones();

formMenuUsuario.Close;
formPublicaciones.Enabled:= true;
formPublicaciones.show;

end;

procedure TformMenuUsuario.btnConversacionesClick(Sender: TObject);
var
  idArticulo: integer;
  idArticuloInd: string;
  posConv, posEnconlar, posInd, pos: integer;
  cortar, cortarDatos: boolean;
  regNuloIndice: MEConversaciones.tipoRegIndice;
  regNuloDatos, regDat: MEConversaciones.TipoRegDatos;
  regInd: MEConversaciones.tipoRegIndice;
  pregunta, respuesta: string;

  regPubInd: MEArticulosPublicados.tipoRegIndice;
  regPubDat: MEArticulosPublicados.tipoRegDatos;
  rc: MEConversaciones.tipoRegControl;

begin
  formPublicaciones.Enabled:= true;
  formPublicaciones.hide;
  formConversaciones.show;
  formMenuUsuario.hide;

  formConversaciones.editMensaje.Text:='';

  idArticuloInd:= labelCodigo.Caption;

  MEArticulosPublicados.abrir(Publicado);
  MEArticulosPublicados.buscarCategorias(Publicado, idArticuloInd, pos);
  MEArticulosPublicados.capturarCategorias(Publicado, pos, regPubInd);
  MEArticulosPublicados.capturarArticulo(Publicado, regPubInd, regPubDat);

  idArticulo:= strtoint(regPubDat.Clave);

  MEConversaciones.abrir(Conversaciones);
  //if MEConversaciones.buscarConversacion(Conversaciones, idArticulo, posConv) then showmessage('true') else showmessage('false');
  if MEConversaciones.buscarConversacion(Conversaciones, idArticulo, posConv) then
  begin
    regNuloIndice.clave:=-1;
    regNuloIndice.siguiente:=-1;
    cortar:= false;
    TDACola.encolar(Conversaciones, regNuloIndice, pos);

    while not cortar do
    begin
        posInd:= TDACola.Frente(Conversaciones, regInd);
        TDACola.Decolar(Conversaciones);
        if (regInd.clave=idArticulo) then
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
              pregunta:= inttostr(regDat.clave)+'|'+inttostr(regInd.idCliente)+'|    '+DateTimeToStr(regDat.fecha)+#13;
              pregunta:= pregunta+'Pregunta: '+#13+regDat.mensajeComprador;
              formConversaciones.listBoxConversaciones.Items.Add(pregunta);
              if not (trim(regDat.mensajeVendedor)='') then
              begin
                respuesta:= 'Respuesta: '+#13;
                respuesta:= respuesta+regDat.mensajeVendedor;
                formConversaciones.listBoxConversaciones.Items.Add(respuesta);
              end;
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
  MEConversaciones.cerrar(Conversaciones);
end;
procedure TformMenuUsuario.clickConversacion();
begin
  btnConversacionesClick(formMenuUsuario);
end;

end.
