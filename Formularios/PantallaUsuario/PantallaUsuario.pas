unit PantallaUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, MEUsuario, MECategorias, TiposYconstantes, MEArticulosPublicados,MEVentas, TDAColasParcialesV, TDAColaV,
  Grids, StrUtils, Buttons ;

type
  TformUsuario = class(TForm)
    MainMenu1: TMainMenu;
    btnMenuSalir: TMenuItem;
    labelMail: TLabel;
    btnMenuPerfil: TMenuItem;
    checkBoxTipoUsuario: TCheckBox;
    btnMainPublicaciones: TMenuItem;
    btnMainVender: TMenuItem;
    btnRegistrarse: TButton;
    StringGridPublicaciones: TStringGrid;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    editTitulo: TEdit;
    labelTitulo: TLabel;
    Label3: TLabel;
    ComboBoxCategoria: TComboBox;
    labelProvincia: TLabel;
    ComboBoxProvincias: TComboBox;
    Label4: TLabel;
    ComboBoxEstado: TComboBox;
    Label5: TLabel;
    ComboBoxPrecio: TComboBox;
    Label6: TLabel;
    editPrecioMenor: TEdit;
    editPrecioMayor: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    btnBuscar: TButton;
    btnLimpiar: TButton;
    labelContador: TLabel;
    Label9: TLabel;
    btnMisCompras: TMenuItem;
    btnMisVentas: TMenuItem;
    BitBtn1: TBitBtn;
    procedure btnMenuSalirClick(Sender: TObject);
    procedure btnMenuPerfilClick(Sender: TObject);
    procedure btnRegistrarseClick(Sender: TObject);
    procedure btnMainVenderClick(Sender: TObject);
    procedure btnMainPublicacionesClick(Sender: TObject);
    procedure editPrecioMenorClick(Sender: TObject);
    procedure editPrecioMayorClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure StringGridPublicacionesDblClick(Sender: TObject);
    procedure btnMisComprasClick(Sender: TObject);
    procedure btnMisVentasClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure StringGridPublicacionesDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    
  private
    procedure recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion;var contador: integer; regUsuario: tipoposicion);
    procedure recorrerFiltro(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion;var contador: integer; var vectorArticulos: array of MEArticulosPublicados.TipoRegDatos);
    procedure filtro(titulo: string; provincia: integer; categoriaFiltro: integer; estado: integer; precio: integer; rangoMin: string; rangoMax: string; var vectorArticulos: array of MEArticulosPublicados.tipoRegDatos);
    procedure ordenamientoBurbuja(var Vector: array of MEArticulosPublicados.tipoRegDatos; tipo: boolean);
    function limpiarEspacios(texto: String): string;
  public
    procedure cargarMisVentas(tipo:integer);
    procedure cargarPublicaciones();
    procedure cargarMisCompras(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; idUsuario: integer; var contador: integer);
  end;

var
  formUsuario: TformUsuario;
    vectorVentas: array of MEVentas.tiporegdatos;
implementation

uses Login, PerfilUsuario, Registrarse, Ventas, Publicaciones,
  PublicacionSeleccionada, PubSeleccionada, Compras, MisVentas;

{$R *.dfm}

procedure TformUsuario.btnMenuSalirClick(Sender: TObject);
var
  pos: integer;
  regUsuario: MEUsuario.tiporegListaDatosHash;
begin
  if not checkBoxTipoUsuario.Checked then
  begin
    MEUsuario.AbrirMe(Usuario);
    MEUsuario.Buscar(Usuario, labelMail.Caption, pos);
    // ============================= COMPROBANDO DATOS USUARIO ==============================
    MEUsuario.CapturarInfo(Usuario, regUsuario,pos);
    {showmessage('Nombre: '+  regUsuario.nombre+#13+
                'Apellido: '+  regUsuario.apellido+#13+
                'Mail: '+  regUsuario.Clave+#13+
                'Contrasena: '+  regUsuario.contrasena+#13+
                'Domicilio: '+  regUsuario.domicilio+#13+
                'Fecha Alta: '+  DateTimeToStr(regUsuario.fechaAlta)+#13+
                'Ult Conexion: '+  DateTimeToStr(regUsuario.fechaConexion)+#13+
                'Estado: '+ BoolToStr(regUsuario.estado));}
    // ============================= COMPROBANDO DATOS USUARIO ==============================
    MEUsuario.salidaUsuario(Usuario, pos, regUsuario);
    MEUsuario.CerrarMe(Usuario);
  end; // Comprobando tipo de Usuario
  checkBoxTipoUsuario.Checked:= false;
  formUsuario.btnMenuPerfil.Visible:= true;
  formUsuario.btnMainPublicaciones.Visible:= true;
  formUsuario.btnMainVender.Visible:= true;
  formUsuario.btnMisCompras.Visible:= true;
  formUsuario.btnMisVentas.Visible:= true;
  formUsuario.checkBoxTipoUsuario.Checked:= false;
  formUsuario.btnRegistrarse.Visible:= false;
  formUsuario.Close;
  formLogin.show();
end;// Salir1Click

procedure TformUsuario.btnMenuPerfilClick(Sender: TObject);
var
  pos: integer;
  regUsuario: MEUsuario.tiporegListaDatosHash;
begin
  formUsuario.close;
  formPerfilUsuario.show();
  formLogin.Hide;

  // Cargar datos USUARIO
  MEUsuario.AbrirMe(Usuario);
  MEUsuario.Buscar(Usuario, formUsuario.labelMail.Caption, pos);
  MEUsuario.CapturarInfo(Usuario, regUsuario, pos);
  formPerfilUsuario.imgFotoPerfil.Picture.LoadFromFile(regUsuario.foto);
  formPerfilUsuario.labelGuardarImagen.Caption:= regUsuario.foto;
  formPerfilUsuario.editNombre.Text := regUsuario.nombre;
  formPerfilUsuario.editApellido.Text := regUsuario.apellido;
  formPerfilUsuario.editEmail.Text := regUsuario.Clave;
  formPerfilUsuario.editClave.Text := MEUsuario.desencriptar(regUsuario.contrasena, MEUsuario.llaveCifrado);
  formPerfilUsuario.editConfClave.Text := MEUsuario.desencriptar(regUsuario.contrasena, MEUsuario.llaveCifrado);
  formPerfilUsuario.editDomicilio.Text := regUsuario.domicilio;
  formPerfilUsuario.comboBoxProvincias.ItemIndex := regUsuario.provincia;
  MEUsuario.CerrarMe(Usuario);

end;

procedure TformUsuario.btnRegistrarseClick(Sender: TObject);
begin
  formUsuario.Hide;
  formRegistrarse.show;
  formRegistrarse.rutaOrigen:= TiposYconstantes.imgDesco;
  formRegistrarse.imgPerfil.Picture.LoadFromFile(TiposYconstantes.imgDesco);
end;

procedure TformUsuario.btnMainVenderClick(Sender: TObject);
var
  pos: integer;
  regCat: MECategorias.TipoRegDatos;
begin
MECategorias.AbrirMe(Categoria);
  if MECategorias.categoriaVacia(Categoria) then
    showmessage('No es posible realizar esta operacion. No hay categorias dadas de alta.')
  else
  begin
    formVentas.show;
    formVentas.editTitulo.Text:='';
    formVentas.editDescripcion.Text:='';
    formVentas.comboboxCategoria.Clear;
    formVentas.editPrecio.Text:='';
    pos:= MECategorias.Primero(Categoria);
    formVentas.Calendario.Date:= now() + 90;
    while pos<>MECategorias.PosNula(Categoria) do
    begin
      MECategorias.Capturar(Categoria, pos, regCat);
      formVentas.comboBoxCategoria.Items.Add(inttostr(regCat.Clave) +' - '+ regCat.categoria);
      pos:= MECategorias.Proximo(Categoria, pos);
    end;
    formVentas.imgArticulo.Picture.LoadFromFile(TiposYconstantes.imgPub);
    formVentas.labelGuardarImagen.Caption:=  TiposYconstantes.imgPub;
    formUsuario.Hide;
  end;
MECategorias.CerrarMe(Categoria);
end;

procedure TformUsuario.btnMainPublicacionesClick(Sender: TObject);
var
  cont, cont1, pos: integer;
  regCat: MECategorias.TipoRegDatos;
begin
  MECategorias.AbrirMe(Categoria);
  pos:= MECategorias.Primero(Categoria);
  formPubSeleccionada.ComboBoxCategoria.Clear;
  formPubSeleccionada.ComboBoxCategoria.Items.Add('');
  formPubSeleccionada.ComboBoxCategoria.ItemIndex:=0;
  while pos<>MECategorias.PosNula(Categoria) do
    begin
      MECategorias.Capturar(Categoria, pos, regCat);
      formPubSeleccionada.ComboBoxCategoria.Items.Add(inttostr(regCat.Clave) +' - '+ regCat.categoria);
      pos:= MECategorias.Proximo(Categoria, pos);
    end;
  MECategorias.CerrarMe(Categoria);
  
// ============================================================================= Limpiar tabla
  for cont :=0 to formPublicaciones.StringGridPublicaciones.colcount-1 do
    for cont1 :=0 to formPublicaciones.StringGridPublicaciones.rowcount-1 do
      formPublicaciones.StringGridPublicaciones.Cells[cont,cont1] := '';

//============================================================================== Cabecera publicados
  formPublicaciones.StringGridPublicaciones.Cells[0, 0]:= 'Cod.';
  formPublicaciones.StringGridPublicaciones.Cells[1, 0]:= 'Fecha Creacion';
  formPublicaciones.StringGridPublicaciones.Cells[2, 0]:= 'Fecha Cierra';
  formPublicaciones.StringGridPublicaciones.Cells[3, 0]:= 'Titulo';
  formPublicaciones.StringGridPublicaciones.Cells[4, 0]:= 'Estado';

  formPublicaciones.StringGridPublicaciones.ColWidths[0]:=50;

//============================================================================== Cargar cuerpo
  cargarPublicaciones();

  formPublicaciones.show;
  formUsuario.Close;
end;

procedure TformUsuario.cargarPublicaciones();
var
  contador, pos: integer;
  regUsuario: MEUsuario.tiporegListaDatosHash;
  vectorArticulos: array of MEArticulosPublicados.tipoRegDatos;
begin
  MEUsuario.AbrirMe(Usuario);
  MEUsuario.Buscar(Usuario, formUsuario.labelMail.Caption, pos);
  MEUsuario.CapturarInfo(Usuario, regUsuario, pos);
  MEUsuario.CerrarMe(Usuario);

  contador:=1;

  MEArticulosPublicados.abrir(Publicado);
  recorrerArbol(Publicado, MEArticulosPublicados.raizCategoria(Publicado), contador, regUsuario.IDUsuario);
  MEArticulosPublicados.cerrar(Publicado);

  if formPublicaciones.StringGridPublicaciones.Cells[0, 1]='' then
    formPublicaciones.StringGridPublicaciones.RowCount:= 2;
end;

// Recorrido PreOrden RECURSIVO
procedure TformUsuario.recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; var contador: integer; regUsuario: tipoposicion);
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;
  estado: string;
begin

  If pos<>MEArticulosPublicados.posNula(Arbol) then
  begin
    MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);

    if (regUsuario = regDatos.IDVendedor) then
      begin
        formPublicaciones.StringGridPublicaciones.Cells[0, contador]:= regInd.Clave;

        formPublicaciones.StringGridPublicaciones.Cells[1, contador]:= datetimetostr(regDAtos.fechapublicacion);
        formPublicaciones.StringGridPublicaciones.Cells[2, contador]:= datetimetostr(regDatos.fechacierre);
        formPublicaciones.StringGridPublicaciones.Cells[3, contador]:= regDatos.NombreArticulo;
        Case (regDatos.estadoPublicacion) of
          1: estado:= 'Publicado';
          2: estado:= 'Pausado';
          3: estado:= 'Vendido';
          4: estado:= 'Anulado';
          5: estado:= 'Bloqueado';
        end;
        formPublicaciones.StringGridPublicaciones.Cells[4, contador]:= estado;

        contador:= contador +1;
        formPublicaciones.StringGridPublicaciones.RowCount:= contador;
      end;

    recorrerArbol(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), contador, regUsuario);
    recorrerArbol(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), contador, regUsuario);
  end;
end;

procedure TformUsuario.editPrecioMenorClick(Sender: TObject);
begin
  editPrecioMenor.Text:='';
end;

procedure TformUsuario.editPrecioMayorClick(Sender: TObject);
begin
  editPrecioMayor.Text:='';
end;

procedure TformUsuario.btnBuscarClick(Sender: TObject);
var
  vectorArticulos: array of MEArticulosPublicados.tipoRegDatos;
  contador, categoria: integer;
  reg: MEArticulosPublicados.tipoRegDatos;
  paso: boolean;
begin
paso:= false;
  if editPrecioMenor.Text='' then
    editPrecioMenor.Text:= 'min';

  if editPrecioMayor.Text='' then
    editPrecioMayor.Text:= 'max';

  if (editPrecioMenor.Text<>'min') and (editPrecioMayor.Text<>'max') then
    if strtofloat(editPrecioMenor.Text)>strtofloat(editPrecioMayor.Text) then
      showmessage('El rango MENOR tiene que ser menor al rango MAYOR.')
    else
      paso:=true
  else
    paso:= true;

  if paso then
  begin
    contador:= 0;

    SetLength(vectorArticulos, strtoint(labelContador.caption)-1);

    MEArticulosPublicados.abrir(Publicado);
    recorrerFiltro(Publicado, MEArticulosPublicados.raizCategoria(Publicado), contador, vectorArticulos);
    MEArticulosPublicados.cerrar(Publicado);
    if comboboxCategoria.ItemIndex<>0 then
      categoria:= strtoint(trim(Copy((comboboxCategoria.Items[comboboxCategoria.ItemIndex]),0,2)))
    else
      categoria:= comboboxCategoria.ItemIndex;

    filtro(trim(editTitulo.Text), (comboboxprovincias.ItemIndex-1), categoria, comboboxestado.ItemIndex, comboboxprecio.ItemIndex, editPrecioMenor.text, editPrecioMayor.text, vectorArticulos);
  end; // Paso
end;

procedure TformUsuario.filtro(titulo: string; provincia: integer; categoriaFiltro: integer; estado: integer; precio: integer; rangoMin: string; rangoMax: string; var vectorArticulos: array of MEArticulosPublicados.tipoRegDatos);
var
  i, posCat, cont, cont1: integer;
  filtrar, tipo: boolean;
  cadena1, cadena2: string;
begin
  // ============================================================================ Limpiar tabla
  for cont :=0 to FormUsuario.StringGridPublicaciones.colcount-1 do
    for cont1 :=0 to FormUsuario.StringGridPublicaciones.rowcount-1 do
      FormUsuario.StringGridPublicaciones.Cells[cont,cont1] := '';

  // =========================================================================== Cargar Cabecera
  FormUsuario.StringGridPublicaciones.Cells[0, 0]:= 'Codigo';
  FormUsuario.StringGridPublicaciones.Cells[1, 0]:= 'Titulo';
  FormUsuario.StringGridPublicaciones.Cells[2, 0]:= 'Precio';
  FormUsuario.StringGridPublicaciones.Cells[3, 0]:= 'Fecha Caducidad';

  if length(vectorArticulos)=0 then
    showmessage('No hay publicaciones en este momento.')
  else
  begin
    contador:=1;
    for i:=0 to length(vectorArticulos) - 1 do
    begin
      filtrar:= false;
      //========================================================================== Precio (order)
      if (ComboBoxPrecio.ItemIndex<>0) and not(filtrar) then
        if (ComboBoxPrecio.ItemIndex=1) then
          begin
          tipo:= true;
          ordenamientoBurbuja(vectorArticulos, tipo);
          end
        else
          begin
            tipo:= false;
            ordenamientoBurbuja(vectorArticulos, tipo);
          end;
      //========================================================================== Titulo
      if (titulo<>'') and not (filtrar) then
      begin
      cadena1:= lowercase(limpiarEspacios(vectorArticulos[i].NombreArticulo));
      cadena2:= lowercase(limpiarEspacios(titulo));
        if not AnsiContainsStr(cadena1, cadena2) then
          filtrar:= true;
      end;
      //========================================================================== Provincia
      if (provincia<>-1) and  not (filtrar) then
        if (TiposYconstantes.vectorProvincias[vectorArticulos[i].provincia]<>TiposYconstantes.vectorProvincias[provincia]) then
          filtrar:= true;
      //========================================================================== Categoria
      if (categoriaFiltro<>0) and not (filtrar) then
        if (vectorArticulos[i].IDCategoria<>categoriaFiltro) then
          filtrar:= true;
      //========================================================================== Estado
      if (estado<>0) and not (filtrar) then
        if (vectorArticulos[i].tipoArticulo<>estado) then
          filtrar:= true;
      //========================================================================== Rango precio
      if (rangoMin<>'min') and not (filtrar) then
        if (vectorArticulos[i].precio<strtofloat(rangoMin)) then
          filtrar:= true;

      if (rangoMax<>'max') and not (filtrar) then
        if (vectorArticulos[i].precio>strtofloat(rangoMax)) then
          filtrar:= true;
      //========================================================================== Mostrar
      if not filtrar then
      begin
        FormUsuario.StringGridPublicaciones.Cells[0, contador]:= inttostr(vectorArticulos[i].IDCategoria)+vectorArticulos[i].Clave;
        FormUsuario.StringGridPublicaciones.Cells[1, contador]:= vectorArticulos[i].NombreArticulo;
        FormUsuario.StringGridPublicaciones.Cells[2, contador]:= floattostr(vectorArticulos[i].precio);
        FormUsuario.StringGridPublicaciones.Cells[3, contador]:= datetostr(vectorArticulos[i].fechacierre);

        contador:= contador +1;
        formUsuario.StringGridPublicaciones.RowCount:= contador;
      end;

    end;// For Recorrido
  end;// vector no VACIO
end;// Filtro

// Sacar espacios vacios
function TformUsuario.limpiarEspacios(texto: String): string;
var
  recortar: string;
  i: integer;
begin
  recortar:='';
  for i:=1 to length(texto) do
  begin
    if texto[i] <> ' ' then
      recortar:= recortar+texto[i];
  end;
  limpiarEspacios:= recortar;
end;

// Recorrido PreOrden RECURSIVO
procedure TformUsuario.recorrerFiltro(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; var contador: integer; var vectorArticulos: array of MEArticulosPublicados.tipoRegDatos);
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;
  estado: string;
begin

  If pos<>MEArticulosPublicados.posNula(Arbol) then
  begin
    MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);

    if (regDatos.estadoPublicacion = 1) then
  // =========================================================================== Cargar Vector Articulos
    begin
      vectorArticulos[contador]:= regDatos;
      contador:= contador +1;
    end;

    recorrerFiltro(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), contador, vectorArticulos);
    recorrerFiltro(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), contador, vectorArticulos);
  end;
end; //recorrerFiltro

procedure TformUsuario.ordenamientoBurbuja(var Vector: array of MEArticulosPublicados.tipoRegDatos; tipo: boolean);
var
  i, j: integer;
  datosAux: MEArticulosPublicados.tipoRegDatos;
begin
if (tipo) then
begin
//----------------------------------------- MAYOR - MENOR
  for i:=0 to length(Vector)-1 do
    for j:=0 to length(Vector)-2 do
      if (Vector[j].precio<Vector[j+1].precio) then
      begin
        datosAux:= Vector[j];
        Vector[j]:= Vector[j+1];
        Vector[j+1]:= datosAux;
      end;
end
else
begin
//----------------------------------------- MENOR - MAYOR
  for i:=0 to length(Vector)-1 do
    for j:=0 to length(Vector)-2 do
      if (Vector[j].precio>Vector[j+1].precio) then
      begin
        datosAux:= Vector[j];
        Vector[j]:= Vector[j+1];
        Vector[j+1]:= datosAux;
      end;
  end;
end; // ordenamientoBurbuja

procedure TformUsuario.btnLimpiarClick(Sender: TObject);
begin
  formLogin.cargarPublicacionesInicio();
end; // btnLimpiarClick

procedure TformUsuario.StringGridPublicacionesDblClick(Sender: TObject);
var
  codigoArticulo: string;
  pos, posPri, posSeg: integer;
  regInd: MEArticulosPublicados.tipoRegIndice;
  regDat: MEArticulosPublicados.tipoRegDatos;
  reg: MEUsuario.tiporegListaDatosHash;
begin
  if not (StringGridPublicaciones.Cells[0, StringGridPublicaciones.Row]='') then
  begin
    formUsuario.hide;
    formPubComprar.show;
    formPubComprar.listPreguntas.Clear;
    codigoArticulo:= StringGridPublicaciones.Cells[0, StringGridPublicaciones.Row];
    formPubComprar.labelClaveArticulo.caption:= StringGridPublicaciones.Cells[0, StringGridPublicaciones.Row];
    
    MEArticulosPublicados.abrir(Publicado);
    MEArticulosPublicados.buscarCategorias(Publicado, codigoArticulo, pos);
    MEArticulosPublicados.capturarCategorias(Publicado, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Publicado, regInd, regDat);
    //showmessage(regDat.Clave);

    formPubComprar.labeIDArticulo.Caption:= regDat.Clave;
    formPubComprar.imgArticulo.Picture.LoadFromFile(regDat.nombreFoto);
    formPubComprar.editDescripcion.Text:= regDat.descripcion;
    if regDat.tipoArticulo=1 then
      formPubComprar.labelEstado.Caption := 'USADO' else formPubComprar.labelEstado.Caption := 'NUEVO';
    formPubComprar.panelPrecio.Caption:= '$ '+floattostr(regDat.precio);
    formPubcomprar.labelVencimiento.Caption:= datetostr(regDat.fechacierre);
    formPubComprar.labelTitulo.Caption:= regDat.NombreArticulo;
    formPubComprar.labelComprador.Caption:= labelMail.Caption;


  MEUsuario.AbrirMe(Usuario);
  posPri:= MEUsuario.primeroListaDoble(Usuario);
  while (posPri<>MEUsuario._posnula) do
  begin
    posSeg:= MEUsuario.primeroListaDobleParciales(Usuario, posPri);
    While (posSeg<>MEUsuario._posnula) do
    begin
      MEUsuario.CapturarInfo(Usuario, reg, posSeg);
      if (reg.IDUsuario=regDat.IDVendedor) then
      begin
        formPubComprar.labelVendedor.Caption:= reg.Clave;
        formPubComprar.labelIDVendedor.Caption := inttostr(reg.IDUsuario);
      end;
    posSeg:= MEUsuario.proximoListaDobleParciales(Usuario, posSeg, reg);
    end;
    posPri:= MEUsuario.proximoListaDoble(Usuario, posPri);
  end;
  MEUsuario.CerrarMe(Usuario);

    if btnRegistrarse.Visible or (labelMail.Caption=formPubComprar.labelVendedor.Caption) then
      begin
        formPubComprar.btnPreguntar.Enabled:= false;
        formPubComprar.btnComprar.Enabled:= false;
        formPubComprar.editPreguntar.Enabled:= false;
      end else
      begin
        formPubComprar.btnPreguntar.Enabled:= true;
        formPubComprar.btnComprar.Enabled:= true;
        formPubComprar.editPreguntar.Enabled:= true;
      end;

    MEArticulosPublicados.cerrar(Publicado);

    formPubComprar.cargarChat();
  end; //If
end;

procedure TformUsuario.btnMisComprasClick(Sender: TObject);
var
  cont, cont1, contador, idUsuario, posPri: integer;
  reg: MEUsuario.tiporeglistadatoshash;
begin
  formMisCompras.show;
  formUsuario.close;

// ============================================================================= Limpiar tabla
  for cont :=0 to formMisCompras.stringgridCompras.colcount-1 do
    for cont1 :=0 to formMisCompras.stringgridCompras.rowcount-1 do
      formMisCompras.stringgridCompras.Cells[cont,cont1] := '';

//============================================================================== Cabecera publicados
  formMisCompras.stringgridCompras.Cells[0, 0]:= 'Cod.';
  formMisCompras.stringgridCompras.Cells[1, 0]:= 'Titulo';
  formMisCompras.stringgridCompras.Cells[2, 0]:= 'Fecha Compra';
  formMisCompras.stringgridCompras.Cells[3, 0]:= 'Vendedor';
  formMisCompras.stringgridCompras.Cells[4, 0]:= 'Importe';
  formMisCompras.stringgridCompras.Cells[5, 0]:= 'Calificacion';
  formMisCompras.stringgridCompras.Cells[6, 0]:= '-Pagado';

  formMisCompras.stringgridCompras.ColWidths[0]:=60;
  formMisCompras.stringgridCompras.ColWidths[3]:=318;

//============================================================================== Cargar Cuerpo
  //Obtener ID usuario
  MEUsuario.AbrirMe(Usuario);
  MEUsuario.Buscar(Usuario, formUsuario.labelMail.Caption, posPri);
  MEUsuario.CapturarInfo(Usuario, reg, posPri);
  idUsuario:= reg.IDUsuario;
  MEUsuario.CerrarMe(Usuario);

  contador:=1;
  MEArticulosPublicados.abrir(Publicado);
  cargarMisCompras(Publicado, MEArticulosPublicados.raizCategoria(Publicado), idUsuario, contador);
  MEArticulosPublicados.cerrar(Publicado);
end;

procedure TformUsuario.cargarMisCompras(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; idUsuario: integer; var contador: integer);
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;
  reg: MEUsuario.tiporegListaDatosHash;
  posPri, posSeg :integer;
  corte: boolean;
  regNulo, regVenDat:MEVentas.tiporegDatos;
  regVenInd: MEVentas.tipoRegIndice;
  calificacion: string;
begin
  If pos<>MEArticulosPublicados.posNula(Arbol) then
  begin
    MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);

    if (regDatos.estadoPublicacion = 3) and (regDatos.IDcomprador=idUsuario) then
  // =========================================================================== Cargar Cuerpo
        begin
          formMisCompras.stringgridCompras.Cells[0, contador]:= regInd.Clave;
          formMisCompras.stringgridCompras.Cells[1, contador]:= regDatos.NombreArticulo;
          formMisCompras.stringgridCompras.Cells[2, contador]:= datetimetostr(regDatos.fechacierre);

          //Obtener VENDEDOR
          MEUsuario.AbrirMe(Usuario);
          posPri:= MEUsuario.primeroListaDoble(Usuario);
          while (posPri<>MEUsuario._posnula) do
          begin
            posSeg:= MEUsuario.primeroListaDobleParciales(Usuario, posPri);
            While (posSeg<>MEUsuario._posnula) do
            begin
              MEUsuario.CapturarInfo(Usuario, reg, posSeg);
              if (reg.IDUsuario=regDatos.IDVendedor) then
              begin
                formMisCompras.stringgridCompras.Cells[3, contador]:= reg.Clave;
              end;
            posSeg:= MEUsuario.proximoListaDobleParciales(Usuario, posSeg, reg);
            end;
            posPri:= MEUsuario.proximoListaDoble(Usuario, posPri);
          end;
          MEUsuario.CerrarMe(Usuario);

          formMisCompras.stringgridCompras.Cells[4, contador]:= floattostr(regDatos.precio);
          //obtener Calificacion
          MEVentas.abrir(Venta);
          //showmessage(inttostr(idUsuario));
          if MEVentas.buscar(Venta, idUsuario, posPri) then
          begin
           //showmessage('paso');
          corte:= false;
          regNulo.clave:= -1;
          regNulo.siguiente:= -1;
          regVenInd:= MEVentas.obtenerIndice(Venta, posPri);
          TDAColasParcialesV.Encolar(Venta, regNulo, regVenInd, posPri);
          while not corte do
          begin
            TDAColasParcialesV.Frente(Venta, regVenDat, regVenInd);
            TDAColasParcialesV.Decolar(Venta, regVenInd, posPri);
            if regVenDat.clave<>-1 then
            begin
              //showmessage(booltostr(regVenDat.comisionCobrada));
              if (strtoint(regDatos.Clave)=regVenDat.Clave) then
              begin
                case (regVenDat.calificacion) of
                 0: calificacion:='Sin calificar';
                 1: calificacion:='Recomendable';
                 2: calificacion:='Neutral';
                 3: calificacion:='No Recomendable';
                end;//Case

                if regVenDat.comisionCobrada then
                  formMisCompras.stringgridCompras.Cells[6, contador]:= 'Pagado'
                else
                  formMisCompras.stringgridCompras.Cells[6, contador]:= 'No Pagado';
              end;//if

              TDAColasParcialesV.Encolar(Venta, regVenDat, regVenInd, posPri);
            end
            else
              corte:=true;
          end; //While-corte
          end; // Conversacion Encontrada
          MEVentas.cerrar(Venta);

          formMisCompras.stringgridCompras.Cells[5, contador]:= calificacion; //0=Sin calificar a?n; 1=Recomendable; 2=Neutral; 3=No recomendable;

          contador:= contador +1;
          formMisCompras.stringgridCompras.RowCount:= contador;
        end;

    cargarMisCompras(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), idUsuario, contador);
    cargarMisCompras(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), idUsuario, contador);
  end;

end;

procedure TformUsuario.btnMisVentasClick(Sender: TObject);
begin
  formMisVentas.show;
  formUsuario.close;
  formMisVentas.DateTimePickerDesde.DateTime:= strtodatetime('1/1/2022');
  formMisVentas.DateTimePickerHasta.DateTime:= strtodatetime('1/1/2023');
  formMisVentas.ComboBoxCalificacion.Clear;
  formMisVentas.ComboBoxCalificacion.Items.Add('Todos');
  formMisVentas.ComboBoxCalificacion.Items.Add('Sin Calificar');
  formMisVentas.ComboBoxCalificacion.Items.Add('Recomendable');
  formMisVentas.ComboBoxCalificacion.Items.Add('Neutral');
  formMisVentas.ComboBoxCalificacion.Items.Add('No Recomendable');
  formMisVentas.ComboBoxCalificacion.itemindex:=0;
  cargarMisVentas(99); // 99-> Sin Filtro
end;

procedure TformUsuario.cargarMisVentas(tipo:integer);
var
  pos, cont, cont1, contador, idUsuario,posPri: integer;
  corte, corteInd: boolean;
  reg: MEUsuario.tiporegListaDatosHash;
  regNuloDat, regVenDat: MEVentas.tiporegDatos;
  regVenInd, regNuloInd: MEVentas.tipoRegIndice;
  calificacion: string;
begin
  // ============================================================================= Limpiar tabla
  for cont :=0 to formMisVentas.StringGridMisVentas.colcount-1 do
    for cont1 :=0 to formMisVentas.StringGridMisVentas.rowcount-1 do
      formMisVentas.StringGridMisVentas.Cells[cont,cont1] := '';

  //============================================================================== Cabecera publicados
  formMisVentas.StringGridMisVentas.Cells[0, 0]:= 'Titulo';
  formMisVentas.StringGridMisVentas.Cells[1, 0]:= 'Fecha Compra';
  formMisVentas.StringGridMisVentas.Cells[2, 0]:= 'Comprador';
  formMisVentas.StringGridMisVentas.Cells[3, 0]:= 'Importe';
  formMisVentas.StringGridMisVentas.Cells[4, 0]:= 'Calificacion';
  formMisVentas.StringGridMisVentas.Cells[5, 0]:= '-Pagado';

  //Obtener ID usuario
  MEUsuario.AbrirMe(Usuario);
  MEUsuario.Buscar(Usuario, formUsuario.labelMail.Caption, pos);
  MEUsuario.CapturarInfo(Usuario, reg, pos);
  idUsuario:= reg.IDUsuario;
  MEUsuario.CerrarMe(Usuario);

  contador:=0;
  // Cargar Cuerpo
  MEVentas.abrir(Venta);
  corteInd:= false;
  regNuloInd.clave:= -1;
  regNuloInd.siguiente:= -1;
  TDAColaV.Encolar(Venta, regNuloInd, posPri);
  while not corteInd do
  begin
    posPri:=TDAColaV.Frente(Venta, regVenInd);
    TDAColaV.Decolar(Venta);
    if (regVenInd.clave<>-1) then
    begin
      //---------------------------------------------------------------- Recorrer Dentro
      corte:= false;
      regNuloDat.clave:= -1;
      regNuloDat.siguiente:= -1;
      regVenInd:= MEVentas.obtenerIndice(Venta, posPri);
      TDAColasParcialesV.Encolar(Venta, regNuloDat, regVenInd, posPri);
      while not corte do
      begin
        TDAColasParcialesV.Frente(Venta, regVenDat, regVenInd);
        TDAColasParcialesV.Decolar(Venta, regVenInd, posPri);
        if regVenDat.clave<>-1 then
        begin
          if(regVenDat.IDVendedor=idUsuario) then
          contador:= contador+1;
        TDAColasParcialesV.Encolar(Venta, regVenDat, regVenInd, posPri);
        end
        else
          corte:=true;
      end; //While Datos
      TDAColaV.Encolar(Venta, regVenInd, posPri);
      //---------------------------------------------------------------- Recorrer Dentro
    end // If clave<>-1
    else corteInd:=true;
  end;// While Indice


  if (tipo=99) then
  begin
    if contador>0 then
    begin
      setLength(vectorVentas, contador);
      contador:=0;

      corteInd:= false;
      regNuloInd.clave:= -1;
      regNuloInd.siguiente:= -1;
      TDAColaV.Encolar(Venta, regNuloInd, posPri);
      while not corteInd do
      begin
        posPri:=TDAColaV.Frente(Venta, regVenInd);
        TDAColaV.Decolar(Venta);
        if (regVenInd.clave<>-1) then
        begin
          //---------------------------------------------------------------- Recorrer Dentro
          corte:= false;
          regNuloDat.clave:= -1;
          regNuloDat.siguiente:= -1;
          regVenInd:= MEVentas.obtenerIndice(Venta, posPri);
          TDAColasParcialesV.Encolar(Venta, regNuloDat, regVenInd, posPri);
          while not corte do
          begin
            TDAColasParcialesV.Frente(Venta, regVenDat, regVenInd);
            TDAColasParcialesV.Decolar(Venta, regVenInd, posPri);
            if regVenDat.clave<>-1 then
            begin
              if(regVenDat.IDVendedor=idUsuario) then
              begin
                formMisVentas.StringGridMisVentas.Cells[0, contador+1]:= regVenDat.nombreArticulo;
                formMisVentas.StringGridMisVentas.Cells[1, contador+1]:= datetimetostr(regVenDat.fechaVenta);
                formMisVentas.StringGridMisVentas.Cells[2, contador+1]:= regVenDat.ClaveComprador; // MAIL COMPRADOR
                formMisVentas.StringGridMisVentas.Cells[3, contador+1]:= floattostr(regVenDat.precioVenta);
                case (regVenDat.calificacion) of
                   0: calificacion:='Sin calificar';
                   1: calificacion:='Recomendable';
                   2: calificacion:='Neutral';
                   3: calificacion:='No Recomendable';
                  end;//Case
                formMisVentas.StringGridMisVentas.Cells[4, contador+1]:= calificacion;
                if regVenDat.comisionCobrada then
                    formMisVentas.StringGridMisVentas.Cells[5, contador+1]:= 'Pagado'
                  else
                    formMisVentas.StringGridMisVentas.Cells[5, contador+1]:= 'No Pagado';
                vectorVentas[contador]:= regVenDat;
                contador:= contador+1;
              end;
            TDAColasParcialesV.Encolar(Venta, regVenDat, regVenInd, posPri);
            end
            else
              corte:=true;
          end; //While Datos
          TDAColaV.Encolar(Venta, regVenInd, posPri);
          //---------------------------------------------------------------- Recorrer Dentro
        end // If clave<>-1
        else corteInd:=true;
      end;// While Indice
      formMisVentas.StringGridMisVentas.RowCount:= contador+1;
    end;// If contador>0
  end// tipo = 99
  else begin
  if contador>0 then
    begin
      contador:=0;
      for pos:=0 to length(vectorVentas)-1 do
      begin
        //showmessage(inttostr(tipo));
        if (tipo=98) then  // 98-> sin filtro pero con restricciones de fecha
        begin
          if (formMisVentas.DateTimePickerDesde.DateTime<vectorventas[pos].fechaVenta) and (formMisVentas.DateTimePickerHasta.DateTime>vectorventas[pos].fechaVenta) then
          begin
            formMisVentas.StringGridMisVentas.Cells[0, contador+1]:= vectorventas[pos].nombreArticulo;
            formMisVentas.StringGridMisVentas.Cells[1, contador+1]:= datetimetostr(vectorventas[pos].fechaVenta);
            formMisVentas.StringGridMisVentas.Cells[2, contador+1]:= vectorventas[pos].ClaveComprador; // MAIL COMPRADOR
            formMisVentas.StringGridMisVentas.Cells[3, contador+1]:= floattostr(vectorventas[pos].precioVenta);
            case (vectorventas[pos].calificacion) of
               0: calificacion:='Sin calificar';
               1: calificacion:='Recomendable';
               2: calificacion:='Neutral';
               3: calificacion:='No Recomendable';
              end;//Case
            formMisVentas.StringGridMisVentas.Cells[4, contador+1]:= calificacion;
            if vectorventas[pos].comisionCobrada then
                formMisVentas.StringGridMisVentas.Cells[5, contador+1]:= 'Pagado'
              else
                formMisVentas.StringGridMisVentas.Cells[5, contador+1]:= 'No Pagado';
            contador:=contador+1;
          end; //tipo = 98
        end
        else
        if (vectorventas[pos].calificacion=tipo) and (formMisVentas.DateTimePickerDesde.DateTime<vectorventas[pos].fechaVenta) and (formMisVentas.DateTimePickerHasta.DateTime>vectorventas[pos].fechaVenta) then
        begin
          formMisVentas.StringGridMisVentas.Cells[0, contador+1]:= vectorventas[pos].nombreArticulo;
          formMisVentas.StringGridMisVentas.Cells[1, contador+1]:= datetimetostr(vectorventas[pos].fechaVenta);
          formMisVentas.StringGridMisVentas.Cells[2, contador+1]:= vectorventas[pos].ClaveComprador; // MAIL COMPRADOR
          formMisVentas.StringGridMisVentas.Cells[3, contador+1]:= floattostr(vectorventas[pos].precioVenta);
          case (vectorventas[pos].calificacion) of
             0: calificacion:='Sin calificar';
             1: calificacion:='Recomendable';
             2: calificacion:='Neutral';
             3: calificacion:='No Recomendable';
            end;//Case
          formMisVentas.StringGridMisVentas.Cells[4, contador+1]:= calificacion;
          if vectorventas[pos].comisionCobrada then
              formMisVentas.StringGridMisVentas.Cells[5, contador+1]:= 'Pagado'
            else
              formMisVentas.StringGridMisVentas.Cells[5, contador+1]:= 'No Pagado';
          contador:=contador+1;
        end;//filtro
      end; // For
      formMisVentas.StringGridMisVentas.RowCount:= contador+1;
    end;// If contador>0
  end; // Filtro segun la eleccion
  MEVentas.cerrar(Venta);
end;

procedure TformUsuario.BitBtn1Click(Sender: TObject);
begin
  showmessage('*Doble Click* sobre la publicacion'+#13+
              'para obtener mas detalles de la publicacion.'+#13+
              'Los codigos coloreados pertenecen al usuario logueado.');
end;


procedure TformUsuario.StringGridPublicacionesDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  var
  pos: integer;
  reg: MEUsuario.tiporeglistadatoshash;
  vectorArticulos: array of MEArticulosPublicados.tipoRegDatos;
begin

if labelMail.caption <> 'Modo Visita' then begin
MEUsuario.AbrirMe(Usuario);
MEUsuario.Buscar(Usuario, labelMail.Caption, pos);
MEUsuario.CapturarInfo(usuario, reg, pos);
MEUsuario.CerrarMe(Usuario);
end;

SetLength(vectorArticulos, strtoint(labelContador.caption)-1);
MEArticulosPublicados.abrir(Publicado);
pos:= 0; //reutilizo variable
recorrerFiltro(Publicado, MEArticulosPublicados.raizCategoria(Publicado), pos, vectorArticulos);
MEArticulosPublicados.cerrar(Publicado);

with Sender as TStringGrid do
for pos:=0 to length(vectorArticulos)-1 do
begin
  if vectorArticulos[pos].IDVendedor = reg.IDUsuario then
    if ((cells[ACol, ARow]) = (inttostr(vectorArticulos[pos].IDCategoria) + vectorArticulos[pos].Clave)) then
    begin
      Canvas.Brush.Color:= clMoneyGreen;
      Canvas.FillRect(Rect);
      Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, cells[ACol, ARow]);
    end
end; //for

end;

end.






