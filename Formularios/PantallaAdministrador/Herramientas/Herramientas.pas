unit Herramientas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MEUsuario, Login, Grids, StdCtrls, Menus, TiposYconstantes, MEArticulosPublicados, MEConversaciones, TDACola, TDAColasParciales;

type
  TformHerramientas = class(TForm)
    btnUsuarios: TButton;
    testDispercion: TStringGrid;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    btnCategoria: TButton;
    CheckBoxColor: TCheckBox;
    btnVendedor: TButton;
    labeltitulo: TLabel;
    Label1: TLabel;
    btnConversaciones: TButton;
    procedure btnUsuariosClick(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure testDispercionDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnCategoriaClick(Sender: TObject);
    procedure btnVendedorClick(Sender: TObject);
    procedure btnConversacionesClick(Sender: TObject);
  private
    procedure recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion;  fila, columna, contador: integer; tipo: boolean);
    procedure dibujarArbol(tipo: boolean);
  public
    { Public declarations }
  end;

var
  formHerramientas: TformHerramientas;

implementation

uses AdmUsuario, Administrador;

{$R *.dfm}

procedure TformHerramientas.btnUsuariosClick(Sender: TObject);
var
  fila, columna, posPri, posSeg, cont, cont1: integer;
  reg: MEUsuario.tiporeglistadatoshash;
begin
  labelTitulo.Caption:= 'Test Dispersion';
  checkboxcolor.Checked:= false;
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

  fila:=1;
  columna:=0;
  MEUsuario.AbrirMe(Usuario);
  posPri:= MEUsuario.primeroListaDoble(Usuario);
  while (posPri<>MEUsuario._posnula) do
  begin
    posSeg:= MEUsuario.primeroListaDobleParciales(Usuario, posPri);
    While (posSeg<>MEUsuario._posnula) do
    begin
    MEUsuario.CapturarInfo(Usuario, reg, posSeg);

    FormHerramientas.testDispercion.Cells[columna, fila]:= ' ';  showmessage(reg.nombre);
    fila:=fila+1;
    posSeg:= MEUsuario.proximoListaDobleParciales(Usuario, posSeg, reg);
    end;
    fila:= 1;
    columna:=columna+1;
    posPri:= MEUsuario.proximoListaDoble(Usuario, posPri);
  end;
  MEUsuario.CerrarMe(Usuario);

end;

procedure TformHerramientas.Salir1Click(Sender: TObject);
begin
  formHerramientas.close;
  formAdministrador.show;
end;

procedure TformHerramientas.testDispercionDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
  begin
  if not checkboxcolor.Checked then
  begin
    with Sender as TStringGrid do
    if cells[ACol, ARow] = ' ' then
    begin
      Canvas.Brush.Color:= clGreen;
      Canvas.FillRect(Rect);
      Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, Cells[Acol, ARow]);
    end;
  end else
  begin
    with Sender as TStringGrid do
    if cells[ACol, ARow] <> '' then
    begin
      Canvas.Brush.Color:= clGreen;
      Canvas.FillRect(Rect);
      Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, Cells[Acol, ARow]);
    end;
  end

end;

procedure TformHerramientas.btnCategoriaClick(Sender: TObject);
begin
  labelTitulo.Caption:= 'Arbol Categoria';
  dibujarArbol(true);
end;

procedure TformHerramientas.dibujarArbol(tipo: boolean);
var
  cont, cont1, fila, columna, contador: integer;
begin
// =========================================================================== Limpiar tabla
  for cont :=0 to FormHerramientas.testDispercion.colcount-1 do
    for cont1 :=0 to FormHerramientas.testDispercion.rowcount-1 do
      FormHerramientas.testDispercion.Cells[cont,cont1] := '';

  formHerramientas.testDispercion.FixedRows:=0;
  fila:=0;
  columna:= 35;
  contador:=35;
  MEArticulosPublicados.abrir(Publicado);
  if tipo then
    recorrerArbol(Publicado, MEArticulosPublicados.raizCategoria(Publicado), fila, columna, contador, tipo)
  else
    recorrerArbol(Publicado, MEArticulosPublicados.raizVendedor(Publicado), fila, columna, contador, tipo);
  MEArticulosPublicados.cerrar(Publicado);
end;

// Recorrido PreOrden RECURSIVO
procedure TformHerramientas.recorrerArbol(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion;  fila, columna, contador: integer; tipo: boolean);
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;
  columnaAux: integer;
begin

  If pos<>MEArticulosPublicados.posNula(Arbol) then
  begin
    if tipo then
      MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd)
    else
      MEArticulosPublicados.capturarVendedor(Arbol, pos, regInd);

    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);

    FormHerramientas.testDispercion.Cells[columna, fila]:= regInd.Clave;

    fila:=fila+2;
    contador:= round(contador/2);
    columnaAux:= columna;
    columna:= columna - contador;
    if tipo then
      recorrerArbol(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), fila, columna, contador, tipo)
    else
      recorrerArbol(Arbol, MEArticulosPublicados.hijoIzquierdoVendedor(Arbol, pos), fila, columna, contador, tipo);
    columna:= columnaAux + contador;
    if tipo then
      recorrerArbol(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), fila, columna, contador, tipo)
    else
      recorrerArbol(Arbol, MEArticulosPublicados.hijoDerechoVendedor(Arbol, pos), fila, columna, contador, tipo);
  end;
end; //recorrerArbol

procedure TformHerramientas.btnVendedorClick(Sender: TObject);
begin
  labelTitulo.Caption:= 'Arbol Vendedor';
  dibujarArbol(false);
end;

procedure TformHerramientas.btnConversacionesClick(Sender: TObject);
var
  fila, columna, posPri, posSeg, cont, cont1: integer;
  reg: MEUsuario.tiporeglistadatoshash;

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
begin
  labelTitulo.Caption:= 'Conversaciones';
  checkboxcolor.Checked:= false;
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

  fila:=1;
  columna:=0;
  MEConversaciones.abrir(Conversaciones);

    regNuloIndice.clave:=-1;
    regNuloIndice.siguiente:=-1;
    cortar:= false;
    TDACola.encolar(Conversaciones, regNuloIndice, pos);
    while not cortar do
    begin
        posInd:= TDACola.Frente(Conversaciones, regInd);
        TDACola.Decolar(Conversaciones);
          //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ RECORRER CONVERSACION
          cortarDatos:= false;
          regNuloDatos.clave:= -1;
          regNuloDatos.siguiente:= -1;
          TDAColasParciales.Encolar(Conversaciones, regNuloDatos, regInd, posInd);
          showmessage('Indice '+inttostr(regInd.clave));
          while not cortarDatos do
          begin
            TDAColasParciales.Frente(Conversaciones, regDat, regInd);
            TDAColasParciales.Decolar(Conversaciones, regInd, posInd);
            showmessage('Datos '+inttostr(regDat.clave));
            if regDat.clave<>-1 then
            begin
              FormHerramientas.testDispercion.Cells[regInd.clave, fila]:= ' ';
              fila:=fila+1;
              TDAColasParciales.Encolar(Conversaciones, regDat, regInd, posInd);
            end
            else
              cortarDatos:= true;
          end;//While
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        fila:=1;
        if regInd.clave<>-1 then
          TDACola.Encolar(Conversaciones, regInd, posEnconlar)
        else
          cortar:= true;
    end; // While CORTAR
  MEConversaciones.cerrar(Conversaciones);

end;

end.
