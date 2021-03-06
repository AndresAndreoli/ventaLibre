unit MEConversaciones;

interface

uses
  SysUtils, TiposYconstantes, TDAColasParciales, TDACola, Dialogs;

type
    tipoPosicion = TiposYconstantes.tipoPosicion;

    tipoRegDatos = TDAColasParciales.registroDatos;
    tipoRegControl = TDAColasParciales.registroControl;
    tipoRegIndice = TDAColasParciales.registroIndice;

    tipoConversacion = TDAColasParciales.TipoCola;

procedure crear(var Me:tipoConversacion; ruta, nombre: string);
procedure abrir(var Me:tipoConversacion);
procedure cerrar(var Me:tipoConversacion);
procedure insertar(var Me:tipoConversacion; var regInd: registroIndice; regDat: registroDatos);
procedure insertarMensaje(var Me:tipoConversacion; regDat: registroDatos; var regInd: registroIndice; pos: tipoPosicion);
function buscar(var Me:tipoConversacion; Clave:TipoPosicion; Cliente: TipoPosicion; var posEnc: TipoPosicion): boolean;
function buscarConversacion(var Me:tipoConversacion; idPublicacion: tipoPosicion; var pos:tipoPosicion): boolean;
function posNula(var Me: tipoConversacion): integer;
function obtenerIndice(var Me:tipoConversacion; pos: integer): registroIndice;


implementation
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ obtenerIndice
 function obtenerIndice(var Me:tipoConversacion; pos: integer): registroIndice;
 var
  regInd: registroIndice;
 begin
   seek(me.I, pos);
   read(me.I, regInd);
   obtenerIndice:= regInd;
 end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ crear
procedure crear(var Me:tipoConversacion; ruta, nombre: string);
begin
  TDACola.crearCola(me, ruta, nombre);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ abrir
procedure abrir(var Me:tipoConversacion);
begin
  TDACola.abrircola(me);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ cerrar
procedure cerrar(var ME:tipoConversacion);
begin
  TDACola.CerrarCola(me);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ insertar
procedure insertar(var Me:tipoConversacion; var regInd: registroIndice; regDat: registroDatos);
var
  pos: integer;
  rc: registroControl;
begin
  regInd.ultimoNumero:=0;
  TDACola.Encolar(me, regInd, pos);
  regDat.mensajeVendedor:='';
  regDat.clave:= 0;
  regDat.fecha:= now();
  regInd.primero:= _PosNula;
  TDAColasParciales.Encolar( me, regDat, regInd, pos);
  seek(me.c,0);
  read(me.c,rc);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ buscar
function buscar(var Me:tipoConversacion; Clave:TipoPosicion; Cliente: TipoPosicion; var posEnc: TipoPosicion): boolean;
begin
  result:= tdacola.Buscar(me, clave, cliente, posEnc);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ buscarConversacion
function buscarConversacion(var Me:tipoConversacion; idPublicacion: tipoPosicion; var pos:tipoPosicion): boolean;
var
   reg, regNulo:registroIndice;
   corte,encontro, terminar:boolean;
    posSalida,posEnc: integer;
    regInc:registroIndice;
  begin
   posEnc:= -1;
   posSalida:=-1;
   corte:=false;
   encontro:=false;
   terminar:= false;
   regNulo.Clave:= -1;
   regNulo.Siguiente:= -1;

   Encolar(me,regNulo, pos);
   //showmessage('pos encontra '+inttostr(pos));
   while not corte do
    begin
      frente(me,reg);
      Decolar(me);
      if (idPublicacion = reg.clave)  then
       encontro:=true else encontro:= false;

      if reg.Clave <> -1 then
        begin
          Encolar(me,reg,posEnc);
          if (encontro) then
          begin
            posSalida:= posEnc;
            terminar:= true;
          end;
        end
        else
          corte:=true;
    end;
    pos:= posSalida;
    //showmessage('pos salida '+inttostr(pos));
    result:= terminar;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ insertarMensaje
procedure insertarMensaje(var Me:tipoConversacion; regDat: registroDatos; var regInd: registroIndice; pos: tipoPosicion);
begin
  seek(me.I, pos);
  read(me.i, regInd);

  regInd.ultimoNumero:= regInd.ultimoNumero + 1;

  regDat.clave:=regInd.ultimoNumero;
  regDat.fecha:= now();
  regDat.mensajeVendedor:= '';
  TDAColasParciales.Encolar(me, regDat, regInd, pos);
end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ posNula
function posNula(var Me: tipoConversacion): integer;
begin
  posNula:= TiposYconstantes._PosNula;
end;

end.
