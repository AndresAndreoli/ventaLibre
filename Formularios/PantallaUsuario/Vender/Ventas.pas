unit Ventas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, TiposYconstantes, MEArticulosPublicados, MEUsuario,
  ComCtrls;

type
  TformVentas = class(TForm)
    labelTitulo: TLabel;
    editTitulo: TEdit;
    labelFoto: TLabel;
    imgArticulo: TImage;
    btnCargar: TButton;
    labelDescripcion: TLabel;
    editDescripcion: TMemo;
    btnVolver: TButton;
    labelCategoria: TLabel;
    comboBoxCategoria: TComboBox;
    RadioGroupUsado: TRadioGroup;
    RadioButtonNuevo: TRadioButton;
    radiobuttonUsado: TRadioButton;
    labelPrecio: TLabel;
    Label1: TLabel;
    btnPublicar: TButton;
    editPrecio: TEdit;
    labelGuardarImagen: TLabel;
    Calendario: TMonthCalendar;
    labelFechaVencimiento: TLabel;
    procedure btnVolverClick(Sender: TObject);
    procedure btnPublicarClick(Sender: TObject);
    procedure btnCargarClick(Sender: TObject);
  private
    function guardarImagenCarpeta(rutaOrigen:String):String;
  public
    // Variable
      rutaOrigen: string;
  end;

var
  formVentas: TformVentas;

implementation

uses PantallaUsuario, Login;

{$R *.dfm}

procedure TformVentas.btnVolverClick(Sender: TObject);
begin
  formVentas.Close;
  formUsuario.show;
  formLogin.cargarPublicacionesInicio();
end;

procedure TformVentas.btnPublicarClick(Sender: TObject);
var
  imagenDefault: string;
  pruebaInt, pos, idArticulo, idVendedor: integer;
  regArt, regDatos: MEArticulosPublicados.TipoRegDatos;
  regUsu: MEUsuario.tiporegListaDatosHash;
  regInd: MEArticulosPublicados.TipoRegIndice;
begin
  imagenDefault:= TiposYconstantes.imgPub;
  if (editTitulo.Text='') or (editDescripcion.Text='') or (comboboxCategoria.ItemIndex=-1) or not(radiobuttonNuevo.Checked or radiobuttonUsado.Checked) or (labelGuardarImagen.Caption=imagenDefault)  or (editPrecio.Text='') then
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

        MEUsuario.AbrirMe(Usuario);
        MEUsuario.Buscar(Usuario, formUsuario.labelMail.Caption, pos);
        MEUsuario.CapturarInfo(Usuario, regUsu, pos);
        MEUsuario.CerrarMe(Usuario);

        idVendedor:= regUsu.IDUsuario;
        idArticulo:= strtoint(trim(Copy((comboboxCategoria.Items[comboboxCategoria.ItemIndex]),0,2)));

        MEArticulosPublicados.abrir(Publicado);
                       
        regArt.IDCategoria := idArticulo;
        regArt.IDVendedor := idVendedor;
        regArt.NombreArticulo:= editTitulo.Text;
        regArt.descripcion:= editDescripcion.Text;
        regArt.precio:= strtoint(editPrecio.Text);
        regArt.fechapublicacion:= now();
        regArt.provincia:= regUsu.provincia;
        regArt.fechacierre:= calendario.date;
        regArt.IDcomprador:= 999999999;
        regArt.mailComprador:='';
        regArt.mailVendedor:='';

        if RadioButtonNuevo.Checked then
          regArt.tipoArticulo:= 2
        else
          regArt.tipoArticulo:= 1;

        regArt.estadoPublicacion:= 1;
        regArt.nombreFoto:= guardarImagenCarpeta(rutaOrigen);
        MEArticulosPublicados.insertar(Publicado, regArt, idVendedor, idArticulo);
        MEArticulosPublicados.cerrar(Publicado);

        showmessage('Publicacion creada correctamente.');

        // Limpiar campos
        editTitulo.Text:='';
        editDescripcion.Text:='';
        comboboxcategoria.ItemIndex:= -1;
        radiobuttonNuevo.Checked:= false;
        radiobuttonUsado.Checked:= false;
        editPrecio.Text:= '';
        formVentas.Calendario.Date:= now() + 90;
        imgArticulo.Picture.LoadFromFile(TiposYconstantes.imgPub);
        formVentas.labelGuardarImagen.Caption:= TiposYconstantes.imgPub;
        //formLogin.cargarPublicacionesInicio();
    end; // Validar campos vacios
end;// btnPublicarClick

// CARGAR FOTO PERFIL
procedure TformVentas.btnCargarClick(Sender: TObject);
var
  OpenDlg : TOpenDialog;
begin
  //abro un opendlg para buscar el archivo
  OpenDlg := TOpenDialog.Create(Self);
  if OpenDlg.Execute then
    //verifico que sea un archivo .jpg
    if ((ExtractFileExt(OpenDlg.FileName))='.jpg') then
      begin
        imgArticulo.Picture.LoadFromFile(OpenDlg.FileName);
        rutaOrigen:= OpenDlg.FileName;//guardo la direccion del archivo
        labelGuardarImagen.Caption:= 'otro';
      end
    else
      messagedlg('Se permiten archivos .jpg',mtError, [mbOk], 0);
end; // btnBuscarFotoClick

function TformVentas.guardarImagenCarpeta(rutaOrigen:String):String;
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
    end;
guardarImagenCarpeta:=rutaDestino+nuevoNombre;
end;//  guardarImagenCarpeta



end.
