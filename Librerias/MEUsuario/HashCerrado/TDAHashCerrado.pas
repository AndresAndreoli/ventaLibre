unit TDAHashCerrado;

interface
 uses  TDAListasParciales, TDAListaDoble, SysUtils, TiposYconstantes, Dialogs;

const
 _maxHash = TiposYconstantes._Hash;
 _posnula = -1;

type
  tipoClave = tiposYconstantes.tipoClave;
  tipoPosicion = TiposYconstantes.tipoposicion;

  tipoRegDatos = tdaListaDoble.TipoRegDatos;

  tipoHash = tdalistadoble.TipoListaDoble;

function ObtenerHash(Var me:tipoHash; clave:string): integer;

procedure CrearMe(var me:tipoHash; ruta,nombre:string);
procedure AbrirMe(var me:tipoHash);
procedure CerrarMe(var me:tipoHash);

function MeVacio(var me:tipoHash):boolean;

procedure insertarInfo(var me:tipoHash; reg:tiporegdatos;pos:tipoposicion);
procedure modificarInfo(var me:tipoHash; reg:tiporegdatos;pos:tipoposicion);
function  buscar(var me:tipoHash; clave:tipoClave; var pos:tipoposicion):boolean;
procedure CapturarInfo(var me:tipoHash; pos:tipoposicion; var reg: tiporegdatos);


implementation

function ObtenerHash(Var me:tipoHash; clave:string): integer;
var pos: integer;
begin
  pos := ((ord(clave[1])-ord('A'))*100)+((ord(clave[2])-ord('A'))*10)+((ord(clave[3])-ord('A')));

  if pos < 0 then      // Si es negativo lo convierto en positivo
    pos := pos*-1;

  ObtenerHash := pos mod 80;  // mod 80 -> para que este la POS entre 0 - 80
end;
                                    
procedure CrearMe(var me:tipoHash; ruta,nombre:string);
var
 i:integer;
 reg:tiporegdatos;
 Clave:string;
 rc: tdalistadoble.TipoRegControl;

 begin
  tdalistadoble.CrearLd(me,ruta,nombre);
  //AbrirMe(me);
   reset(me.Control);
   reset(me.Datos);
   seek(me.Control,0);
   read(me.Control,rc);

  if rc.Primero= _posnula then
   begin
    for I := 1 to _maxhash do
     begin
      if i < 10 then
       Clave:= '0'+inttostr(i)
       else
        Clave := inttostr(i);

      reg.Clave:= Clave;
      reg.PosEnDatos:= _posnula;
      insertarInfo(me,reg,_posnula); // VOY A INSERTAR SIEMPRE AL FINAL
     end;
   end;

  CerrarMe(me);
 end;

procedure AbrirMe(var me:tipoHash);
 begin
   reset(me.Control);
   reset(me.Datos);
 end;

procedure CerrarMe(var me:tipoHash);
 begin
   TDAListaDoble.CerrarLd(me);
 end;

function MeVacio(var me:tipoHash):boolean;
 begin
  result:= tdalistadoble.ListaVacia(me);
 end;

procedure insertarInfo(var me:tipoHash; reg:tiporegdatos;pos:tipoposicion);
 begin
   tdalistadoble.Insertar(me,reg,pos);
 end;

procedure modificarInfo(var me:tipoHash;reg: tiporegdatos; pos:tipoPosicion);
 begin
   tdalistadoble.Modificar(me,pos,reg);
 end;

procedure CapturarInfo(var me:tipoHash; pos:tipoposicion; var reg: tiporegdatos);
 begin
   tdalistadoble.Capturar(me,pos,reg);
 end;

function buscar(var me:tipoHash; clave:tipoClave; var pos:tipoposicion):boolean;
 begin
   result:= tdalistadoble.Buscar(me,clave,pos);
 end;



end.
