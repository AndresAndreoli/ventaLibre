unit TDAColaV;

interface

uses
  TiposYconstantes, TDAColasParcialesV;

	const
		_PosNula = TiposYconstantes._PosNula;


	type
		TipoPosicion = TiposYConstantes.tipoPosicion;

    tipoRegDatos = TDAColasParcialesV.registroDatos;
    tipoRegControl = TDAColasParcialesV.registroControl;
    tipoRegIndice = TDAColasParcialesV.registroIndice;

    TipoCola = TDAColasParcialesV.TipoCola;

	Procedure CrearCola     (var cola:TipoCola; ruta, nombre:String);
	Procedure AbrirCola     (var cola:TipoCola);
	Procedure CerrarCola    (var cola:TipoCola);
	Procedure DestruirCola  (var cola:tipoCola; ruta, nombre:String);
	Function  ColaVacia     (var cola:TipoCola):Boolean;
	function  Frente        (var Cola:TipoCola; var regInd: registroIndice): tipoPosicion;
	Procedure Decolar       (var cola:TipoCola);
	Procedure Encolar       (var cola:TipoCola; var reg:tipoRegIndice; var pos: tipoPosicion);
	Function  PosNula       (var cola:TipoCola):TipoPosicion;
  function  Buscar        (var Me:TipoCola; Cliente: TipoPosicion; var posEnc: TipoPosicion):boolean;

implementation
	uses SysUtils, Dialogs;
//------------------------------------------------------------------------------CrearCola
	Procedure CrearCola(var cola:TipoCola; ruta,nombre:String);
  begin
    TDAColasParcialesV.CrearCola(cola, ruta, nombre);
  end;
//------------------------------------------------------------------------------AbrirCola
	Procedure AbrirCola(var Cola:TipoCola);
		begin
			reset(cola.d);
      reset(cola.c);
      reset(cola.i);
		end;
//------------------------------------------------------------------------------CerrarCola
	Procedure CerrarCola(var Cola:TipoCola);
		begin
			close(cola.d);
      close(cola.c);
      close(cola.i);
		end;
//------------------------------------------------------------------------------DestruirCola
	Procedure DestruirCola(var Cola:tipoCola; ruta, nombre:String);
		begin
			Assignfile(Cola.c, ruta + nombre + '.con');
			Assignfile(Cola.d, ruta + nombre + '.dat');
      Assignfile(Cola.i, ruta + nombre + '.ntx');
			deletefile(ruta+nombre + '.con');
			deletefile(ruta+nombre + '.dat');
      deletefile(ruta+nombre + '.ntx');
		end;
//------------------------------------------------------------------------------ColaVacia
	Function ColaVacia(var Cola:TipoCola):Boolean;
		var
			RC:TipoRegControl;
		begin
			Seek(Cola.c, 0);
			Read(Cola.c, RC);
			ColaVacia:= (RC.primero = _PosNula);
      //showmessage('VACIO primero '+inttostr(RC.primero)+' ultimo '+inttostr(rc.ultimo));
		end;
//------------------------------------------------------------------------------Frente
	function Frente(var Cola:TipoCola; var regInd: registroIndice): tipoPosicion;
		var
			RC:registroControl;
		begin
			Seek(Cola.c, 0);
			Read(Cola.c, rc);
      frente:= rc.primero;
      seek(cola.i, rc.primero);
      read(cola.i, regInd);
		end;
//------------------------------------------------------------------------------Decolar
 	Procedure Decolar(var Cola:TipoCola);
		var
			RC:TipoRegControl; pos:TipoPosicion; RegInd:TipoRegIndice;
		begin
			Seek(Cola.c, 0);
			Read(Cola.c, RC);
			pos := RC.primero;
			Seek(Cola.i, pos);
			Read(Cola.i, RegInd);
			RC.primero:= RegInd.siguiente;

			if (RegInd.siguiente = _PosNula) then
        RC.ultimo := _PosNula;

			RegInd.siguiente := RC.borradoIndice;
			RC.borradoIndice := pos;
			Seek(Cola.c, 0);
			Write(Cola.c, RC);

			Seek(Cola.i, pos);
			Write(Cola.i, RegInd);
		end;
//------------------------------------------------------------------------------Encolar
	Procedure Encolar       (var cola:TipoCola; var reg:tipoRegIndice; var pos: tipoPosicion);
		var
			RC: registroControl; posNueva:TipoPosicion; RAux: tipoRegIndice;
		begin
			Seek(Cola.C, 0);
			Read(Cola.c, RC);

			if (RC.borradoIndice <> _PosNula) then
      begin
				posNueva := RC.borradoIndice;
				Seek(Cola.i, posNueva);
				Read(Cola.i, RAux);
				RC.borradoIndice := RAux.siguiente;
			end
      else
				posNueva:= filesize(Cola.i);
			
			if (RC.primero = _PosNula) then
      begin
				Reg.siguiente := _PosNula;
				RC.primero := posNueva;
				RC.ultimo := posNueva;
			end
      else
      begin
				Seek(Cola.i, RC.ultimo);
				Read(Cola.i, RAux);
				RAux.siguiente := posNueva;
				Seek(Cola.i, RC.ultimo);
				Write(Cola.i, RAux);
				RC.ultimo := posNueva;
				Reg.siguiente := _PosNula;
			end;//IF

      pos:=posNueva;
			Seek(Cola.c, 0);
			Write(Cola.c, RC);
			Seek(Cola.i, posNueva);
			Write(Cola.i, Reg);
		end;
//------------------------------------------------------------------------------PosNula
	Function PosNula(var Cola:TipoCola):TipoPosicion;
		begin
			PosNula := _PosNula;
		end;
//------------------------------------------------------------------------------ Buscar
  Function Buscar(var Me:TipoCola; Cliente: TipoPosicion; var posEnc: TipoPosicion):boolean;
  var
   reg, regNulo:registroIndice;
   corte,encontro, terminar:boolean;
    pos, posSalida: integer;
    regInc:registroIndice;
  begin
    {No pude implementar un buscar utilizando una colaAux (asi no recorro todos los indices), ya que se me presentaba un error en lo cual no lo podia solucionar}
   posEnc:= -1;
   posSalida:=-1;
   corte:=false;
   encontro:=false;
   terminar:= false;
   regNulo.Clave:= -1;
   regNulo.Siguiente:= -1;

   Encolar(me,regNulo, pos);
   while not corte do
    begin
      frente(me,reg);
      Decolar(me);
      if reg.Clave <> -1 then 
      if (reg.clave=cliente) then
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
    posEnc:= posSalida;
    result:= terminar;
  end;
end.
