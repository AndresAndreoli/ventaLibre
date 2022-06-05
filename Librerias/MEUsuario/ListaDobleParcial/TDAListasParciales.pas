unit TDAListasParciales;

interface

Uses
  Dialogs;

Const

	_PosNula    = -1;
	_ClaveNula  = '';
  _ExtControl = '.con';
  _ExtDatos   = '.data';

Type
	TipoPosicion = longint;
	TipoClave= string[40];

	TipoRegDatos = Record
                      Clave:TipoClave;
                      Ant,Sig:TipoPosicion;
                      PosEnDatos: TipoPosicion;
			          end;

	TipoRegControl= Record
				                Primero:TipoPosicion;
                        Ultimo:TipoPosicion;
                        Borrado:TipoPosicion;
                  end;

  TipoArchivoDatos = File Of TipoRegDatos;
	TipoArchivoControl = File of TipoRegControl;

	TipoListaDoble = Record
				              Datos:TipoArchivoDatos;
                      Control: TipoArchivoControl;
			             End;

Procedure CrearLd (Var Me:TipoListaDoble; var rc:tipoRegControl; Ruta, Nombre:String);
procedure AbrirLd   (var Me: TipoListaDoble);
procedure CerrarLd  (var Me: TipoListaDoble);
procedure DestruirLista (var Me: TipoListaDoble);
procedure InicializarCabecera(var rc:TipoRegControl);
function ListaVacia(var Lista: TipoListaDoble; rc:tipoRegControl): Boolean;


Procedure Insertar     (var Me:TipoListaDoble; Reg :TipoRegDatos;Pos:TipoPosicion; var rc:tipoRegControl);
procedure Eliminar     (var Me:TipoListaDoble; Pos:TipoPosicion; var rc:tipoRegControl);
procedure Capturar     (var Me:TipoListaDoble; Pos:TipoPosicion; var Reg:TipoRegDatos);
procedure CapturarControl (var Me:TipoListaDoble; var Reg:TipoRegControl);
procedure Modificar    (var Me:TipoListaDoble; Pos:TipoPosicion; Reg:TipoRegDatos);
function Primero       (var Me:TipoListaDoble; rc:tipoRegControl): TipoPosicion;
function Ultimo        (var Me:TipoListaDoble; rc:tipoRegControl): TipoPosicion;
function PosNula       (var Me:TipoListaDoble): TipoPosicion;
function ClaveNula     (var Me:TipoListaDoble): TipoClave;
Function Anterior      (var Me:TipoListaDoble;Pos:TipoPosicion):TipoPosicion;
function Proximo       (var Me:TipoListaDoble;Pos:TipoPosicion):TipoPosicion;
Function Buscar(var Me:TipoListaDoble;Clave:TipoClave;Var pos:TipoPosicion; rc:tipoRegControl):Boolean;

Implementation

uses Math,SysUtils,Forms;

Var

Me:TipoListaDoble;

Procedure CrearLd (Var Me:TipoListaDoble; var rc:tipoRegControl; Ruta, Nombre:String);
Var
	FaltaDatos:Boolean;

Begin

	Assign(Me.Datos,Ruta+Nombre+_ExtDatos);
	{$i-} //-> Directiva de compilación (Coloca el error en una variable de entorno que se llama ioresult

	Reset(Me.Datos);
	FaltaDatos:=(ioResult<>0);
	If (FaltaDatos) then
    begin

		  Rc.Primero:=_PosNula;
		  Rc.Ultimo:=_PosNula;
      Rc.Borrado:=_Posnula;

		  Rewrite(Me.Datos);

		  Close(Me.Datos);
    end;


	{$i+}
End;
////////////////////////////////////////////////////////////////////////////////

procedure AbrirLD (var Me: TipoListaDoble);
   begin
    reset (Me.Datos);
   end;
////////////////////////////////////////////////////////////////////////////////

  procedure CerrarLD (var Me: TipoListaDoble);
   begin
    Close (Me.Datos);
   end;

////////////////////////////////////////////////////////////////////////////////
   procedure DestruirLista (var Me: TipoListaDoble);
   begin
    Erase (Me.Datos);
   end;
////////////////////////////////////////////////////////////////////////////
   procedure InicializarCabecera(var rc:TipoRegControl);
   begin
     rc.Primero:= _posnula;
     rc.Ultimo := _posnula;
     rc.Borrado:= _posnula;
   end;
////////////////////////////////////////////////////////////////////////////

function ListaVacia(var Lista: TipoListaDoble; rc:tipoRegControl): Boolean;
  begin
    result:= (Rc.Primero = _posnula);
  end;

////////////////////////////////////////////////////////////////////////////
  Procedure Insertar (var Me:TipoListaDoble; Reg :TipoRegDatos; Pos:TipoPosicion; var rc:tipoRegControl); //Se inserta a lo ultimo
   var
    Raux,RauxAnt,RegBorr:TipoRegDatos;
    PosNueva,posant:TipoPosicion;
   
   begin

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

    {showmessage('primero'+inttostr(rc.Primero));
    showmessage('pos nueva'+inttostr(PosNueva));
    showmessage('ultimo'+inttostr(rc.Ultimo));}
   end;


////////////////////////////////////////////////////////////////////////////
procedure Eliminar     (var Me:TipoListaDoble; Pos:TipoPosicion; var rc:tipoRegControl);
var
 Raux,RauxSig,RauxAnt:TipoRegDatos;

begin

  Seek(Me.Datos,Pos);
  Read(Me.Datos,Raux);

  {showmessage('pos: '+inttostr(pos));
  showmessage('pos primero: '+inttostr(rc.primero));
  showmessage('pos ultimo: '+inttostr(rc.ultimo));}

  If (Rc.Primero=pos) and (Rc.Ultimo=Pos) Then   //Esta vacio
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
  
   end;



////////////////////////////////////////////////////////////////////////////
procedure Capturar     (var Me:TipoListaDoble; Pos:TipoPosicion; var Reg:TipoRegDatos);
begin
  Seek(Me.Datos,Pos);
  Read(Me.Datos,reg);
end;

////////////////////////////////////////////////////////////////////////////
procedure CapturarControl     (var Me:TipoListaDoble; var Reg:TipoRegControl);
begin
  Seek(Me.Control, 0);
  Read(Me.Control,reg);
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



function Primero       (var Me:TipoListaDoble; rc:tipoRegControl): TipoPosicion;

begin
 result:=Rc.Primero;
end;

////////////////////////////////////////////////////////////////////////////
function Ultimo        (var Me:TipoListaDoble; rc:tipoRegControl): TipoPosicion;

begin
 result:=Rc.Ultimo;
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

Function Buscar(var Me:TipoListaDoble;Clave:TipoClave;Var pos:TipoPosicion; rc:tipoRegControl):Boolean;
Var
	Encontrado:Boolean;
	Reg:TipoRegDatos;
  corte:boolean;
Begin

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
