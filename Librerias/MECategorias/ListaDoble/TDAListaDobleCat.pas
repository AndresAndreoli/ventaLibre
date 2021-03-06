unit TDAListaDobleCat;

interface

Uses
  TiposYconstantes, dialogs;

Const

	_PosNula= TiposYconstantes._PosNula;
	_ClaveNula= TiposYconstantes._ClaveNula;

Type
	TipoRegDatos = Record
                      Clave     : TiposYconstantes.TipoPosicion;
                      categoria : TiposYconstantes.TipoCategoria; {nombre de la categoria}
                      comision  : TiposYconstantes.TipoComision;  {es el porcentaje de la comisi?n que cobra
                                                                  VentaLibre al vendedor, una vez efectuada la venta de un art?culo}
                      Ant,Sig   : TiposYconstantes.TipoPosicion;
			          end;

	TipoRegControl= Record
				                Primero         : TiposYconstantes.TipoPosicion;
                        Ultimo          : TiposYconstantes.TipoPosicion;
                        Borrado         : TiposYconstantes.TipoPosicion;
                        autoincremental : TiposYconstantes.TipoPosicion;
                  end;

  TipoArchivoDatos = File Of TipoRegDatos;
	TipoArchivoControl = File of TipoRegControl;

	TipoListaDoble = Record
                      Control:TipoArchivoControl;
				              Datos:TipoArchivoDatos;
			            End;

Procedure CrearLd       (Var Me:TipoListaDoble; Ruta,Nombre:String);
procedure AbrirLd       (var Me: TipoListaDoble);
procedure CerrarLd      (var Me: TipoListaDoble);
procedure DestruirLista (var Me: TipoListaDoble);
function ListaVacia     (var me: TipoListaDoble): Boolean;

Procedure Insertar     (var Me:TipoListaDoble; Reg :TipoRegDatos;Pos:TipoPosicion);
procedure Eliminar     (var Me:TipoListaDoble; Pos:TipoPosicion);
procedure Capturar     (var Me:TipoListaDoble; Pos:TipoPosicion; var Reg:TipoRegDatos);
procedure Modificar    (var Me:TipoListaDoble; Pos:TipoPosicion; Reg:TipoRegDatos);
function Primero       (var Me:TipoListaDoble): TipoPosicion;
function Ultimo        (var Me:TipoListaDoble): TipoPosicion;
function PosNula       (var Me:TipoListaDoble): TipoPosicion;
function ClaveNula     (var Me:TipoListaDoble): TipoClave;
Function Anterior      (var Me:TipoListaDoble;Pos:TipoPosicion):TipoPosicion;
function Proximo       (var Me:TipoListaDoble;Pos:TipoPosicion):TipoPosicion;
Function Buscar        (var Me:TipoListaDoble;Clave:TipoPosicion;Var pos:TipoPosicion):Boolean;

Implementation

uses Math,SysUtils,Forms;

Var

Me:TipoListaDoble;

Procedure CrearLd (Var Me:TipoListaDoble; Ruta,Nombre:String);
Var
	FaltaControl:Boolean;
	FaltaDatos:Boolean;
  rc:TipoRegControl;
Begin
	Assign(Me.Control,Ruta+Nombre+'.con');
	Assign(Me.Datos,Ruta+Nombre+'.dat');
	{$i-} //-> Directiva de compilaci?n (Coloca el error en una variable de entorno que se llama ioresult
	Reset(Me.Control);
	FaltaControl:=(Ioresult<>0);
	Reset(Me.Datos);
	FaltaDatos:=(ioResult<>0);
	If ((faltaControl) or (FaltaDatos)) then
    begin
      Rewrite(Me.Control);
		  Rc.Primero:=_PosNula;
		  Rc.Ultimo :=_PosNula;
      Rc.Borrado:=_Posnula;
      rc.autoincremental:= 1;
      Write(Me.Control,Rc);
		  Rewrite(Me.Datos);

		  Close(Me.Datos);
		  Close(Me.Control);
    end;
	{$i+}
End;
////////////////////////////////////////////////////////////////////////////////

procedure AbrirLD (var Me: TipoListaDoble);
   begin
    reset (Me.Datos);
    reset (Me.Control);
   end;
////////////////////////////////////////////////////////////////////////////////

  procedure CerrarLD (var Me: TipoListaDoble);
   begin
    Close (Me.Datos);
    Close (Me.Control);
   end;

////////////////////////////////////////////////////////////////////////////////
   procedure DestruirLista (var Me: TipoListaDoble);
   begin
    Erase (Me.Datos);
    Erase (Me.Control);
   end;

////////////////////////////////////////////////////////////////////////////

function ListaVacia(var me: TipoListaDoble): Boolean;
var
  Rc: TipoRegControl;
  begin
    Seek(Me.Control, 0);
    Read(Me.Control, Rc);

    result:= (Rc.Primero = _posnula);
  end;

////////////////////////////////////////////////////////////////////////////
  Procedure Insertar (var Me:TipoListaDoble; Reg :TipoRegDatos;Pos:TipoPosicion); //Se inserta a lo ultimo
   var
    Rc: TipoRegControl;
    Raux,RauxAnt,RegBorr:TipoRegDatos;
    PosNueva,posant:TipoPosicion;
   begin

    seek (Me.Control, 0);
    read (Me.Control, Rc);

    if rc.Borrado = _Posnula then
     //No hay borrados, la nueva posicion es el limite del archivo de datos.
     PosNueva:=FileSize(Me.Datos)
      else
       begin
         //Recupero una celula borrada
         seek(Me.Datos,Rc.Borrado);
         Read(Me.Datos,RegBorr);

         //La nueva posicion era el primer elemento borrado de la pila
         PosNueva:= Rc.Borrado;

         //El nuevo primer elemento de la pila de borrados sera el enlace del que
         //  antes fue primer borrado, puede que esta sea _PosNula entonces no hay mas
         //    borrados.
         Rc.Borrado := RegBorr.Sig;

       end;

    If (rc.Primero=_posnula) Then   //Esta vacio
      Begin
        Rc.Primero:=PosNueva;
        Rc.Ultimo:=PosNueva;
        Reg.Sig:=_PosNula;
        Reg.Ant:=_PosNula;
      end
    else
      If Rc.Primero=pos then   //Inserto al principio
        Begin
          Reg.Sig:=Rc.Primero;
          Reg.Ant:=_PosNula;

          Seek(Me.Datos,Rc.Primero);
          Read(Me.Datos,Raux);

          Raux.Ant:=PosNueva;

          Seek(Me.Datos,Rc.Primero);
          Write(Me.Datos,Raux);

          Rc.Primero:=PosNueva;
        end
      else
        If(Pos=_posnula) then   //Inserto al final
          Begin
            Seek(Me.Datos,Rc.Ultimo);
            Read(Me.Datos,Raux);

            Raux.Sig:=PosNueva;
            Reg.Sig:=_PosNula;
            Reg.Ant:=Rc.Ultimo;

            Rc.Ultimo:=PosNueva;
            Seek(Me.Datos,Reg.Ant);

            Write(Me.Datos,RAux);
          End
        Else                     //Inserto al medio
          Begin

            // REG = Registro para insertar.
            // Raux = Registro en la posicion Pos.
            // Posnueva = posicion del nuevo registro (Reg).
            // Pos = Posicion donde se encuentra Reg

            //Leo el registro que se encuentra en Pos
            Seek(Me.Datos,Pos);
            Read(Me.Datos,Raux);

             //El nuevo registro tendra como siguiente al actual en "Pos"
            Reg.Sig:=pos;

            //Capturo la posicion del anterior al registro de Raux
            PosAnt:=Raux.ant;

            //El nuevo registro (Reg) tendra como anterior al anterior del registro que "desplaza"
            Reg.Ant:=PosAnt;

            //Leo el anterior a la posicion parametrizada "Pos" y capturo ese registro
            Seek(Me.Datos,PosAnt);
            Read(Me.Datos,RauxAnt);


            //Actualizo los enlances para que apunten al nuevo registro
            Rauxant.Sig:=PosNueva;
            Raux.Ant:=PosNueva;

            //Actualizo el anterior con el nuevo enlace siguiente a Posnueva
            Seek(Me.Datos,PosAnt);
            Write(Me.Datos,RauxAnt);
            //Actualizo Raux con el nuevo enlaces anterior a PosNueva
            Seek(Me.Datos,Pos);
            Write(Me.Datos,Raux);
          end;

    Seek(Me.Datos,Posnueva);
    Write(Me.Datos,Reg);

    //Grabo el archivo de control
    Seek(Me.Control,0);
    Write(Me.Control,Rc);
   end;





////////////////////////////////////////////////////////////////////////////
procedure Eliminar     (var Me:TipoListaDoble; Pos:TipoPosicion);
var
    Rc: TipoRegControl;
    Raux,RauxSig,RauxAnt:TipoRegDatos;

begin
  seek (Me.Control, 0);
  read (Me.Control, Rc);
  Seek(Me.Datos,Pos);
  Read(Me.Datos,Raux);

  If (Rc.Primero=pos) and (Rc.Ultimo=Pos) Then   //Hay un solo elemento
      Begin
        Rc.Primero:=_PosNula;
        Rc.Ultimo:=_PosNula;
      end
    else
      If Rc.Primero=pos then   //Elimino al principio1
        Begin
          Seek(Me.Datos,Raux.sig);
          Read(Me.Datos,RauxSig);

          RauxSig.Ant:=_PosNula;

          Seek(Me.Datos,Raux.sig);
          Write(Me.Datos,RauxSig);
          Rc.Primero:=Raux.Sig;
        end
      else
        If(Pos=Rc.Ultimo) then   //Elimino al final
          Begin
            Seek(Me.Datos,Raux.Ant);
            Read(Me.Datos,RauxAnt);
            RauxAnt.Sig:=_PosNula;

            Rc.Ultimo:=Raux.Ant;
            Seek(Me.Datos,Raux.Ant);
            Write(Me.Datos,RAuxAnt);
          End
        Else                     //Elimino al medio
          Begin
            //Capturo el reg siguiente
            Seek(Me.Datos,Raux.Sig);
            Read(Me.Datos,RauxSig);
            //Capturo el reg anterior
            Seek(Me.Datos,Raux.Ant);
            Read(Me.Datos,RauxAnt);

            //Actualizo los enlaces
            RauxAnt.Sig:=Raux.Sig;
            RauxSig.Ant:=Raux.Ant;

            //Grabo el reg anterior y el siguiente al que va a ser eliminado
            Seek(Me.Datos,Raux.Sig);
            Write(Me.Datos,RauxSig);
            Seek(Me.Datos,Raux.Ant);
            Write(Me.Datos,RauxAnt);
          end;
   // Raux.Ant:=-1;

    //Pila de borrados
    Raux.Ant:= _Posnula;
    Raux.Sig:= rc.Borrado;
    Rc.Borrado:= Pos;

    //Grabo la celula borrada
    Seek(Me.Datos,pos);
    Write(Me.Datos,Raux);

    //Grabo el archivo de control
    Seek(Me.Control,0);
    Write(Me.Control,Rc);
   end;

////////////////////////////////////////////////////////////////////////////
procedure Capturar     (var Me:TipoListaDoble; Pos:TipoPosicion; var Reg:TipoRegDatos);
begin
  Seek(Me.Datos,Pos);
  Read(Me.Datos,reg);
end;

////////////////////////////////////////////////////////////////////////////
procedure Modificar    (var Me:TipoListaDoble; Pos:TipoPosicion; Reg:TipoRegDatos);
var
  Rd:TipoRegDatos;
begin
  Seek(Me.Datos,Pos);
  Read(Me.Datos,Rd);
  Reg.Ant:=Rd.Ant;
  Reg.Sig:=Rd.Sig;
  Seek(Me.Datos,Pos);
  Write(Me.Datos,Reg);
end;

////////////////////////////////////////////////////////////////////////////



function Primero       (var Me:TipoListaDoble): TipoPosicion;
var
  Rc:TipoRegControl;
begin
   seek(Me.Control,0);
   read(Me.Control,Rc);
   Primero:=Rc.Primero;
end;

////////////////////////////////////////////////////////////////////////////
function Ultimo        (var Me:TipoListaDoble): TipoPosicion;
var
  Rc:TipoRegControl;
begin
   seek(Me.Control,0);
   read(Me.Control,Rc);
   Ultimo:=Rc.Ultimo;
end;

////////////////////////////////////////////////////////////////////////////
function PosNula       (var Me:TipoListaDoble): TipoPosicion;
begin
  posNula:=_posnula;
end;

////////////////////////////////////////////////////////////////////////////
function ClaveNula     (var Me:TipoListaDoble): TipoClave;
begin
  ClaveNula:=_ClaveNula;
end;

////////////////////////////////////////////////////////////////////////////

function Proximo      (var Me:TipoListaDoble;Pos:TipoPosicion):TipoPosicion;
var reg: tiporegdatos;
begin
  Seek(Me.Datos,Pos);
  Read(Me.Datos,Reg);
  Proximo:=Reg.Sig;
end;
////////////////////////////////////////////////////////////////////////////
Function Anterior      (var Me:TipoListaDoble;Pos:TipoPosicion):TipoPosicion;
var reg: tiporegdatos;
begin
  Seek(Me.Datos,Pos);
  Read(Me.Datos,Reg);
  Anterior:= Reg.Ant;
end;

Function Buscar(var Me:TipoListaDoble;Clave:TipoPosicion;Var pos:TipoPosicion):Boolean;
Var
	Encontrado:Boolean;
	Reg:TipoRegDatos;
  rc:TipoRegControl;
  corte:boolean;
Begin
	Seek(Me.Control,0);
	Read(Me.Control,Rc);
	Pos:=Rc.Primero;
  Encontrado:=False;
  Corte:=false;

	While ((Not Encontrado) And (Pos<>_posNula) and not Corte) Do
		Begin
			Seek(Me.Datos,Pos);
			Read(Me.Datos,Reg);
			IF (reg.Clave=Clave) Then
				Encontrado:=true
			Else
       begin
				if Clave < reg.Clave then
         Corte:=true
          else
          Pos:=Reg.Sig;
       end;

		End;//While
	Buscar:=Encontrado;
End;


end.
