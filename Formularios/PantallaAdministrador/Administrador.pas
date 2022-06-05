unit Administrador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, MEUsuario, TiposYconstantes, StdCtrls, MECategorias, MEArticulosPublicados, TDAHashCerrado;

type
  TformAdministrador = class(TForm)
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    btnCategorias: TButton;
    btnPublicaciones: TButton;
    btnUsuarios: TButton;
    btnHerramientas: TButton;
    procedure Salir1Click(Sender: TObject);
    procedure btnCategoriasClick(Sender: TObject);
    procedure btnUsuariosClick(Sender: TObject);
    procedure btnPublicacionesClick(Sender: TObject);
    procedure btnHerramientasClick(Sender: TObject);
  private
    procedure recorrer(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; var vectorContador: array of integer; idCategoria: integer);
    procedure recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion;var ventas: integer; usuarioID: integer; tipo: integer);
    procedure ordenamientoBurbuja(var Vector: array of MEUsuario.tiporegListaDatosHash);
    //procedure recorrerPublicaciones(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; var contador: integer);
  public
    procedure cargarComboBoxPublicaciones();
    procedure cargarStringGridUsuarios(filtrar: integer);
    procedure cargarPublicacionesAdmin(filtrar: boolean; vendedor: integer);

  end;

var
  formAdministrador: TformAdministrador;
  vectorUsuarios: array of  MEUsuario.tiporegListaDatosHash;
  vectorContador: array [0..3] of integer;

implementation

uses AdmUsuario, PublicacionesAdmin, PantallaUsuario, OpcUsuario, Publicaciones, Listado, Login, Categorias,
  Herramientas;

{$R *.dfm}

procedure TformAdministrador.Salir1Click(Sender: TObject);
var
  pos: integer;
  regUsuario: MEUsuario.tiporegListaDatosHash;
begin
  MEUsuario.AbrirMe(Usuario);
  MEUsuario.Buscar(Usuario, 'administrador@ventalibre.com', pos);
  MEUsuario.CapturarInfo(Usuario, regUsuario,pos);
  MEUsuario.salidaUsuario(Usuario, pos, regUsuario);
  MEUsuario.CerrarMe(Usuario);
  formAdministrador.Close;
  formLogin.show();
end;// Salir1Click

procedure TformAdministrador.btnCategoriasClick(Sender: TObject);
var
  posElementCategoria, contadorFilas, pos, cont, cont1: integer;
  regCategoria: MECategorias.TipoRegDatos;
begin
  contadorFilas:=1;

  // =========================================================================== Limpiar tabla
  for cont :=0 to FormCategorias.StringGridCategorias.colcount-1 do
    for cont1 :=0 to FormCategorias.StringGridCategorias.rowcount-1 do
      FormCategorias.StringGridCategorias.Cells[cont,cont1] := '';

  // =========================================================================== Cargar Cabecera StringGridCategorias
  FormCategorias.StringGridCategorias.Cells[0, 0]:= 'COD.';
  FormCategorias.StringGridCategorias.Cells[1, 0]:= 'NOMBRE';
  FormCategorias.StringGridCategorias.Cells[2, 0]:= 'COMISION';
  FormCategorias.StringGridCategorias.Cells[3, 0]:= 'PUBLICADOS';
  FormCategorias.StringGridCategorias.Cells[4, 0]:= 'VENDIDOS';
  FormCategorias.StringGridCategorias.Cells[5, 0]:= 'PAUSADOS';
  FormCategorias.StringGridCategorias.Cells[6, 0]:= 'BLOQUEADOS';

  FormCategorias.StringGridCategorias.ColWidths[0]:=50;

  // =========================================================================== Cargar Tabla StringGridCategorias

  MECategorias.CrearLd(Categoria, TiposYconstantes.carpArchivos, 'Categoria');
  MECategorias.AbrirMe(Categoria);

  posElementCategoria:= MECategorias.Primero(Categoria);

  while posElementCategoria<>MECategorias.PosNula(Categoria) do
  begin
    MECategorias.Capturar(Categoria, posElementCategoria, regCategoria);

    vectorContador[0]:= 0;
    vectorContador[1]:= 0;
    vectorContador[2]:= 0;
    vectorContador[3]:= 0;

    MEArticulosPublicados.abrir(Publicado);
    if not (MEArticulosPublicados.vacioCategorias(Publicado)) then
      recorrer(Publicado, MEArticulosPublicados.raizCategoria(Publicado), vectorContador, regCategoria.Clave);
    MEArticulosPublicados.cerrar(Publicado);


    FormCategorias.StringGridCategorias.Cells[0, contadorFilas]:= inttostr(regCategoria.Clave);
    FormCategorias.StringGridCategorias.Cells[1, contadorFilas]:= regCategoria.categoria;
    FormCategorias.StringGridCategorias.Cells[2, contadorFilas]:= inttostr(regCategoria.comision)+' %';
    FormCategorias.StringGridCategorias.Cells[3, contadorFilas]:= inttostr(vectorContador[0]);
    FormCategorias.StringGridCategorias.Cells[4, contadorFilas]:= inttostr(vectorContador[1]);
    FormCategorias.StringGridCategorias.Cells[5, contadorFilas]:= inttostr(vectorContador[2]);
    FormCategorias.StringGridCategorias.Cells[6, contadorFilas]:= inttostr(vectorContador[3]);

    contadorFilas:= contadorFilas + 1;
    FormCategorias.StringGridCategorias.RowCount:= contadorFilas;
    posElementCategoria:= MECategorias.Proximo(Categoria, posElementCategoria);
  end; // WHILE - Recorrer cada CATEGORIA

  MECategorias.CerrarMe(Categoria);

  formCategorias.Show;
  formAdministrador.Close;
end;

// Recorrido PreOrden RECURSIVO
procedure TformAdministrador.recorrer(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; var vectorContador: array  of integer; idCategoria: integer);
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;
  estado: string;
begin
  If pos<>MEArticulosPublicados.posNula(Arbol) then
  begin
    MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);

    if (idCategoria=regDatos.IDCategoria) then
    begin
      //showmessage(inttostr(regDatos.estadoPublicacion));
      if (regDatos.estadoPublicacion=1) then   // PUBLICADO
        vectorContador[0]:= vectorContador[0] + 1;
      if (regDatos.estadoPublicacion=3) then   // VENDIDO
        vectorContador[1]:= vectorContador[1] + 1;
      if (regDatos.estadoPublicacion=2) then   // PAUSADO
        vectorContador[2]:= vectorContador[2] + 1;
      if (regDatos.estadoPublicacion=5) then   // BLOQUEADO
        vectorContador[3]:= vectorContador[3] + 1;
    end; //if =

    recorrer(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), vectorContador, idCategoria);
    recorrer(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), vectorContador, idCategoria);
  end;
end; //recorrer

procedure TformAdministrador.btnUsuariosClick(Sender: TObject);
begin
cargarStringGridUsuarios(1);
end;

procedure TformAdministrador.cargarStringGridUsuarios(filtrar: integer); {1: Sin filtro, 0: mas vendidos, 2: Bloqueados}
var
  cont, cont1, posPri, posSeg, contador, ventas, contadorUsuarios, i,j, posUsu: integer;
  reg:MEUsuario.tiporegListaDatosHash;

begin
   contadorUsuarios:=0;
  //=========================================================================== Contar cant Usuarios
  MEUsuario.AbrirMe(Usuario);
  posPri:= MEUsuario.primeroListaDoble(Usuario);
  while (posPri<>MEUsuario._posnula) do
  begin
    posSeg:= MEUsuario.primeroListaDobleParciales(Usuario, posPri);
    //showmessage(inttostr(posSeg));
    While (posSeg<>MEUsuario._posnula) do
    begin
    MEUsuario.CapturarInfo(Usuario, reg, posSeg);
     if (reg.Clave<>'administrador@ventalibre.com') then
      contadorUsuarios:= contadorUsuarios + 1;
    posSeg:= MEUsuario.proximoListaDobleParciales(Usuario, posSeg, reg);
    end;
    posPri:= MEUsuario.proximoListaDoble(Usuario, posPri);
  end;
  MEUsuario.CerrarMe(Usuario);

  SetLength(vectorUsuarios, contadorUsuarios);

  contador:=1;
  FormAdmUsuarios.StringGridUsuarios.colcount:= 9;
  FormAdmUsuarios.StringGridUsuarios.rowcount:= 2;

  //=========================================================================== Limpiar tabla
  for cont :=0 to FormAdmUsuarios.StringGridUsuarios.colcount-1 do
    for cont1 :=0 to FormAdmUsuarios.StringGridUsuarios.rowcount-1 do
      FormAdmUsuarios.StringGridUsuarios.Cells[cont,cont1] := '';
  //============================================================================ Cargar Cabecera

  FormAdmUsuarios.StringGridUsuarios.FixedRows:= 1;
  FormAdmUsuarios.StringGridUsuarios.Cells[0, 0]:= 'ID';
  FormAdmUsuarios.StringGridUsuarios.Cells[1, 0]:= 'Nombre';
  FormAdmUsuarios.StringGridUsuarios.Cells[2, 0]:= 'MAIL';
  FormAdmUsuarios.StringGridUsuarios.Cells[3, 0]:= 'Direccion';
  FormAdmUsuarios.StringGridUsuarios.Cells[4, 0]:= 'Alta';
  FormAdmUsuarios.StringGridUsuarios.Cells[5, 0]:= 'Ult. Conexion';
  FormAdmUsuarios.StringGridUsuarios.Cells[6, 0]:= 'Estado';
  FormAdmUsuarios.StringGridUsuarios.Cells[7, 0]:= 'Acceso';
  FormAdmUsuarios.StringGridUsuarios.Cells[8, 0]:= 'Ventas';

  FormAdmUsuarios.StringGridUsuarios.ColWidths[0]:=43;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[1]:=150;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[2]:= 250;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[4]:= 185;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[5]:=185;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[6]:=109;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[7]:=109;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[8]:=86;

  formAdmUsuarios.StringGridUsuarios.RowCount:=2;
  FormAdmUsuarios.StringGridUsuarios.FixedRows:= 1;

  //============================================================================ Cargar Cuerpo

  MEUsuario.AbrirMe(Usuario);

  posPri:= MEUsuario.primeroListaDoble(Usuario);
  while (posPri<>MEUsuario._posnula) do
  begin
    posSeg:= MEUsuario.primeroListaDobleParciales(Usuario, posPri);
    //showmessage(inttostr(posSeg));
    While (posSeg<>MEUsuario._posnula) do
    begin
    MEUsuario.CapturarInfo(Usuario, reg, posSeg);
     if (reg.Clave<>'administrador@ventalibre.com') then
      begin
        if filtrar=1 then
        begin
          //--------------------- VENTAS
          ventas:=0;
          MEArticulosPublicados.abrir(Publicado);
          recorrerArbol(Publicado, MEArticulosPublicados.raizCategoria(Publicado), ventas, reg.IDUsuario, 1);
          MEArticulosPublicados.cerrar(Publicado);
          //----------------------------
          FormAdmUsuarios.StringGridUsuarios.Cells[0, contador]:= inttostr(reg.IDUsuario);
          FormAdmUsuarios.StringGridUsuarios.Cells[1, contador]:= reg.nombre;
          FormAdmUsuarios.StringGridUsuarios.Cells[2, contador]:= reg.Clave;
          FormAdmUsuarios.StringGridUsuarios.Cells[3, contador]:= reg.domicilio;
          FormAdmUsuarios.StringGridUsuarios.Cells[4, contador]:= DateTimeToStr(reg.fechaAlta);
          FormAdmUsuarios.StringGridUsuarios.Cells[5, contador]:= DateTimeToStr(reg.fechaConexion);
          FormAdmUsuarios.StringGridUsuarios.Cells[8, contador]:= inttostr(ventas);

          if reg.estado then
            FormAdmUsuarios.StringGridUsuarios.Cells[6, contador]:= 'Conectado'
          else
            FormAdmUsuarios.StringGridUsuarios.Cells[6, contador]:= 'Desconectado';
          if reg.bloqueado then
            FormAdmUsuarios.StringGridUsuarios.Cells[7, contador]:= 'Bloqueado'
          else
            FormAdmUsuarios.StringGridUsuarios.Cells[7, contador]:= 'Desbloqueado';

          reg.ventas:= ventas;
          MEUsuario.Buscar(Usuario, reg.Clave, posUsu);
          MEUsuario.modificar(Usuario, reg, posUsu);

          VectorUsuarios[contador-1]:= reg;
          contador:= contador + 1;
        end // Sin FILTRO
        else if (filtrar=2) and (reg.bloqueado) then
        begin
          //--------------------- VENTAS
          ventas:=0;
          MEArticulosPublicados.abrir(Publicado);
          recorrerArbol(Publicado, MEArticulosPublicados.raizCategoria(Publicado), ventas, reg.IDUsuario, 1);
          MEArticulosPublicados.cerrar(Publicado);
          //----------------------------
          FormAdmUsuarios.StringGridUsuarios.Cells[0, contador]:= inttostr(reg.IDUsuario);
          FormAdmUsuarios.StringGridUsuarios.Cells[1, contador]:= reg.nombre;
          FormAdmUsuarios.StringGridUsuarios.Cells[2, contador]:= reg.Clave;
          FormAdmUsuarios.StringGridUsuarios.Cells[3, contador]:= reg.domicilio;
          FormAdmUsuarios.StringGridUsuarios.Cells[4, contador]:= DateTimeToStr(reg.fechaAlta);
          FormAdmUsuarios.StringGridUsuarios.Cells[5, contador]:= DateTimeToStr(reg.fechaConexion);
          FormAdmUsuarios.StringGridUsuarios.Cells[8, contador]:= inttostr(ventas);

          if reg.estado then
            FormAdmUsuarios.StringGridUsuarios.Cells[6, contador]:= 'Conectado'
          else
            FormAdmUsuarios.StringGridUsuarios.Cells[6, contador]:= 'Desconectado';
          if reg.bloqueado then
            FormAdmUsuarios.StringGridUsuarios.Cells[7, contador]:= 'Bloqueado'
          else
            FormAdmUsuarios.StringGridUsuarios.Cells[7, contador]:= 'Desbloqueado';
          contador:= contador + 1;
        end;// Filtro BLOQUEADO
      end;// Si no es ADMINISTRADOR
    FormAdmUsuarios.StringGridUsuarios.RowCount:= contador;
    posSeg:= MEUsuario.proximoListaDobleParciales(Usuario, posSeg, reg);
    end;
    posPri:= MEUsuario.proximoListaDoble(Usuario, posPri);
  end;

  MEUsuario.CerrarMe(Usuario);

  if (filtrar=0) then
  begin
  //=========================================================================== Limpiar tabla
  for cont :=0 to FormAdmUsuarios.StringGridUsuarios.colcount-1 do
    for cont1 :=0 to FormAdmUsuarios.StringGridUsuarios.rowcount-1 do
      FormAdmUsuarios.StringGridUsuarios.Cells[cont,cont1] := '';

  //============================================================================ Cargar Cabecera
  FormAdmUsuarios.StringGridUsuarios.Cells[0, 0]:= 'ID';
  FormAdmUsuarios.StringGridUsuarios.Cells[1, 0]:= 'Nombre';
  FormAdmUsuarios.StringGridUsuarios.Cells[2, 0]:= 'MAIL';
  FormAdmUsuarios.StringGridUsuarios.Cells[3, 0]:= 'Direccion';
  FormAdmUsuarios.StringGridUsuarios.Cells[4, 0]:= 'Alta';
  FormAdmUsuarios.StringGridUsuarios.Cells[5, 0]:= 'Ult. Conexion';
  FormAdmUsuarios.StringGridUsuarios.Cells[6, 0]:= 'Estado';
  FormAdmUsuarios.StringGridUsuarios.Cells[7, 0]:= 'Acceso';
  FormAdmUsuarios.StringGridUsuarios.Cells[8, 0]:= 'Ventas';

  FormAdmUsuarios.StringGridUsuarios.ColWidths[0]:=43;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[1]:=150;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[2]:= 250;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[4]:= 185;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[5]:=185;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[6]:=109;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[7]:=109;
  FormAdmUsuarios.StringGridUsuarios.ColWidths[8]:=86;
  ordenamientoBurbuja(vectorUsuarios);// +++++++++++++++++++++++++++++++++++++++ ORDENAR VECTOR
  for i:=0 to length(vectorUsuarios)-1 do
  begin
    FormAdmUsuarios.StringGridUsuarios.Cells[0, contador]:= inttostr(vectorUsuarios[i].IDUsuario);
    FormAdmUsuarios.StringGridUsuarios.Cells[1, contador]:= vectorUsuarios[i].nombre;
    FormAdmUsuarios.StringGridUsuarios.Cells[2, contador]:= vectorUsuarios[i].Clave;
    FormAdmUsuarios.StringGridUsuarios.Cells[3, contador]:= vectorUsuarios[i].domicilio;
    FormAdmUsuarios.StringGridUsuarios.Cells[4, contador]:= DateTimeToStr(vectorUsuarios[i].fechaAlta);
    FormAdmUsuarios.StringGridUsuarios.Cells[5, contador]:= DateTimeToStr(vectorUsuarios[i].fechaConexion);
    FormAdmUsuarios.StringGridUsuarios.Cells[8, contador]:= inttostr(vectorUsuarios[i].ventas);

    if vectorUsuarios[i].estado then
      FormAdmUsuarios.StringGridUsuarios.Cells[6, contador]:= 'Conectado'
    else
      FormAdmUsuarios.StringGridUsuarios.Cells[6, contador]:= 'Desconectado';
    if vectorUsuarios[i].bloqueado then
      FormAdmUsuarios.StringGridUsuarios.Cells[7, contador]:= 'Bloqueado'
    else
      FormAdmUsuarios.StringGridUsuarios.Cells[7, contador]:= 'Desbloqueado';
    contador:= contador + 1;
  end;//for
  FormAdmUsuarios.StringGridUsuarios.RowCount:= contador;
  end;// Filtrar mas ventas

  formAdmusuarios.show;
  formAdministrador.close;

  if formAdmUsuarios.StringGridUsuarios.RowCount = 1 then
    formAdmUsuarios.StringGridUsuarios.RowCount:=2;
  FormAdmUsuarios.StringGridUsuarios.FixedRows:= 1;

end;

procedure TformAdministrador.ordenamientoBurbuja(var Vector: array of MEUsuario.tiporegListaDatosHash);
var
  i, j: integer;
  datosAux: MEUsuario.tiporegListaDatosHash;
begin
//----------------------------------------- MAYOR - MENOR
  for i:=0 to length(Vector)-1 do
    for j:=0 to length(Vector)-2 do
      if (Vector[j].ventas<Vector[j+1].ventas) then
      begin
        datosAux:= Vector[j];
        Vector[j]:= Vector[j+1];
        Vector[j+1]:= datosAux;
      end;
end;

// Recorrido PreOrden RECURSIVO
procedure TformAdministrador.recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion;
var ventas: integer; usuarioID: integer; tipo: integer); {tipo = 1 -> conta Ventas, tipo = 2 -> mostrar Publicaciones, tipo = 3 -> mostrar usuario seleccionado}
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;
  regCat: MECategorias.TipoRegDatos;
  regUsu: MEUsuario.tiporegListaDatosHash;
  estado: string;
  posCat, posPri, posSeg: integer;
  cortar: boolean;
begin
  If pos<>MEArticulosPublicados.posNula(Arbol) then
  begin
    MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);

    if (tipo=1) then
    begin
      if (regDatos.estadoPublicacion=3) and (regDatos.IDVendedor=usuarioID) then   //VENDIDO
      begin
        ventas:= ventas + 1;
        contador:= contador +1;
        formAdmUsuarios.StringGridUsuarios.RowCount:= contador;
      end;
    end // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Tipo 1
    else if (tipo=2) then
          begin
            formPublicacionesAdmin.StringGridPublicaciones.Cells[0, contador]:= regInd.Clave; //Clave
            formPublicacionesAdmin.StringGridPublicaciones.Cells[1, contador]:= regDatos.NombreArticulo; //Titulo
            formPublicacionesAdmin.StringGridPublicaciones.Cells[2, contador]:= floattostr(regDatos.precio); //Precio
            MECategorias.CrearLd(Categoria, TiposYconstantes.carpArchivos, 'Categoria');
            MECategorias.AbrirMe(Categoria);
            MECategorias.Buscar(Categoria, regDatos.IDCategoria, posCat);
            MECategorias.Capturar(Categoria, posCat, regCat);
            MECategorias.CerrarMe(Categoria);
            formPublicacionesAdmin.StringGridPublicaciones.Cells[3, contador]:= inttostr(regCat.comision) +' %'; //Comision
            formPublicacionesAdmin.StringGridPublicaciones.Cells[4, contador]:= DateTimeToStr(regDatos.fechapublicacion); //Fecha publicacion
            formPublicacionesAdmin.StringGridPublicaciones.Cells[5, contador]:= DateTimetostr(regDatos.fechaCierre);//Fecha caducidad
            MEUsuario.AbrirMe(Usuario);
            posPri:= MEUsuario.primeroListaDoble(Usuario);
            cortar:=false;
            while (posPri<>MEUsuario._posnula) and not cortar do
            begin
              posSeg:= MEUsuario.primeroListaDobleParciales(Usuario, posPri);
              While (posSeg<>MEUsuario._posnula) and not cortar do
              begin
                MEUsuario.CapturarInfo(Usuario, regUsu, posSeg);
                if (regUsu.IDUsuario=regDatos.IDVendedor) then
                begin
                  formPublicacionesAdmin.StringGridPublicaciones.Cells[6, contador]:=  regUsu.clave; //Vendedor
                  cortar:= true;
                end;
                posSeg:= MEUsuario.proximoListaDobleParciales(Usuario, posSeg, regUsu);
              end;
              posPri:= MEUsuario.proximoListaDoble(Usuario, posPri);
            end;
            MEUsuario.CerrarMe(Usuario);
            if (regDatos.IDcomprador=999999999) then // -> 999999999 cod de comprador Invalido
              formPublicacionesAdmin.StringGridPublicaciones.Cells[7, contador]:= ' ------------- ' //Comprador
            else begin
                formPublicacionesAdmin.StringGridPublicaciones.Cells[7, contador]:=  regDatos.mailComprador ; //Comprador
            end;

            Case (regDatos.estadoPublicacion) of
              1: estado:= 'Publicado';
              2: estado:= 'Pausado';
              3: estado:= 'Vendido';
              4: estado:= 'Anulado';
              5: estado:= 'Bloqueado';
            end;
            formPublicacionesAdmin.StringGridPublicaciones.Cells[8, contador]:= estado; //Estado

            contador:= contador +1;
            formPublicacionesAdmin.StringGridPublicaciones.RowCount:= contador;
            formListadoPublicaciones.labelRow.caption:= inttostr(contador);
          end // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Tipo 2
          else if (tipo=3) then
              begin
              if (regDatos.IDVendedor=usuarioID) then
              begin
                formPublicacionesAdmin.StringGridPublicaciones.Cells[0, contador]:= regInd.Clave; //Clave
                formPublicacionesAdmin.StringGridPublicaciones.Cells[1, contador]:= regDatos.NombreArticulo; //Titulo
                formPublicacionesAdmin.StringGridPublicaciones.Cells[2, contador]:= floattostr(regDatos.precio); //Precio
                MECategorias.CrearLd(Categoria, TiposYconstantes.carpArchivos, 'Categoria');
                MECategorias.AbrirMe(Categoria);
                MECategorias.Buscar(Categoria, regDatos.IDCategoria, posCat);
                MECategorias.Capturar(Categoria, posCat, regCat);
                MECategorias.CerrarMe(Categoria);
                formPublicacionesAdmin.StringGridPublicaciones.Cells[3, contador]:= inttostr(regCat.comision) +' %'; //Comision
                formPublicacionesAdmin.StringGridPublicaciones.Cells[4, contador]:= DateTimeToStr(regDatos.fechapublicacion); //Fecha publicacion
                formPublicacionesAdmin.StringGridPublicaciones.Cells[5, contador]:= DateTimetostr(regDatos.fechaCierre);//Fecha caducidad
                MEUsuario.AbrirMe(Usuario);
                posPri:= MEUsuario.primeroListaDoble(Usuario);
                cortar:=false;
                while (posPri<>MEUsuario._posnula) and not cortar do
                begin
                  posSeg:= MEUsuario.primeroListaDobleParciales(Usuario, posPri);
                  While (posSeg<>MEUsuario._posnula) and not cortar do
                  begin
                    MEUsuario.CapturarInfo(Usuario, regUsu, posSeg);
                    if (regUsu.IDUsuario=regDatos.IDVendedor) then
                    begin
                      formPublicacionesAdmin.StringGridPublicaciones.Cells[6, contador]:=  regUsu.clave; //Vendedor
                      cortar:= true;
                    end;
                    posSeg:= MEUsuario.proximoListaDobleParciales(Usuario, posSeg, regusu);
                  end;
                  posPri:= MEUsuario.proximoListaDoble(Usuario, posPri);
                end;
                MEUsuario.CerrarMe(Usuario);
                if (regDatos.IDcomprador=999999999) then // -> 999999999 cod de comprador Invalido
                  formPublicacionesAdmin.StringGridPublicaciones.Cells[7, contador]:= ' ------------- ' //Comprador
                else begin
                    formPublicacionesAdmin.StringGridPublicaciones.Cells[7, contador]:=  regDatos.mailComprador ; //Comprador
                end;

                Case (regDatos.estadoPublicacion) of
                  1: estado:= 'Publicado';
                  2: estado:= 'Pausado';
                  3: estado:= 'Vendido';
                  4: estado:= 'Anulado';
                  5: estado:= 'Bloqueado';
                end;
                formPublicacionesAdmin.StringGridPublicaciones.Cells[8, contador]:= estado; //Estado

                contador:= contador +1;
                formPublicacionesAdmin.StringGridPublicaciones.RowCount:= contador;
              end;
              end; // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Tipo 3

    recorrerArbol(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), ventas, usuarioID, tipo);
    recorrerArbol(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), ventas, usuarioID, tipo);
  end;
end; //recorrer

procedure TformAdministrador.cargarPublicacionesAdmin(filtrar: boolean; vendedor: integer); {true: filtra, false: no filtra}
var
  cont, cont1, pos, ventas, IDUsuario: integer;
begin
  formPublicacionesAdmin.show;
  formAdministrador.close;

// ============================================================================ Limpiar tabla
  for cont :=0 to formPublicacionesAdmin.StringGridPublicaciones.colcount-1 do
    for cont1 :=0 to formPublicacionesAdmin.StringGridPublicaciones.rowcount-1 do
      formPublicacionesAdmin.StringGridPublicaciones.Cells[cont,cont1] := '';

// =========================================================================== Cargar Cabecera
  formPublicacionesAdmin.StringGridPublicaciones.Cells[0, 0]:= 'Cod.';
  formPublicacionesAdmin.StringGridPublicaciones.Cells[1, 0]:= 'Titulo';
  formPublicacionesAdmin.StringGridPublicaciones.Cells[2, 0]:= 'Precio';
  formPublicacionesAdmin.StringGridPublicaciones.Cells[3, 0]:= 'Comision';
  formPublicacionesAdmin.StringGridPublicaciones.Cells[4, 0]:= 'Fecha Publicacion';
  formPublicacionesAdmin.StringGridPublicaciones.Cells[5, 0]:= 'Fecha Caducidad';
  formPublicacionesAdmin.StringGridPublicaciones.Cells[6, 0]:= 'Vendedor';
  formPublicacionesAdmin.StringGridPublicaciones.Cells[7, 0]:= 'Comprador';
  formPublicacionesAdmin.StringGridPublicaciones.Cells[8, 0]:= 'Estado';

  formPublicacionesAdmin.StringGridPublicaciones.ColWidths[0]:=50;
  formPublicacionesAdmin.StringGridPublicaciones.ColWidths[2]:=80;
  formPublicacionesAdmin.StringGridPublicaciones.ColWidths[3]:=80;
  formPublicacionesAdmin.StringGridPublicaciones.ColWidths[4]:=144;
  formPublicacionesAdmin.StringGridPublicaciones.ColWidths[5]:=144;
  formPublicacionesAdmin.StringGridPublicaciones.ColWidths[6]:=205;
  formPublicacionesAdmin.StringGridPublicaciones.ColWidths[7]:=205;

  contador:=1;
  ventas:=0;
  MEArticulosPublicados.abrir(Publicado);
  if not filtrar then
  begin
    if not (MEArticulosPublicados.vacioCategorias(Publicado)) then
      recorrerArbol(Publicado, MEArticulosPublicados.raizCategoria(Publicado), ventas, 0, 2);
  end
  else
    if not (MEArticulosPublicados.vacioCategorias(Publicado)) then
    begin
      IDUsuario:= strtoint(trim(Copy((formPublicacionesAdmin.ComboBoxUsuarios.Items[formPublicacionesAdmin.ComboBoxUsuarios.ItemIndex]),0,2)));
      recorrerArbol(Publicado, MEArticulosPublicados.raizCategoria(Publicado), ventas, IDUsuario, 3);
    end;

    if  trim(formPublicacionesAdmin.StringGridPublicaciones.Cells[0, 1])='' then
      formPublicacionesAdmin.StringGridPublicaciones.RowCount:= 2;
  MEArticulosPublicados.cerrar(Publicado);
end;

procedure TformAdministrador.cargarComboBoxPublicaciones();
var
  posPri, posSeg: integer;
  reg:MEUsuario.tiporegListaDatosHash;
begin
formPublicacionesAdmin.ComboBoxUsuarios.Clear;
formPublicacionesAdmin.ComboBoxUsuarios.Items.Add('Todos');
MEUsuario.AbrirMe(Usuario);

  posPri:= MEUsuario.primeroListaDoble(Usuario);
  while (posPri<>MEUsuario._posnula) do
  begin
    posSeg:= MEUsuario.primeroListaDobleParciales(Usuario, posPri);
    While (posSeg<>MEUsuario._posnula) do
    begin
    MEUsuario.CapturarInfo(Usuario, reg, posSeg);
     if (reg.Clave<>'administrador@ventalibre.com') then
      begin
        formPublicacionesAdmin.ComboBoxUsuarios.Items.Add(inttostr(reg.IDUsuario)+' - '+reg.Clave);
      end;// Si no es ADMINISTRADOR
    posSeg:= MEUsuario.proximoListaDobleParciales(Usuario, posSeg, reg);
    end;
    posPri:= MEUsuario.proximoListaDoble(Usuario, posPri);
  end;
  MEUsuario.CerrarMe(Usuario);

  formPublicacionesAdmin.ComboBoxUsuarios.ItemIndex:= 0;
end; // cargarComboBoxPublicaciones

procedure TformAdministrador.btnPublicacionesClick(Sender: TObject);
begin
  cargarPublicacionesAdmin(false, 1);
  formAdministrador.cargarComboBoxPublicaciones();
  formPublicacionesAdmin.ComboBoxUsuarios.ItemIndex:= 0;
  formPublicacionesAdmin.fechaDesde.DateTime:= strtodatetime('1/1/2022');
  formPublicacionesAdmin.fechaHasta.DateTime:= strtodatetime('1/1/2023');
end;
procedure TformAdministrador.btnHerramientasClick(Sender: TObject);
var
  cont, cont1, columna: integer;
begin
  formHerramientas.labeltitulo.Caption:= 'Herramienta';
  formHerramientas.show;
  formAdministrador.close;
  formHerramientas.testDispercion.FixedRows:=1;
  // =========================================================================== Limpiar tabla
  for cont :=0 to FormHerramientas.testDispercion.colcount-1 do
    for cont1 :=0 to FormHerramientas.testDispercion.rowcount-1 do
      FormHerramientas.testDispercion.Cells[cont,cont1] := '';

  // =========================================================================== Cabecera
  for columna:=0 to TiposYconstantes._Hash-1 do
  begin
    FormHerramientas.testDispercion.Cells[columna, 0]:= inttostr(columna+1);
  end;

end;

end.

