unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MEUsuario, TiposYconstantes, MECategorias, MEArticulosPublicados, MEConversaciones, TDAColasParciales, TDACola, MEVentas;

type
  TformLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    editMail: TEdit;
    editClave: TEdit;
    Label4: TLabel;
    checkBoxRecordarme: TCheckBox;
    btnIniciarSesion: TButton;
    btnVisitar: TButton;
    btnSalir: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    btnDesconectar: TButton;
    Label5: TLabel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Label4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure btnIniciarSesionClick(Sender: TObject);
    procedure btnVisitarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnDesconectarClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

  private
    procedure recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion;var contador: integer);
  public
    procedure cargarPublicacionesInicio();
    procedure CompletarInicio();
  end;

 var
  formLogin: TformLogin;
  Usuario: MEUsuario.tipoMe;
  Categoria: MECategorias.TipoMe;
  Publicado: MEArticulosPublicados.tipoPublicados;
  Conversaciones, colaAux: MEConversaciones.tipoConversacion;
  Venta: MEVentas.tipoVentas;
  contador: integer;

implementation

uses Registrarse, PantallaUsuario, Administrador;

{$R *.dfm}


procedure TformLogin.FormCreate(Sender: TObject);
var
  pos: integer;
  reg: MEUSuario.tiporeglistadatoshash;
  CarpetaAplicacion: string;
begin
  CarpetaAplicacion := ExtractFilePath(Application.ExeName);
  TiposYconstantes.cargarCarpetas(CarpetaAplicacion);
  MEUsuario.CrearMe(Usuario, TiposYconstantes.carpArchivos, 'Usuario');
  MECategorias.CrearLd(Categoria, TiposYconstantes.carpArchivos, 'Categoria');
  MEArticulosPublicados.crear(Publicado, TiposYconstantes.carpArchivos, 'Publicado');
  MEConversaciones.crear(Conversaciones, TiposYconstantes.carpArchivos, 'Conversaciones');
  MEVentas.crear(Venta, TiposYconstantes.carpArchivos, 'Venta');

  MEUsuario.AbrirMe(Usuario);
  if not (MEUsuario.Buscar(Usuario, 'administrador@ventalibre.com', pos)) then
    MEUsuario.cargarAdmin(Usuario);
  MEUsuario.CerrarMe(Usuario);
end;

procedure TformLogin.Label4Click(Sender: TObject);
begin
  formLogin.Hide;
  formRegistrarse.show;
  formRegistrarse.rutaOrigen:= TiposYconstantes.imgDesco;
  formRegistrarse.imgPerfil.Picture.LoadFromFile(formRegistrarse.rutaOrigen);
end;

procedure TformLogin.btnSalirClick(Sender: TObject);
begin
  formLogin.Close;
end;

procedure TformLogin.btnIniciarSesionClick(Sender: TObject);
var
  regUsuario: MEUsuario.tiporegListaDatosHash;
  pos: integer;
begin
  MEUsuario.AbrirMe(Usuario);
  if (editMail.Text='') or (editClave.Text='') then
    showmessage('Complete todos los campos.')
  else
    if not emailValido(editMail.text) then
      begin
        showmessage('Formato de mail invalido.');
        editMail.SetFocus;
      end
    else
      if not (MEUsuario.Buscar(Usuario, editMail.text, pos)) then
        begin
          showmessage('Usuario no registrado.');
          editMail.SetFocus;
          editClave.Text:='';
        end
      else
        begin
          MEUsuario.CapturarInfo(Usuario, regUsuario, pos);
          if not (MEUsuario.desencriptar(regUsuario.contrasena, MEUsuario.llaveCifrado)=editClave.Text) then
            begin
              showmessage('Contraseña invalida.');
              editClave.SetFocus;
            end
          else
            if (regUsuario.bloqueado=true) then
              showmessage('Usuario BLOQUEDO.')
            else
              if (regUsuario.estado=true) then
                begin
                  showmessage('Usuario ya conectado');
                  editMail.SetFocus;
                  editClave.Text:='';
                end
              else
                begin
                formUsuario.labelMail.Caption:= editMail.Text;
                MEUsuario.Buscar(Usuario, editMail.Text, pos);
                // --------------------------------------------------------------------- Modo Administrador
                if (editMail.Text='administrador@ventalibre.com') then
                  begin
                    MEUsuario.ingresoUsuario(Usuario, pos, regUsuario);
                    if not (checkBoxRecordarme.Checked) then
                      begin
                        editMail.Clear;
                        editClave.Clear;
                      end;
                    formLogin.Hide;
                    formAdministrador.show;
                  end
                else
                  begin
                    // ----------------------------------------------------------------------------------------
                    MEUsuario.ingresoUsuario(Usuario, pos, regUsuario);
                    // ============================= COMPROBANDO DATOS USUARIO ==============================
                    {showmessage('Nombre: '+  regUsuario.nombre+#13+
                                'Apellido: '+  regUsuario.apellido+#13+
                                'Mail: '+  regUsuario.Clave+#13+
                                'Contrasena: '+  regUsuario.contrasena+#13+
                                'Domicilio: '+  regUsuario.domicilio+#13+
                                'Fecha Alta: '+  DateTimeToStr(regUsuario.fechaAlta)+#13+
                                'Ult Conexion: '+  DateTimeToStr(regUsuario.fechaConexion)+#13+
                                'Estado: '+ BoolToStr(regUsuario.estado)+#13+
                                'IDUsuario: '+ inttostr(regUsuario.IDUsuario)+#13+
                                'Bloqueado: '+booltostr(regUsuario.bloqueado));}
                     // ============================= COMPROBANDO DATOS USUARIO ==============================

                    if not (checkBoxRecordarme.Checked) then
                      begin
                        editMail.Clear;
                        editClave.Clear;
                      end;

                    formUsuario.btnMainPublicaciones.Visible:= true;
                    formUsuario.btnMainVender.Visible:= true;
                    formUsuario.checkBoxTipoUsuario.Checked:= false;
                    formUsuario.btnRegistrarse.Visible:= false;
                    formUsuario.btnMisCompras.Visible:= true;
                    formUsuario.btnMisVentas.Visible:= true;
                    formUsuario.btnMenuPerfil.Visible:= true;
                    cargarPublicacionesInicio();
                    CompletarInicio();
                    formLogin.Hide;
                    formUsuario.Show;
                  end;
            end;
       end;
end;



procedure TformLogin.btnVisitarClick(Sender: TObject);
var
  pos: integer;
begin
    formUsuario.Show;
    formUsuario.btnMenuPerfil.Visible:= false;
    formUsuario.btnMainPublicaciones.Visible:= false;
    formUsuario.btnMainVender.Visible:= false;
    formUsuario.labelMail.Caption:= 'Modo Visita';
    formUsuario.checkBoxTipoUsuario.Checked:= true;
    formUsuario.btnRegistrarse.Visible:= true;
    formUsuario.btnMisCompras.Visible:= false;
    formUsuario.btnMisVentas.Visible:= false;
    cargarPublicacionesInicio();
    CompletarInicio();
    formLogin.hide;

end;

procedure TformLogin.Button1Click(Sender: TObject);
begin
  editMail.Text:= 'administrador@ventalibre.com';
  editClave.Text:='newton';
  btnIniciarSesion.Click;
end;

procedure TformLogin.Button2Click(Sender: TObject);
begin
  editMail.Text:= 'andresandreoli@hotmail.com';
  editClave.Text:='andres';
  btnIniciarSesion.Click;
end;



procedure TformLogin.Button3Click(Sender: TObject);
var
  pos: integer;
  reg: MECategorias.TipoRegDatos;
begin
    MECategorias.AbrirMe(Categoria);
    MECategorias.Buscar(Categoria, MECategorias.UltimoID(Categoria), pos);
    reg.Clave:= MECategorias.UltimoID(Categoria);
    reg.categoria:= 'a';
    reg.comision:= 1;
    MECategorias.Insertar(Categoria, pos, reg);
    MECategorias.CerrarMe(Categoria);
end;

procedure TformLogin.cargarPublicacionesInicio();
var
  cont, cont1, pos: integer;
  regDat: MEUsuario.tiporeglistadatoshash;
  entra: boolean;
begin
  if formUsuario.labelMail.Caption<>'Modo Visita' then
  begin
    MEUsuario.AbrirMe(Usuario);
    MEUsuario.Buscar(Usuario, formUsuario.labelMail.caption, pos);
    MEUsuario.CapturarInfo(Usuario, regdat, pos);
    MEUsuario.CerrarMe(Usuario);
  end;

  if formUsuario.labelMail.Caption='Modo Visita' then
  entra:=true
  else begin
    if regDAt.bloqueado then
    entra:= false else entra:=true;
  end;

  if not entra then begin
    Showmessage('Usuario BLOQUEADO');
    formusuario.Close;
    formLogin.show;
  end else begin
  // ============================================================================ Limpiar tabla
    for cont :=0 to FormUsuario.StringGridPublicaciones.colcount-1 do
      for cont1 :=0 to FormUsuario.StringGridPublicaciones.rowcount-1 do
        FormUsuario.StringGridPublicaciones.Cells[cont,cont1] := '';

  // =========================================================================== Cargar Cabecera
    FormUsuario.StringGridPublicaciones.Cells[0, 0]:= 'Codigo';
    FormUsuario.StringGridPublicaciones.Cells[1, 0]:= 'Titulo';
    FormUsuario.StringGridPublicaciones.Cells[2, 0]:= 'Precio';
    FormUsuario.StringGridPublicaciones.Cells[3, 0]:= 'Fecha Caducidad';

    FormUsuario.StringGridPublicaciones.ColWidths[1]:=278;
    FormUsuario.StringGridPublicaciones.ColWidths[2]:=201;
    FormUsuario.StringGridPublicaciones.ColWidths[3]:=221;

    MEArticulosPublicados.abrir(Publicado);
    contador:=1;

    if not (MEArticulosPublicados.vacioCategorias(Publicado)) then
      recorrerArbol(Publicado, MEArticulosPublicados.raizCategoria(Publicado), contador);
    MEArticulosPublicados.cerrar(Publicado);

    formUsuario.labelContador.caption:= inttostr(login.contador);
    formUsuario.editTitulo.Text:='';
    formUsuario.ComboBoxProvincias.ItemIndex:= 0;
    formUsuario.ComboBoxCategoria.ItemIndex:= 0;
    formUsuario.ComboBoxEstado.ItemIndex:= 0;
    formUsuario.editPrecioMenor.Text:= 'min';
    formUsuario.editPrecioMayor.Text:= 'max';
   end;
end;

// Recorrido PreOrden RECURSIVO
procedure TformLogin.recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; var contador: integer);
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;
begin
  If pos<>MEArticulosPublicados.posNula(Arbol) then
  begin
    MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);
    if (regDatos.estadoPublicacion = 1) then
      if (regDatos.fechacierre<=now()) then {Saco las publicaciones vencidas}
        begin
          regDatos.estadoPublicacion:=4;
          MEArticulosPublicados.modificar(Arbol, regInd, regDatos);
        end
      else
  // =========================================================================== Cargar Cuerpo
        begin
          FormUsuario.StringGridPublicaciones.Cells[0, contador]:= regInd.Clave;
          FormUsuario.StringGridPublicaciones.Cells[1, contador]:= regDatos.NombreArticulo;
          FormUsuario.StringGridPublicaciones.Cells[2, contador]:= floattostr(regDatos.precio);
          FormUsuario.StringGridPublicaciones.Cells[3, contador]:= datetostr(regDatos.fechacierre);

          contador:= contador +1;
          formUsuario.StringGridPublicaciones.RowCount:= contador;
        end;

    recorrerArbol(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), contador);
    recorrerArbol(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), contador);
  end;
end; //recorrerArbol

procedure TformLogin.CompletarInicio();
Var
  i, pos: integer;
  regCat: MECategorias.tiporegdatos;
begin
  formUsuario.comboBoxProvincias.clear;
  formUsuario.comboBoxProvincias.Items.Add('Todas');
  formUsuario.comboBoxProvincias.Itemindex:= 0;
  for i:=0 to length(TiposYconstantes.vectorProvincias)-1 do
    formUsuario.comboBoxProvincias.Items.Add(TiposYconstantes.vectorProvincias[i]);

  MECategorias.AbrirMe(Categoria);
  formUsuario.comboBoxCategoria.clear;
  formUsuario.comboBoxCategoria.Items.Add('Todas');
  formUsuario.comboBoxCategoria.itemindex:= 0;
  pos:= MECategorias.Primero(Categoria);
  while pos<>MECategorias.PosNula(Categoria) do
    begin
      MECategorias.Capturar(Categoria, pos, regCat);
      formUsuario.comboBoxCategoria.Items.Add(inttostr(regCat.Clave) +' - '+ regCat.categoria);
      pos:= MECategorias.Proximo(Categoria, pos);
    end;
  MECategorias.CerrarMe(Categoria);
end;// completarInicio


procedure TformLogin.btnDesconectarClick(Sender: TObject);
var
  cont, cont1, posPri, posSeg, contador: integer;
  reg:MEUsuario.tiporegListaDatosHash;
begin
MEUsuario.AbrirMe(usuario);
posPri:= MEUsuario.primeroListaDoble(Usuario);
  while (posPri<>MEUsuario._posnula) do
  begin
    posSeg:= MEUsuario.primeroListaDobleParciales(Usuario, posPri);
    //showmessage(inttostr(posSeg));
    While (posSeg<>MEUsuario._posnula) do
    begin
    MEUsuario.CapturarInfo(Usuario, reg, posSeg);
    reg.estado:= false;
    MEUsuario.modificar(Usuario, reg, posSeg);
    posSeg:= MEUsuario.proximoListaDobleParciales(Usuario, posSeg ,reg);
    end;
    posPri:= MEUsuario.proximoListaDoble(Usuario, posPri);
  end;

  MEUsuario.CerrarMe(Usuario);
end;



procedure TformLogin.Button4Click(Sender: TObject);
begin
editMail.Text:= 'felicitas9@gmail.com';
  editClave.Text:='felicitas';
  btnIniciarSesion.Click;
end;

procedure TformLogin.Button5Click(Sender: TObject);
begin
editMail.Text:= 'rodrigo.perez@gmail.com';
  editClave.Text:='rodrigo';
  btnIniciarSesion.Click;
end;

procedure TformLogin.Button6Click(Sender: TObject);
begin
editMail.Text:= 'pepe.pepe_alta@hotmail.com';
  editClave.Text:='pepe.pepe';
  btnIniciarSesion.Click;
end;

end.
