unit TDAColasParcialesV;

interface

uses
  TiposYconstantes, Dialogs, SysUtils;

	const
		_PosNula = TiposYconstantes._PosNula;

	type
		TipoPosicion = Longint;

		registroDatos = record
                      ClaveComprador:     TiposYconstantes.tipoClave;
                      IDVendedor:         TiposYconstantes.tipoPosicion;
                      Clave:              TiposYconstantes.tipoPosicion;        // IDPublicado
                      nombreArticulo:     TiposYconstantes.tipoNombre;
                      precioVenta:        TiposYconstantes.tipoPrecio;
                      fechaPublicacion:   TiposYconstantes.tipoFecha;
                      fechaVenta:         TiposYconstantes.tipoFecha;
                      tipoArticulo:       TiposYconstantes.tipoEstado;          // 1=usado; 2=nuevo
                      calificacion:       TiposYconstantes.tipoEstado;          // 0=Sin calificar aún; 1=Recomendable; 2=Neutral; 3=No recomendable
                      porcentajeComision: TiposYconstantes.tipoComision;
                      comisionCobrada:    TiposYconstantes.tipoComisionCobrada; // indica si ventaLibre recibio la Comision
                      siguiente:          TiposYconstantes.tipoPosicion;
                     end;

		registroControl = record
                        primero, ultimo :           TiposYconstantes.TipoPosicion;
                        borradoCola, borradoIndice: TiposYconstantes.TipoPosicion;
                       end;

    registroIndice = record
                        clave:            TiposYconstantes.tipoPosicion;        // IDComprador
                        primero, ultimo:  TiposYconstantes.tipoPosicion;
                        siguiente:        TiposYconstantes.tipoPosicion;
                      end;

    TipoRegDatos = file of registroDatos;
		TipoRegControl = file of registroControl;
    TipoRegIndice = file of registroIndice;

		TipoCola = record
                  D: TipoRegDatos;
                  C: TipoRegControl;
                  I: TipoRegIndice;
                end;

	Procedure CrearCola     (var Cola:TipoCola; ruta, nombre:String);
	Procedure AbrirCola     (var Cola:TipoCola);
	Function  ColaVacia     (var Cola:TipoCola; pos: tipoPosicion):Boolean;
	function  Frente        (var Cola:TipoCola; var Reg:registroDatos;  regInd: registroIndice): tipoPosicion;
	Procedure Decolar       (var Cola:TipoCola; var regInd: registroIndice; posIndice: tipoPosicion);
	Procedure Encolar       (var Cola:TipoCola;  Reg: registroDatos; var regInd: registroIndice; posIndice: tipoposicion);
	Function  PosNula       (var Cola:TipoCola):TipoPosicion;

implementation
//------------------------------------------------------------------------------CrearCola
	Procedure CrearCola(var Cola:TipoCola; ruta, nombre:String);
		var
			faltaControl, faltaDatos, faltaIndice:Boolean; rc:registroControl;
		begin

			Assign(Cola.C,ruta+nombre+'.con');
			Assign(Cola.D,ruta+nombre+'.dat');
      Assign(Cola.I,ruta+nombre+'.ntx');

      {$i-}
      Reset(cola.c);
      faltaControl:= (Ioresult<>0);
      Reset(cola.d);
      faltaDatos:= (Ioresult<>0);
      Reset(cola.i);
      faltaIndice:= (Ioresult<>0);

			if ((faltaControl) or (faltaDatos) or (faltaIndice)) then
      begin
				Rewrite(cola.c);
        rc.primero:= _posNula;
        rc.ultimo:= _posNula;
        rc.borradoCola:= _posNula;
        rc.borradoIndice:= _posNula;
        Write(cola.c, rc);
        Rewrite(cola.d);
        Rewrite(cola.i);
        Close(cola.d);
        Close(cola.c);
        Close(cola.I);
			end;//If
      {$i+}

		end;//CrearCola
//------------------------------------------------------------------------------AbrirCola
	Procedure AbrirCola(var Cola:TipoCola);
		begin
			reset(cola.d);
      reset(cola.c);
      reset(cola.i);
		end;
//------------------------------------------------------------------------------ColaVacia
	Function ColaVacia(var Cola:TipoCola; pos: tipoPosicion):Boolean;
    var
      RI: registroIndice;
		begin
			Seek(Cola.i, pos);
			Read(Cola.i, RI);
			ColaVacia:= (Ri.primero = _PosNula);
		end;
//------------------------------------------------------------------------------Frente
	function Frente(var Cola:TipoCola; var Reg:registroDatos;  regInd: registroIndice): tipoPosicion;
		begin
      seek(cola.d, regInd.primero);
			Read(Cola.d, Reg);
      frente:= regInd.primero;
		end;
//------------------------------------------------------------------------------Decolar
	Procedure Decolar(var Cola:TipoCola;var regInd: registroIndice; posIndice: tipoPosicion);
		var
      pos:TipoPosicion; Reg:registroDatos; rc: registroControl;
		begin
      seek(cola.c, 0);
      read(cola.c, rc);

			pos := regInd.primero;
			Seek(Cola.d, pos);
			Read(Cola.d, Reg);
			regInd.primero:= Reg.siguiente;

			if (Reg.siguiente = _PosNula) then
        regInd.ultimo := _PosNula;

			Reg.siguiente := RC.borradoCola;
			RC.borradoCola := pos;

			Seek(Cola.c, 0);
			Write(Cola.c, RC);
      seek(cola.I, posIndice);
      Write(cola.i, regInd);
			Seek(Cola.d, pos);
			Write(Cola.d, Reg);

		end;
//------------------------------------------------------------------------------Encolar
	Procedure Encolar(var Cola:TipoCola; Reg: registroDatos; var regInd: registroIndice; posIndice: tipoposicion);
		var
      posNueva:TipoPosicion;
      RAux:registroDatos;
      rc: registroControl;
		begin
			Seek(Cola.c, 0);
			Read(Cola.c, RC);

			if (RC.borradoCola <> _PosNula) then
      begin
				posNueva := RC.borradoCola;
				Seek(Cola.d, posNueva);
				Read(Cola.d, RAux);
				RC.borradoCola := RAux.siguiente;
			end
      else
				posNueva:= filesize(Cola.d);

			if (regInd.primero = _PosNula) then
      begin
				Reg.siguiente := _PosNula;
				regInd.primero := posNueva;
				regInd.ultimo := posNueva;
			end
      else
      begin
				Seek(Cola.d, regInd.ultimo);
				Read(Cola.d, RAux);
				RAux.siguiente := posNueva;
				Seek(Cola.d, regInd.ultimo);
				Write(Cola.d, RAux);
				regInd.ultimo := posNueva;
				Reg.siguiente := _PosNula;
			end;//IF

      Seek(cola.i, posIndice);
      Write(cola.i, regInd);
			Seek(Cola.c,0);
			Write(Cola.c, rc);
			Seek(Cola.d, posNueva);
			Write(Cola.d, Reg);
		end;
//------------------------------------------------------------------------------PosNula
	Function PosNula(var Cola:TipoCola):TipoPosicion;
		begin
			PosNula := _PosNula;
		end;
end.
