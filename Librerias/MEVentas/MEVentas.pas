unit MEVentas;

interface

uses
  SysUtils, TiposYconstantes, TDAColasParcialesV, TDAColaV, Dialogs;

type
    tipoPosicion = TiposYconstantes.tipoPosicion;

    tipoRegDatos = TDAColasParcialesV.registroDatos;
    tipoRegControl = TDAColasParcialesV.registroControl;
    tipoRegIndice = TDAColasParcialesV.registroIndice;

    tipoVentas = TDAColasParcialesV.TipoCola;

procedure crear(var Me:tipoVentas; ruta, nombre: string);
procedure abrir(var Me:tipoVentas);
procedure cerrar(var Me:tipoVentas);
procedure insertar(var Me:tipoVentas; var regInd: registroIndice; regDat: registroDatos);
procedure insertarVenta(var Me:tipoVentas; regDat: registroDatos; var regInd: registroIndice; pos: tipoPosicion);
function  buscar(var Me:tipoVentas; Cliente: TipoPosicion; var posEnc: TipoPosicion): boolean;
function  posNula(var Me: tipoVentas): integer;
function  primeraPos(var Me: tipoVentas): integer;
function obtenerIndice(var Me:tipoVentas; pos: integer): registroIndice;

implementation
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ obtenerIndice
 function obtenerIndice(var Me:tipoVentas; pos: integer): registroIndice;
 var
  regInd: registroIndice;
 begin
   seek(me.I, pos);
   read(me.I, regInd);
   obtenerIndice:= regInd;
 end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ crear
procedure crear(var Me:tipoVentas; ruta, nombre: string);
begin
  TDAColaV.crearCola(me, ruta, nombre);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ abrir
procedure abrir(var Me:tipoVentas);
begin
  TDAColaV.abrircola(me);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ cerrar
procedure cerrar(var Me:tipoVentas);
begin
  TDAColaV.CerrarCola(me);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ insertar
procedure insertar(var Me:tipoVentas; var regInd: registroIndice; regDat: registroDatos);
var
  pos: integer;
  rc: registroControl;
begin
  TDAColaV.Encolar(me, regInd, pos);
  regInd.primero:= _PosNula;
  TDAColasParcialesV.Encolar( me, regDat, regInd, pos);
  seek(me.c,0);
  read(me.c,rc);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ buscar
function buscar(var Me:tipoVentas; Cliente: TipoPosicion; var posEnc: TipoPosicion): boolean;
begin
  result:= tdacolaV.Buscar(me, cliente, posEnc);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ insertarMensaje
procedure insertarVenta(var Me:tipoVentas; regDat: registroDatos; var regInd: registroIndice; pos: tipoPosicion);
begin
  seek(me.I, pos);
  read(me.i, regInd);

  TDAColasParcialesV.Encolar(me, regDat, regInd, pos);
end;


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ posNula
function posNula(var Me:tipoVentas): integer;
begin
  posNula:= TiposYconstantes._PosNula;
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ primeraPos
function primeraPos(var Me: tipoVentas): integer;
var
  reg: registroControl;
begin
  seek(me.c, 0);
  read(me.c, reg);
  primeraPos:= reg.primero;
end;
end.
