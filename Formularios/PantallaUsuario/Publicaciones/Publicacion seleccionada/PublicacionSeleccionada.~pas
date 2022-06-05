unit PublicacionSeleccionada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, TiposYconstantes, MEArticulosPublicados;

type
  TformPubSeleccionada = class(TForm)
    labelTitulo: TLabel;
    editTitulo: TEdit;
    labelDescripcion: TLabel;
    editDescripcion: TMemo;
    labelCategoria: TLabel;
    ComboBoxCategoria: TComboBox;
    btnVolver: TButton;
    labelFechaCierre: TLabel;
    Calendario: TMonthCalendar;
    GroupBox1: TGroupBox;
    RadioButtonNuevo: TRadioButton;
    RadioButtonUsado: TRadioButton;
    labelFoto: TLabel;
    imgPublicacion: TImage;
    btnCargar: TButton;
    btnModificar: TButton;
    btnEliminar: TButton;
    labelPrecio: TLabel;
    Label1: TLabel;
    editPrecio: TEdit;
    labelCreacion: TLabel;
    editFechaCreacion: TEdit;
    CheckBoxMostrarImg: TCheckBox;
    labelGuardarImg: TLabel;
    labelPosNodo: TLabel;
    LabelCat: TLabel;
    labelIDCategoria: TLabel;
    procedure btnVolverClick(Sender: TObject);
    procedure btnCargarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
  private
    function guardarImagenCarpeta(rutaOrigen: string): string;
  public
    rutaOrigen: string;
  end;

var
  formPubSeleccionada: TformPubSeleccionada;

implementation

uses Publicaciones, Login, PantallaUsuario, Menu;

{$R *.dfm}

procedure TformPubSeleccionada.btnVolverClick(Sender: TObject);
begin
  formPubSeleccionada.Close;
  formUsuario.btnMainPublicaciones.Click;
  formPublicaciones.show;
end;

// CARGAR FOTO PERFIL
procedure TformPubSeleccionada.btnCargarClick(Sender: TObject);
var
  OpenDlg : TOpenDialog;
begin
  //abro un opendlg para buscar el archivo
  OpenDlg := TOpenDialog.Create(Self);
  if OpenDlg.Execute then
    //verifico que sea un archivo .jpg
    if ((ExtractFileExt(OpenDlg.FileName))='.jpg') then
      begin
        imgPublicacion.Picture.LoadFromFile(OpenDlg.FileName);
        rutaOrigen:= OpenDlg.FileName;//guardo la direccion del archivo
        CheckBoxMostrarImg.Checked:= true;
      end
    else
      messagedlg('Se permiten archivos .jpg',mtError, [mbOk], 0);
end; // btnBuscarFotoClick

function TformPubSeleccionada.guardarImagenCarpeta(rutaOrigen:String):String;
var
  nuevoNombre,rutaDestino:String;
  i:integer;
begin
//creo un nuevo nombre aleatorio para la imagen
nuevoNombre:='';
  if not((length(rutaOrigen)=0)) then
    begin
    Randomize;
     for i:=0 to 6 do
          nuevoNombre:=nuevoNombre+(char(64+Random(26)));
    //muevo la imagen a la carpeta predeterminada
    rutaDestino:=TiposYconstantes.carpImagenes;
    CopyFile( PChar(rutaOrigen), PChar(rutaDestino+nuevoNombre+'.jpg'), False );
    nuevoNombre:=nuevoNombre+'.jpg';//guardo el nuevo nombre para meterlo en el metodo
    checkboxMostrarimg.Checked:= true;
    end;
guardarImagenCarpeta:=rutaDestino+nuevoNombre;
end;//  guardarImagenCarpeta

procedure TformPubSeleccionada.btnEliminarClick(Sender: TObject);
var
  regIndCat, regIndVen: MEArticulosPublicados.tiporegIndice;
  regDat: MEArticulosPublicados.tipoRegDatos;
  pos: integer;
begin
  if Dialogs.MessageDlg('Deseas eliminar la publicacion?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    MEArticulosPublicados.abrir(Publicado);
    //if MEArticulosPublicados.buscarCategorias(Publicado, labelPosNodo.Caption, pos) then showmessage('trueee');
    MEArticulosPublicados.buscarCategorias(Publicado, labelPosNodo.Caption, pos);
    MEArticulosPublicados.capturarCategorias(Publicado, pos, regIndCat); // Capturo el registro indice de arbolCategoria
    MEArticulosPublicados.capturarArticulo(Publicado, regIndCat, regDat);
    //if MEArticulosPublicados.buscarVendedor(Publicado, (inttostr(regdat.IDVendedor) + regDat.Clave), pos) then showmessage('true');
    MEArticulosPublicados.buscarVendedor(Publicado, (inttostr(regdat.IDVendedor) + regDat.Clave), pos);
    MEArticulosPublicados.capturarVendedor(Publicado, pos, regIndVen); // Capturo el registro indice de arbolVendedor
    MEArticulosPublicados.eliminar(Publicado, regIndCat, regIndVen);
    MEArticulosPublicados.cerrar(Publicado);

    showmessage('Publicacion borrada correctamente');
    formUsuario.btnMainPublicaciones.Click;
    formPubSeleccionada.Close;
  end; //MessageDlg - Confirmar Eliminacion
end;

procedure TformPubSeleccionada.btnModificarClick(Sender: TObject);
var
  pos, pruebaInt, idCategoria: integer;
  regInd: MEArticulosPublicados.tipoRegIndice;
  regDatos: MEArticulosPublicados.tipoRegDatos;
  nombreCat: string;
begin
if (editTitulo.Text='') or (editDescripcion.Text='') or (comboboxCategoria.ItemIndex=-1) or not(radiobuttonNuevo.Checked or radiobuttonUsado.Checked)  or (editPrecio.Text='') then
    showmessage('Complete todos los campos.')
  else
    if (calendario.Date < now()) then
      showmessage('El dia de cierre de publicacion tiene que ser mayor al dia actual de publicacion.')
    else
    begin
        try
          pruebaInt:=strtoint(EditPrecio.Text);
        except on E:EConvertError
        do
          begin
            Showmessage('Error. Formato invalido(campo numerico).');
            editPrecio.SetFocus;
          end; // do
        end;// try
        // ======================================================================= PASO VALIDACION DE CAMPOS
        if comboboxCategoria.ItemIndex<>0 then
        begin
          idCategoria:= strtoint(trim(Copy((comboboxCategoria.Items[comboboxCategoria.ItemIndex]),0,2)));
          nombreCat:= (trim(Copy((comboboxCategoria.Items[comboboxCategoria.ItemIndex]),4,length(comboboxCategoria.Items[comboboxCategoria.ItemIndex]))));
          labelcat.Caption:= nombreCat;
        end;

        MEArticulosPublicados.abrir(Publicado);
        MEArticulosPublicados.buscarCategorias(Publicado, labelPosNodo.Caption, pos); // Busco la posInd de la Publicacion
        MEArticulosPublicados.capturarCategorias(Publicado, pos, regInd);
        MEArticulosPublicados.capturarArticulo(Publicado, regInd, regDatos);

        if checkBoxMostrarImg.Checked then
          deletefile(regDatos.nombreFoto); // Borrar foto antigua
        if comboboxCategoria.ItemIndex<>0 then
          regDatos.IDCategoria := idCategoria;
        regDatos.NombreArticulo:= editTitulo.Text;
        regDatos.descripcion:= editDescripcion.Text;
        regDatos.precio:= strtoint(editPrecio.Text);
        regDatos.fechapublicacion:= now();
        regDatos.fechacierre:= calendario.Date;
        if RadioButtonNuevo.Checked then
          regDatos.tipoArticulo:= 2
        else
          regDatos.tipoArticulo:= 1;
        regDatos.estadoPublicacion:= 1;
        if checkBoxMostrarImg.Checked then
          regDatos.nombreFoto := guardarImagenCarpeta(rutaOrigen)                           
        else
          regDatos.nombreFoto  := labelGuardarImg.Caption;
        MEArticulosPublicados.modificar(Publicado, regInd, regDatos);
        MEArticulosPublicados.cerrar(Publicado);

        showmessage('Publicacion modificada correctamente');
    end; // Validar campos vacios
end;// btnPublicarClick
end.
