unit Registrarse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, TiposYconstantes, ExtDlgs, jpeg, MEUsuario, Login;

type
  TformRegistrarse = class(TForm)
    Label1: TLabel;
    labelEmail: TLabel;
    labelClave: TLabel;
    labelConfClave: TLabel;
    labelNombre: TLabel;
    labelApellido: TLabel;
    labelDomicilio: TLabel;
    labelProvincia: TLabel;
    editEmail: TEdit;
    editClave: TEdit;
    editConfClave: TEdit;
    editNombre: TEdit;
    editApellido: TEdit;
    editDomicilio: TEdit;
    comboBoxProvincias: TComboBox;
    btnRegistrar: TButton;
    labelFoto: TLabel;
    imgPerfil: TImage;
    btnBuscarFoto: TButton;
    btnVolver: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure btnVolverClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarFotoClick(Sender: TObject);
    procedure btnRegistrarClick(Sender: TObject);
  private
    function guardarImagenCarpeta(rutaOrigen:String):String;
  public
    // Variable
      rutaOrigen: string;
  end;

var
  formRegistrarse: TformRegistrarse;

implementation

uses PantallaUsuario;


{$R *.dfm}

procedure TformRegistrarse.btnVolverClick(Sender: TObject);
begin
  // Limpiar campos
  editEmail.Clear;
  editClave.Clear;
  editConfClave.Clear;
  editNombre.Clear;
  editApellido.Clear;
  editDomicilio.Clear;
  comboboxProvincias.ItemIndex:= 0;
  imgPerfil.Picture.LoadFromFile(TiposYconstantes.imgAdmin);
  comboboxProvincias.ItemIndex := -1;

  formRegistrarse.Close;
  formLogin.show;
end;

procedure TformRegistrarse.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to length(TiposYconstantes.vectorProvincias)-1 do
    comboBoxProvincias.Items.Add(TiposYconstantes.vectorProvincias[i]);
end;//  FormCreate

procedure TformRegistrarse.btnRegistrarClick(Sender: TObject);
var
  regNuevoUsuario: MEUsuario.tiporegListaDatosHash;
  pos: tipoposicion;
begin
  MEUsuario.AbrirMe(Usuario);
  if (editEmail.Text<>'') and (editClave.Text<>'') and (editConfClave.Text<>'') and (editNombre.Text<>'') and (editApellido.Text<>'') and (comboBoxProvincias.ItemIndex<>-1) and (rutaOrigen<>'') and (editDomicilio.Text<>'') then
    begin
        if emailValido(editEmail.text) then
         if not(MEUsuario.Buscar(Usuario, editEmail.text, pos)) then
          if (editClave.Text<>editConfClave.Text) then
            showmessage('Las contraseñas no coinciden.')
          else
            begin
              regNuevoUsuario.Clave :=         lowercase(editEmail.Text);                                       //Mail
              regNuevoUsuario.contrasena :=    MEUsuario.encriptar(editClave.text, MEUsuario.llaveCifrado);     //Contrasena
              regNuevoUsuario.nombre :=        lowercase(editNombre.text);                                      //Nombre
              regNuevoUsuario.apellido :=      lowercase(editApellido.text);                                    //Apellido
              regNuevoUsuario.domicilio :=     lowercase(editdomicilio.Text);                                   //Docimilio
              regNuevoUsuario.provincia :=     (comboBoxProvincias.ItemIndex);                                  //Provincia
              regNuevoUsuario.fechaAlta :=     now();                                                           //Fecha Alta
              regNuevoUsuario.fechaConexion := now();                                                           //Fecha Ultima Conexion
              regNuevoUsuario.estado:=         false;                                                           //Estado Actovi/Desactivo
              regNuevoUsuario.foto :=          guardarImagenCarpeta(rutaOrigen);                                //Foto
              regNuevoUsuario.IDUsuario :=     0;                                                               // IDUsuario -> se agrega en MEUsuario
              regNuevoUsuario.bloqueado :=     false;                                                           // Usuario Bloqueado                                               

              if Dialogs.MessageDlg('Deseas registrarte?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
              begin
                MEUsuario.insertar(Usuario, regNuevoUsuario);

                showmessage('Usuario registrado exitosamente.');

                // Limpiar campos
                editEmail.Clear;
                editClave.Clear;
                editConfClave.Clear;
                editNombre.Clear;
                editApellido.Clear;
                editDomicilio.Clear;
                comboboxProvincias.ItemIndex:= 0;
                imgPerfil.Picture.LoadFromFile(TiposYconstantes.imgAdmin);
                comboboxProvincias.ItemIndex := -1;

                // Setear botones
                formUsuario.checkBoxTipoUsuario.Checked:= false;
                formUsuario.btnMenuPerfil.Visible:= true;
                formUsuario.btnMainPublicaciones.Visible:= true;
                formUsuario.btnMainVender.Visible:= true;
                formUsuario.btnMisCompras.Visible:= true;
                formUsuario.btnMisVentas.Visible:= true;
                formUsuario.checkBoxTipoUsuario.Checked:= false;
                formUsuario.btnRegistrarse.Visible:= false;

                formLogin.editMail.text := '';
                formLogin.editClave.Text := '';

                formRegistrarse.close;
                formLogin.Show;
              end// Confirmacion de INSERTAR nuevo usuario
            end // COMPROBAR USUARIO EXISTENTE
          else
            showmessage('El usuario ya se encuentra registrado.')
        else
          begin

            showmessage('Formato de mail invalido.');
          end;
    end // COMPROBAR CAMPOS VACIOS
  else
    showmessage('Complete todos los campos.');

  MEUsuario.CerrarMe(Usuario);
end;

// CARGAR FOTO PERFIL
procedure TformRegistrarse.btnBuscarFotoClick(Sender: TObject);
var
  OpenDlg : TOpenDialog;
begin
  //abro un opendlg para buscar el archivo
  OpenDlg := TOpenDialog.Create(Self);
  if OpenDlg.Execute then
    //verifico que sea un archivo .jpg
    if ((ExtractFileExt(OpenDlg.FileName))='.jpg') then
      begin
        imgPerfil.Picture.LoadFromFile(OpenDlg.FileName);
        rutaOrigen:= OpenDlg.FileName;//guardo la direccion del archivo
      end
    else
      messagedlg('Se permiten archivos .jpg',mtError, [mbOk], 0);
end; // btnBuscarFotoClick

function TformRegistrarse.guardarImagenCarpeta(rutaOrigen:String):String;
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






