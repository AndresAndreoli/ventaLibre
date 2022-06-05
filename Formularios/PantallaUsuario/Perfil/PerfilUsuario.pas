unit PerfilUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TiposYconstantes, MEUsuario, Menus, MEArticulosPublicados, Login;

type
  TformPerfilUsuario = class(TForm)
    btnVolver: TButton;
    imgFotoPerfil: TImage;
    labelNombre: TLabel;
    editNombre: TEdit;
    labelApellido: TLabel;
    editApellido: TEdit;
    labelMail: TLabel;
    editEmail: TEdit;
    btnCargar: TButton;
    labelClave: TLabel;
    editClave: TEdit;
    labelConfClave: TLabel;
    editConfClave: TEdit;
    labelDomicilio: TLabel;
    editDomicilio: TEdit;
    labelProvincia: TLabel;
    comboBoxProvincias: TComboBox;
    btnGuardarCambios: TButton;
    btnMostrar: TButton;
    checkBoxModificar: TCheckBox;
    labelGuardarImagen: TLabel;
    checkBoxMostrarClave: TCheckBox;
    MainMenu1: TMainMenu;
    EliminarCuenta1: TMenuItem;
    procedure btnVolverClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCargarClick(Sender: TObject);
    procedure btnGuardarCambiosClick(Sender: TObject);
    procedure btnMostrarClick(Sender: TObject);
    procedure EliminarCuenta1Click(Sender: TObject);
  private
    function guardarImagenCarpeta(rutaOrigen:String):String;
    procedure recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; IDUsuario: TiposYconstantes.tipoposicion; var eliminar: boolean);
  public

  end;

var
  formPerfilUsuario: TformPerfilUsuario;
  rutaOrigen: string;

implementation

uses PantallaUsuario;

{$R *.dfm}

procedure TformPerfilUsuario.btnVolverClick(Sender: TObject);
begin
  formPerfilUsuario.Close;
  formUsuario.show();
  formLogin.cargarPublicacionesInicio();
  formPerfilUsuario.checkBoxModificar.Checked:= false;
  checkBoxMostrarClave.Checked:= false;
  editClave.PasswordChar:= '*';
end;

procedure TformPerfilUsuario.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to length(TiposYconstantes.vectorProvincias)-1 do
    comboBoxProvincias.Items.Add(TiposYconstantes.vectorProvincias[i]);
end;// FormCreate

// CARGAR FOTO PERFIL
procedure TformPerfilUsuario.btnCargarClick(Sender: TObject);
var
  OpenDlg : TOpenDialog;
begin
  //abro un opendlg para buscar el archivo
  OpenDlg := TOpenDialog.Create(Self);
  if OpenDlg.Execute then
    //verifico que sea un archivo .jpg
    if ((ExtractFileExt(OpenDlg.FileName))='.jpg') then
      begin
        imgFotoPerfil.Picture.LoadFromFile(OpenDlg.FileName);
        rutaOrigen:= OpenDlg.FileName;//guardo la direccion del archivo
        checkBoxModificar.Checked:= true;
      end
    else
      messagedlg('Se permiten archivos .jpg',mtError, [mbOk], 0);
end;//  btnCargarClick


procedure TformPerfilUsuario.btnGuardarCambiosClick(Sender: TObject);
var
  regUsuario: MEUsuario.tiporegListaDatosHash;
  pos: tipoposicion;
  eliminar: boolean;

begin
  // IDUsuario
  MEUsuario.AbrirMe(Usuario);
  MEUsuario.Buscar(Usuario, formUsuario.labelMail.Caption, pos);
  MEUsuario.CapturarInfo(Usuario, regUsuario, pos);
  MEUsuario.CerrarMe(Usuario);

  // Ver si tiene publicaciones
  MEArticulosPublicados.abrir(Publicado);
  eliminar:= false;
  recorrerArbol(Publicado, MEArticulosPublicados.raizCategoria(Publicado), regUsuario.IDUsuario, eliminar);
  MEArticulosPublicados.cerrar(Publicado);

  MEUsuario.AbrirMe(Usuario);
  if (eliminar) then
    showmessage('El usuario no puede modificar la informacion debido a que posee publicaciones activas.')
  else
  if (editEmail.Text<>'') and (editClave.Text<>'') and (editConfClave.Text<>'') and (editNombre.Text<>'') and (editApellido.Text<>'') and (comboBoxProvincias.ItemIndex<>-1) and (editDomicilio.Text<>'') then
    begin
        if emailValido(editEmail.text) then
          if (editClave.Text<>editConfClave.Text) then
            showmessage('Las contraseñas no coinciden.')
          else
            begin
            if Dialogs.MessageDlg('Deseas modificar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
              begin
                MEUsuario.Buscar(Usuario, formUsuario.labelMail.Caption, pos); {+++++++++++++++++++ CAPTURO POS DEL USUARIO ++++++++++++++++++++}
                MEUsuario.CapturarInfo(Usuario,regUsuario,pos);
                if checkBoxModificar.Checked then
                  if not (ExtractFileName(regUsuario.Foto)= 'Administrador.jpg') then
                    deletefile(regUsuario.foto); // Borrar foto antigua

                regUsuario.Clave :=         editEmail.Text;                                                  //Mail
                regUsuario.contrasena :=    MEUsuario.encriptar(editClave.text, MEUsuario.llaveCifrado);     //Contrasena
                regUsuario.nombre :=        lowercase(editNombre.text);                                      //Nombre
                regUsuario.apellido :=      lowercase(editApellido.text);                                    //Apellido
                regUsuario.domicilio :=     lowercase(editdomicilio.Text);                                   //Docimilio
                regUsuario.provincia :=     (comboBoxProvincias.ItemIndex);                                  //Provincia

                if checkBoxModificar.Checked then
                  regUsuario.foto :=          guardarImagenCarpeta(rutaOrigen)                               //Foto
                else
                  regUsuario.foto :=                       labelGuardarImagen.Caption;                       //Foto

                MEUsuario.modificar(Usuario, regUsuario, pos);            {+++++++++++++++++++ MODIFICO ++++++++++++++++++++}

                checkBoxModificar.Checked:= false;
                checkBoxMostrarClave.Checked:= false;
                editClave.PasswordChar:= '*';
                showmessage('Datos modificados exitosamente.');
              end // Confirmacion de MODIFICACION de usuario.
            end // COMPROBAR USUARIO EXISTENTE
        else
         showmessage('Formato de mail invalido.');
    end // COMPROBAR CAMPOS VACIOS
  else
    showmessage('Complete todos los campos.');
  MEUsuario.CerrarMe(Usuario);
end;// btnGuardarCambiosClick

function TformPerfilUsuario.guardarImagenCarpeta(rutaOrigen:String):String;
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

procedure TformPerfilUsuario.btnMostrarClick(Sender: TObject);
var
  cambiar : boolean;
begin
    if not checkBoxMostrarClave.Checked then
    begin
      editClave.PasswordChar:= #0;
      checkBoxMostrarClave.Checked:=true;
    end
    else
    begin
      editClave.PasswordChar:= '*';
      checkBoxMostrarClave.Checked:=false;
    end;
end;// btnMostrarClick

procedure TformPerfilUsuario.EliminarCuenta1Click(Sender: TObject);
var
  pos: integer;
  reg: MEUsuario.tiporegListaDatosHash;
  eliminar: boolean;
begin
  // IDUsuario
  MEUsuario.AbrirMe(Usuario);
  MEUsuario.Buscar(Usuario, formUsuario.labelMail.Caption, pos);
  MEUsuario.CapturarInfo(Usuario, reg, pos);
  MEUsuario.CerrarMe(Usuario);

  // Ver si tiene publicaciones
  MEArticulosPublicados.abrir(Publicado);
  recorrerArbol(Publicado, MEArticulosPublicados.raizVendedor(Publicado), reg.IDUsuario, eliminar);
  MEArticulosPublicados.cerrar(Publicado);

  if (eliminar) then
    showmessage('El usuario no puede darse de baja debido a que posee publicaciones activas.')
  else
  if Dialogs.MessageDlg('Deseas eliminar el usuario del sistema?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    MEUsuario.AbrirMe(Usuario);
    MEUsuario.Buscar(Usuario, formUsuario.labelMail.Caption, pos);
    MEUsuario.CapturarInfo(Usuario, reg, pos);
    if not (ExtractFileName(reg.Foto)= 'Administrador.jpg') then
      deletefile(reg.foto);
    MEUsuario.eliminar(Usuario, reg);
    MEUsuario.CerrarMe(Usuario);

    formPerfilUsuario.Close;
    //formUsuario.Close;
    formLogin.Show;
    showmessage('Usuario eliminado correctamente.');
  end;
end;// EliminarCuenta1Click

// Recorrido PreOrden RECURSIVO
procedure TformPerfilUsuario.recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; IDUsuario: TiposYconstantes.tipoposicion; var eliminar: boolean);
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;
begin
  If (pos<>MEArticulosPublicados.posNula(Arbol)) and (not eliminar) then
  begin
    MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);

    if ((IDUsuario=regDatos.IDVendedor) and (regDatos.estadoPublicacion=byte(1))) then  // En buscar de una publicacion ACTIVA
      eliminar:= true;

    recorrerArbol(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), IDUsuario, eliminar);
    recorrerArbol(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), IDUsuario, eliminar);
  end;
end; //recorrerArbol

end.



