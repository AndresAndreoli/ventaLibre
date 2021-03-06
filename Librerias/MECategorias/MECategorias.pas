unit MECategorias;

interface
 uses TiposYconstantes, TDAListaDobleCat, Dialogs;

type
  TipoRegDatos   = TDAListaDobleCat.TipoRegDatos;

  TipoRegControl = TDAListaDobleCat.TipoRegControl;

  TipoMe         = TDAListaDobleCat.TipoListaDoble;

Procedure CrearLd (Var Me:TipoMe;Ruta, Nombre:String);
procedure AbrirMe(var Me:TipoMe);
procedure CerrarMe(var Me:TipoMe);
procedure DestruirMe(var Me:TipoMe);
function  Primero(var Me:TipoMe):TipoPosicion;
function  Ultimo(var Me:TipoMe):TipoPosicion;
function  Proximo(var Me:TipoMe; Pos: TipoPosicion):TipoPosicion;
function  Anterior(var Me:TipoMe; Pos: TipoPosicion):TipoPosicion;
Function  Buscar(var Me:TipoMe;Clave:TipoPosicion; var pos:TipoPosicion):Boolean;
procedure Insertar  (var Me:TipoMe; Pos: TipoPosicion; Reg: TipoRegDatos);
procedure Eliminar  (var Me:TipoME; Pos: TipoPosicion);
procedure Modificar (var Me:TipoMe; Pos:TipoPosicion; Reg:TipoRegDatos);
procedure Capturar  (var Me:TipoMe; Pos:TipoPosicion; var Reg:TipoRegDatos);
function  PosNula  (var Me:TipoMe): TipoPosicion;
function  UltimoID(var ME:TipoMe): TipoPosicion;
function  categoriaVacia(var ME:TipoMe): boolean;

implementation
////////////////////////////////////////////////////////////////////////////////  CrearLd
Procedure CrearLd (Var Me:TipoMe;Ruta, Nombre:String);
Begin
  TDAListaDobleCat.CrearLd(me,ruta,nombre);
End;

////////////////////////////////////////////////////////////////////////////////  AbrirMe

procedure AbrirMe(var Me:TipoMe);
 begin
   TDAListaDobleCat.AbrirLd(Me);
 end;
//////////////////////////////////////////////////////////////////////////////// CerrarMe

procedure CerrarMe(var Me:TipoMe);
 begin
   TDAListaDobleCat.CerrarLd(Me);
 end;
//////////////////////////////////////////////////////////////////////////////// DestruirMe

procedure DestruirMe(var Me:TipoMe);
 begin
   TDAListaDobleCat.DestruirLista(Me);
 end;
//////////////////////////////////////////////////////////////////////////////// Primero

function Primero(var Me:TipoMe):TipoPosicion;
 begin
  result:= TDAListaDobleCat.Primero(Me);
 end;
//////////////////////////////////////////////////////////////////////////////// Ultimo

function Ultimo(var Me:TipoMe):TipoPosicion;
 begin
  result:= TDAListaDobleCat.Ultimo(Me);
 end;
//////////////////////////////////////////////////////////////////////////////// Proximo

function Proximo(var Me:TipoMe; Pos: TipoPosicion):TipoPosicion;
 begin
  result:= TDAListaDobleCat.Proximo(Me,pos);
 end;
//////////////////////////////////////////////////////////////////////////////// Anterior

function Anterior(var Me:TipoMe; Pos: TipoPosicion):TipoPosicion;
 begin
  result:= TDAListaDobleCat.Anterior(Me,pos);
 end;

//////////////////////////////////////////////////////////////////////////////// Buscar

Function Buscar(var Me:TipoMe;Clave:TipoPosicion; var pos:TipoPosicion):Boolean;
  begin
    Buscar:= TDAListaDobleCat.Buscar(Me,Clave,pos);
  end;
//////////////////////////////////////////////////////////////////////////////// Insertar

procedure Insertar  (var Me:TipoMe; Pos: TipoPosicion; Reg: TipoRegDatos);
  var
    rc: TipoRegControl;
  begin
    //++++++++++++++++++++++++++++++++++++++++ Incrementar la CLAVE
    seek(me.Control, 0);
    read(me.Control, rc);
    reg.Clave:= rc.autoincremental;
    rc.autoincremental:= rc.autoincremental+1;
    seek(me.Control, 0);
    write(me.Control, rc);
    //++++++++++++++++++++++++++++++++++++++++

    TDAListaDobleCat.Insertar(Me, reg, pos);
  end;
//////////////////////////////////////////////////////////////////////////////// Eliminar

procedure Eliminar  (var Me:TipoME; Pos: TipoPosicion);
   begin
    TDAListaDobleCat.Eliminar(Me,Pos);
   end;
//////////////////////////////////////////////////////////////////////////////// Modificar

procedure Modificar (var Me:TipoMe; Pos:TipoPosicion; Reg:TipoRegDatos);
   begin
    TDAListaDobleCat.Modificar(Me, pos, reg);
   end;
//////////////////////////////////////////////////////////////////////////////// Capturar

procedure Capturar  (var Me:TipoMe; Pos:TipoPosicion; var Reg:TipoRegDatos);
    begin
     TDAListaDobleCat.Capturar(ME,Pos,Reg);
    end;

//////////////////////////////////////////////////////////////////////////////// PosNula
function  PosNula  (var Me:TipoMe): TipoPosicion;

   begin
      PosNula:= _PosNula;
   end;

//////////////////////////////////////////////////////////////////////////////// UltimoID
function  UltimoID(var ME:TipoMe): TipoPosicion;
  var
    rc: TipoRegControl;
  begin
  seek(me.Control, 0);
  read(me.Control, rc);
    UltimoID:= rc.autoincremental;
  end;
//////////////////////////////////////////////////////////////////////////////// categoriaVacia
function categoriaVacia(var ME:TipoMe): boolean;
  begin
    categoriaVacia:= TDAListaDobleCat.ListaVacia(me);
  end;
end.

