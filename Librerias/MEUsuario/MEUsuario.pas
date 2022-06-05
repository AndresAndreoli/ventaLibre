unit MEUsuario;

interface
 uses TDAHashCerrado, TDAListasParciales,TDAListaDoble, Sysutils, TiposYconstantes, Dialogs;

 const
  _posnula = -1;
  llaveCifrado = TiposYconstantes.llaveCrifrado;

 type
  tipoposicion = tdahashcerrado.tipoPosicion;
  tipoClave = tdahashcerrado.tipoClave;

  {Datos raiz del pre Hash
   contiene la clave hash y los punteros de la lista++++++++}

  tipoRegPreHash = record
                    Hash: 0..79;
                    ControlLista: tdalistasparciales.TipoRegControl;
                   end;

  tipoArchDatosPreHash = file of tipoRegPreHash;
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
  {Datos de la lista parcial del hash, cuando ocurren colisiones}
  tipoListaDatosHash = TDAListasParciales.TipoListaDoble;     // CONTROL y DATOS DE ListaDoble

  tiporegPreListaDatosHash = tdalistasparciales.TipoRegDatos; // DATOS DE LISTA PARCIALES[ant/sig, posDatos, etc]
  //Registro de datos del almacen de la lista hash
  tiporegListaDatosHash = record
                      Clave:         string[50];  // Mail
                      contrasena:    string[30];
                      nombre:        string[30];
                      apellido:      string[30];
                      domicilio:     string[30];
                      provincia:     integer;
                      foto:          TiposYconstantes.TipoFoto;
                      fechaAlta:     TiposYconstantes.TipoFecha;
                      IDUsuario:     integer;
                      estado:        boolean;
                      fechaConexion: TiposYconstantes.TipoFecha;
                      bloqueado:     TiposYconstantes.tipoBloqueado;
                      ventas:        tiposYConstantes.tipoPosicion;
                     end;


  //Almacen de la lista datos hash
  tipoArchListaDatosHash = file of tipoRegListaDatosHash;
  {++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
  tipoEstructura = record
              Hash: tdahashcerrado.tipoHash;
              Datos: tipoArchDatosPreHash;
             end;


  tipoDatosHash = record
                   ListaHash: tipoListaDatosHash;
                   DatosLista : tipoArchListaDatosHash;
                  end;

  tipoMe = record
            Estructura: tipoEstructura;
            Datos: tipoDatosHash;
           end;

procedure CrearMe(var me:tipoMe; ruta,nombre:string);
procedure AbrirMe(var me:tipoMe);
procedure CerrarMe(var me:tipoMe);

procedure insertar(var me:tipome; regMovim:tiporegListaDatosHash);
procedure modificar(var me:tipome; regMovim:tiporegListaDatosHash; pos: integer);
function  eliminar(var me:tipome; regMovim:tiporegListaDatosHash): boolean;

function primeroListaDoble(var me:tipoMe): integer;
function primeroListaDobleParciales(var me:tipoMe; pos: integer): integer;
function ultimoListaDoble(var me:tipoMe): integer;
function ultimoListaDobleParciales(var me:tipoMe; pos: integer): integer;
function proximoListaDoble(var me:tipoMe; pos: integer): integer;
function proximoListaDobleParciales(var me:tipoMe; pos: integer; regMovim: tiporeglistadatoshash): integer;

function Buscar(var me:tipoMe; Clave:tipoClave; var pos:tipoPosicion):boolean;
function Anterior(var me:tipome; pos:tipoposicion):tipoposicion;
procedure CapturarInfo (var me:tipome; var reg:tiporegListaDatosHash; pos:tipoPosicion);

function emailValido(const email : string) : boolean;
procedure cargarAdmin(var me:tipome);
function encriptar(texto: String; llave: Integer): String;
function desencriptar(texto: String; llave: Integer): String;

procedure ingresoUsuario(var me:tipome; pos:tipoposicion; regMovim:tiporegListaDatosHash);
procedure salidaUsuario(var me:tipome; pos:tipoposicion; regMovim:tiporegListaDatosHash);

implementation

procedure CrearMe(var me:tipoMe; ruta,nombre:string);
var faltaArch:boolean;
 rc:tdalistasparciales.TipoRegControl;
 rcAux: tdalistadoble.TipoRegControl;
 regDatosHash:tipoRegPreHash;
 regPreHash:tdahashcerrado.tiporegdatos;
 i:integer;
 begin
  {$i-}
   tdaHashCerrado.CrearMe(me.Estructura.Hash,ruta,nombre);   {.con y .dat de listaDobles}

   assign(me.Estructura.Datos,ruta+nombre+'.hash'); // tipoDatosHash (tipoRegPreHash -> hash: 0..79 y RC de listasParciales(controla indice))
   reset(me.Estructura.Datos);

   faltaArch := IOResult <> 0;

   if faltaArch then
    begin
    rewrite(me.Estructura.Datos);
    tdaHashCerrado.AbrirMe(me.Estructura.Hash);

    seek(me.Estructura.Hash.Control, 0);
    read(me.Estructura.Hash.Control,rcAux);
    rcAux.UltID:=0;
    seek(me.Estructura.Hash.Control,0);
    write(me.Estructura.Hash.Control, rcAux);

    for i := 1 to _maxhash do
      begin
       // Inicializo cabezara de Listas Parciales
       regDatosHash.Hash:= i;
       tdalistasparciales.InicializarCabecera(regDatosHash.ControlLista);
       seek(me.Estructura.Datos,(i-1)); // 0..79
       write(me.Estructura.Datos,regDatosHash);

       // Asocio la lista parcial con el registro de HASH
       tdahashcerrado.CapturarInfo(me.Estructura.Hash,(i-1),regPreHash);
       regPreHash.PosEnDatos:=(i-1); // 0..79
       tdahashcerrado.modificarInfo(me.Estructura.Hash,regPreHash,(i-1));

      end;
    tdaHashcerrado.CerrarMe(me.Estructura.Hash);
    close(me.Estructura.Datos);
    end;

   tdaListasParciales.CrearLd(me.Datos.ListaHash,rc,ruta,'datos_'+nombre); // RegDatos de ListasParciales (NODO indice)
   assign(me.Datos.DatosLista,ruta+nombre+'.alm');                         // RegistroDatos del ME

   reset(me.Datos.DatosLista);
   faltaArch := IOResult <> 0;

   if faltaArch then
    begin
     rewrite(me.Datos.DatosLista);
     close(me.Datos.DatosLista);
    end;
 {$i+}
 end;// CrearMe

procedure AbrirMe(var me:tipoMe);
 begin
  tdaHashCerrado.AbrirMe(me.Estructura.Hash);
  tdalistasparciales.AbrirLd(me.Datos.ListaHash);
  reset(me.Estructura.Datos);
  reset(me.Datos.DatosLista);
 end;// AbrirMe

procedure CerrarMe(var me:tipoMe);
 begin
  tdaHashCerrado.CerrarMe(me.Estructura.Hash);
  tdalistasparciales.CerrarLd(me.Datos.ListaHash);
  close(me.Estructura.Datos);
  close(me.Datos.DatosLista);
 end;// CerrarMe

function Buscar(var me:tipoMe; Clave:tipoClave; var pos:tipoPosicion):boolean;
var hash:tipoPosicion;
  reg:tdahashcerrado.tipoRegDatos;
  regDatosHash: tipoRegPreHash;
 begin
  hash:= ObtenerHash(me.Estructura.Hash,Clave);
  tdahashcerrado.CapturarInfo(me.Estructura.Hash,(hash-1),reg);

  seek(me.Estructura.Datos,reg.PosEnDatos);
  read(me.Estructura.Datos,regDatosHash);
  result:= tdalistasparciales.Buscar(me.Datos.ListaHash,Clave,pos,regDatosHash.ControlLista);
 end; // Buscar

procedure insertar(var me:tipome; regMovim:tiporegListaDatosHash);
var
 hash: 0..80;
 posnueva: tipoPosicion;
 regHash: tdaHashcerrado.tipoRegDatos;
 regDatosHash: tipoRegPreHash;
 regPreLista:tiporegPreListaDatosHash;
 pos:tipoposicion;
 rc: tdalistadoble.TipoRegControl;
 begin
   hash:= ObtenerHash(me.Estructura.Hash,regMovim.Clave);
   //Capturo el registro que tiene el Hash (Lista Doble)
   tdaHashCerrado.CapturarInfo(me.Estructura.Hash,(hash-1),regHash);

   //Capturo el registro en el almacen de datos del pre Hash
   seek(me.Estructura.Datos,regHash.PosEnDatos);
   read(me.Estructura.Datos,regDatosHash); //Cabecera de colas Parciales

   // IDUsuario autoincremental
   seek(me.Estructura.Hash.Control, 0);
   read(me.Estructura.Hash.Control,rc);
   regMovim.IDUsuario:= rc.UltID;
   rc.UltID:= rc.UltID+1;
   seek(me.Estructura.Hash.Control, 0);
   write(me.Estructura.Hash.Control, rc);

   {Grabo el registro de la lista parcial en el almacen de la misma}
   posnueva:= filesize(me.Datos.DatosLista);
   seek(me.Datos.DatosLista,posnueva);
   write(me.Datos.DatosLista,regMovim);

   regPreLista.Clave:=regMovim.Clave; // regPreLista - > datos ListasPariaciales -- Clave = MAIL
   regPreLista.PosEnDatos:= posnueva;
   tdalistasparciales.Buscar(me.Datos.ListaHash,regPreLista.Clave,pos,regDatosHash.ControlLista);

    tdalistasparciales.Insertar(me.Datos.ListaHash,regPrelista,pos,regDatosHash.ControlLista);
   {++++++++++++++++++++++++++++++++++++++++++}

   //Actualizo el registro que contiene la cabecera de la lista parcial.
   seek(me.Estructura.Datos,regHash.PosEnDatos);
   write(me.Estructura.Datos,regDatosHash);
 end;// insertar

function Anterior(var me:tipome; pos:tipoposicion):tipoposicion;
 begin
  result:= tdalistasparciales.Anterior(me.Datos.ListaHash,pos);
 end;

procedure CapturarInfo (var me:tipome; var reg:tiporegListaDatosHash; pos:tipoPosicion);
var
 r:tiporegPreListaDatosHash;
 begin
  tdalistasparciales.Capturar(me.Datos.ListaHash,pos,r);
  seek(me.Datos.DatosLista,r.PosEnDatos);
  read(me.Datos.DatosLista,reg);
 end;

//Comprobar si una dirección de mail
//es válida (el formato aaaaa@bbbbb.ccc)
function emailValido(const email : string) : boolean;
  function caracterPermitido(const s : string) : boolean;
    var i : integer;
  begin
    Result := False;
    //Solo puede tener los siguientes caracteres
    //tanto en la parte de servidor como de usuario
    for i := 1 to Length(s) do
      if not (s[i] in ['a'..'z','A'..'Z','0'..'9','_','-','.']) then
        exit;
    Result := true;
  end;
var
  i, longitudServidor : integer;
  parteUsuario, parteServidor : string;
begin
  Result := False;
  i := Pos('@', email);
  //Debe tener, al menos, un carácter antes de la @ y no
  //puede tener dos puntos seguidos ..
  if (i = 0) or (i = 1) or (Pos('..', email) > 0) then
    exit;
  parteUsuario := Copy(email, 1, i - 1);
  parteServidor := Copy(email, i + 1, Length(email));
  longitudServidor := Length(parteServidor);
  //Debe tener un punto y, al menos, 3 caracteres desde la arroba
  //hasta el final  (aaa@servidor.com)
  if (longitudServidor < 3) or (Pos('.', parteServidor) = 0) or
      (parteServidor[1] = '.') or (parteServidor[longitudServidor] = '.') or
      (parteServidor[longitudServidor - 1] = '.') then
    exit;
  Result := caracterPermitido(parteUsuario) and
      caracterPermitido(parteServidor);
end;

procedure cargarAdmin(var me:tipome);
var
  regMovim:tiporegListaDatosHash;
begin
  regMovim.Clave:=          'administrador@ventalibre.com';
  regMovim.contrasena:=     encriptar('newton',llaveCrifrado);
  regMovim.nombre :=        'Admin';
  regMovim.apellido :=      'Admin';
  regMovim.domicilio :=     'Admin';
  regMovim.provincia :=     1;
  regMovim.fechaAlta :=     now();
  regMovim.fechaConexion := now();
  regMovim.estado :=        false;
  regMovim.foto :=          tiposyconstantes.imgAdmin;
  regMovim.bloqueado:=      false;

  MEUsuario.insertar(me, regMovim);

  // ++++++++++++++++++++++++++++++++++++++++ INSERTAR USUARIOS +++++++++++++++++++++++++++++++++++++++++
  {regMovim.Clave:=          'andresandreoli@hotmail.com';
  regMovim.contrasena:=     encriptar('andres',llaveCrifrado);
  regMovim.nombre :=        'Andres';
  regMovim.apellido :=      'Androli';
  regMovim.domicilio :=     'Alem 178';
  regMovim.provincia :=     1;
  regMovim.fechaAlta :=     now();
  regMovim.fechaConexion := now();
  regMovim.estado :=        false;
  regMovim.foto :=          tiposyconstantes.imgAdmin;
  regMovim.bloqueado:=      false;

  MEUsuario.insertar(me, regMovim);

  regMovim.Clave:=          'rodrigo.perez@gmail.com';
  regMovim.contrasena:=     encriptar('rodrigo',llaveCrifrado);
  regMovim.nombre :=        'Rodrigo';
  regMovim.apellido :=      'Perez';
  regMovim.domicilio :=     'balcarce 1520';
  regMovim.provincia :=     5;
  regMovim.fechaAlta :=     now();
  regMovim.fechaConexion := now();
  regMovim.estado :=        false;
  regMovim.foto :=          tiposyconstantes.imgAdmin;
  regMovim.bloqueado:=      false;

  MEUsuario.insertar(me, regMovim);

  regMovim.Clave:=          'camilabenestante93@yahoo.com';
  regMovim.contrasena:=     encriptar('camila93',llaveCrifrado);
  regMovim.nombre :=        'Camila';
  regMovim.apellido :=      'Benestante';
  regMovim.domicilio :=     'Washington 1520';
  regMovim.provincia :=     7;
  regMovim.fechaAlta :=     now();
  regMovim.fechaConexion := now();
  regMovim.estado :=        true;
  regMovim.foto :=          tiposyconstantes.imgAdmin;
  regMovim.bloqueado:=      false;

  MEUsuario.insertar(me, regMovim);

  regMovim.Clave:=          '_facundoaltamar@yahoo.com';
  regMovim.contrasena:=     encriptar('_facundo',llaveCrifrado);
  regMovim.nombre :=        'Facundo';
  regMovim.apellido :=      'Altamar';
  regMovim.domicilio :=     'Washington 1520';
  regMovim.provincia :=     7;
  regMovim.fechaAlta :=     now();
  regMovim.fechaConexion := now();
  regMovim.estado :=        false;
  regMovim.foto :=          tiposyconstantes.imgAdmin;
  regMovim.bloqueado:=      true;

  MEUsuario.insertar(me, regMovim);

  regMovim.Clave:=          '123julieta@duo.com';
  regMovim.contrasena:=     encriptar('123julieta',llaveCrifrado);
  regMovim.nombre :=        'Julieta';
  regMovim.apellido :=      'porta';
  regMovim.domicilio :=     'Washington 1520';
  regMovim.provincia :=     7;
  regMovim.fechaAlta :=     now();
  regMovim.fechaConexion := now();
  regMovim.estado :=        true;
  regMovim.foto :=          tiposyconstantes.imgAdmin;
  regMovim.bloqueado:=      false;

  MEUsuario.insertar(me, regMovim);

  regMovim.Clave:=          'pepe.pepe_alta@hotmail.com';
  regMovim.contrasena:=     encriptar('pepe.pepe',llaveCrifrado);
  regMovim.nombre :=        'Pepe';
  regMovim.apellido :=      'Pepe';
  regMovim.domicilio :=     'Washington 1520';
  regMovim.provincia :=     7;
  regMovim.fechaAlta :=     now();
  regMovim.fechaConexion := now();
  regMovim.estado :=        false;
  regMovim.foto :=          tiposyconstantes.imgAdmin;
  regMovim.bloqueado:=      false;

  MEUsuario.insertar(me, regMovim);

  regMovim.Clave:=          'fabian.fabian@dou.com';
  regMovim.contrasena:=     encriptar('fabian..fabian',llaveCrifrado);
  regMovim.nombre :=        'fabian';
  regMovim.apellido :=      'fabian';
  regMovim.domicilio :=     'Washington 1520';
  regMovim.provincia :=     15;
  regMovim.fechaAlta :=     now();
  regMovim.fechaConexion := now();
  regMovim.estado :=        false;
  regMovim.foto :=          tiposyconstantes.imgAdmin;
  regMovim.bloqueado:=      true;

  MEUsuario.insertar(me, regMovim); }
  // ++++++++++++++++++++++++++++++++++++++++ INSERTAR USUARIOS +++++++++++++++++++++++++++++++++++++++++

end;// cargarAdmin

// ----------------------------------------------------------------------------- CIFRADO DE CONTRASEÑA

function encriptar(texto: String; llave: Integer): String;
var i:integer;
 cadena:string;
begin
 cadena:='';

 for i:=1 to Length(texto) do                                                   //Recorro cada letra para encriptar
  if (i mod 2) = 0 then                                                         //Determino si es par o impar segun la posicion de le letra dentro del string
   cadena:=cadena+Chr(ord(texto[i])+7+llave)                                    //Busco el caracter del ordinal de la letra + 7 + llave(10)
    else
     cadena:=cadena+Chr(ord(texto[i])-7-llave);                                 //Busco el caracter del ordinal de la letra - 7 - llave(10)

 result:= cadena;
end;// encriptar


function desencriptar(texto: String; llave: Integer): String;
var i:integer;
cadena:string;
begin
 cadena:='';

 for i:=1 to Length(texto) do
  if (i mod 2) = 0 then //caracter par
   cadena:=cadena+Chr(ord(texto[i])-7-llave)
    else
     cadena:=cadena+Chr(ord(texto[i])+7+llave);

 result:= cadena;
end;// desencriptar

// ----------------------------------------------------------------------------- ESTADO DEL USUARIO
// ESTADO ONLINE
procedure ingresoUsuario(var me:tipome; pos: tipoposicion; regMovim:tiporegListaDatosHash);
var
  r: tiporegPreListaDatosHash;
  
begin
  //reg.IDUsuario := regMovim.IDUsuario - 1;
  regMovim.estado := true;

  MEUSuario.modificar(me, regMovim, pos);
end;// ingresoUsuario

// ESTADO OFFLINE
procedure salidaUsuario(var me:tipome; pos: tipoposicion; regMovim:tiporegListaDatosHash);
var
  r: tiporegPreListaDatosHash;

begin
  //reg.IDUsuario := regMovim.IDUsuario - 1;
  regMovim.estado := false;
  regMovim.fechaConexion := now();

  MEUSuario.modificar(me, regMovim, pos);
end;

procedure modificar(var me:tipome; regMovim:tiporegListaDatosHash; pos: integer);
var
  regHash: tdaHashcerrado.tipoRegDatos;
  reg, regAux: tiporegListaDatosHash;
  r: tiporegPreListaDatosHash;
  regDatosHash: tipoRegPreHash;
begin
  tdalistasparciales.Capturar(me.Datos.ListaHash,pos,r);
  seek(me.Datos.DatosLista,r.PosEnDatos);
  read(me.Datos.DatosLista,reg);

  reg.Clave :=          regMovim.Clave;
  reg.contrasena :=     regMovim.contrasena;
  reg.nombre :=         regMovim.nombre;
  reg.apellido :=       regMovim.apellido;
  reg.domicilio :=      regMovim.domicilio;
  reg.provincia :=      regMovim.provincia;
  reg.foto :=           regMovim.foto;
  reg.IDUsuario :=      reg.IDUsuario;
  reg.fechaAlta :=      regMovim.fechaAlta;
  reg.fechaConexion :=  regMovim.fechaConexion;
  reg.estado :=         regMovim.estado;
  reg.bloqueado:=       regMovim.bloqueado;

  seek(me.Datos.DatosLista,r.PosEnDatos);
  write(me.Datos.DatosLista,reg);
end;// modificar

function eliminar(var me:tipome; regMovim:tiporegListaDatosHash ): boolean;
var
  hash: integer;
  regHash: tdaHashcerrado.tipoRegDatos;
  regDatosHash: tipoRegPreHash;
  pos:integer;
begin
  hash:= ObtenerHash(me.Estructura.Hash,regmovim.Clave);
  //Capturo el registro que tiene el Hash (Lista Doble)
  tdahashcerrado.CapturarInfo(me.Estructura.Hash,(hash-1),regHash);

  //Capturo el registro en el almacen de datos del pre Hash - > cabecera
  seek(me.Estructura.Datos,regHash.PosEnDatos);
  read(me.Estructura.Datos,regDatosHash);

  //Busco la POS en listasParciales
  tdalistasparciales.Buscar(me.Datos.ListaHash,regMovim.Clave,pos,regDatosHash.ControlLista);

  //Elimino el Usuario
  tdalistasparciales.Eliminar(me.Datos.listaHash, pos, regDatosHash.ControlLista);

  //Actualizo el registro que contiene la cabecera de la lista parcial.
  seek(me.Estructura.Datos,regHash.PosEnDatos);
  write(me.Estructura.Datos,regDatosHash);

  if tdalistasparciales.Buscar(me.Datos.ListaHash,regMovim.Clave,pos,regDatosHash.ControlLista) then
    eliminar:= true
  else
    eliminar:= false;
end;// eliminar

//============================================================================== primeroListaDoble
function primeroListaDoble(var me:tipoMe): integer;
begin
  primeroListaDoble:= TDAListaDoble.Primero(me.estructura.hash);
end;

//============================================================================== ultimoListaDoble
function ultimoListaDoble(var me:tipoMe): integer;
begin
  ultimoListaDoble:= TDAListaDoble.Ultimo(me.estructura.hash);
end;

//============================================================================== primeroListaDobleParciales
function primeroListaDobleParciales(var me:tipoMe; pos: integer): integer;
var
   r: tiporegPreListaDatosHash;
   regDatosHash: tipoRegPreHash;
   regHash: tdaHashcerrado.tipoRegDatos;
begin
   tdaHashCerrado.CapturarInfo(me.Estructura.Hash, pos, regHash);

   //Capturo el registro en el almacen de datos del pre Hash
   seek(me.Estructura.Datos,regHash.PosEnDatos);
   read(me.Estructura.Datos,regDatosHash); // Obtengo la cabecera

   primeroListaDobleParciales:= TDAListasParciales.Primero(me.Datos.ListaHash, regDatosHash.ControlLista);
end;

//============================================================================== ultimoListaDobleParciales
function ultimoListaDobleParciales(var me:tipoMe; pos: integer): integer;
var
   r: tiporegPreListaDatosHash;
   regDatosHash: tipoRegPreHash;
   regHash: tdaHashcerrado.tipoRegDatos;
begin
   tdaHashCerrado.CapturarInfo(me.Estructura.Hash, (pos), regHash);

   //Capturo el registro en el almacen de datos del pre Hash
   seek(me.Estructura.Datos,regHash.PosEnDatos);
   read(me.Estructura.Datos,regDatosHash); // Obtengo la cabecera

   ultimoListaDobleParciales:= TDAListasParciales.Primero(me.Datos.ListaHash, regDatosHash.ControlLista);
end;

//============================================================================== proximoListaDoble
function proximoListaDoble(var me:tipoMe; pos: integer): integer;
begin
  proximoListaDoble:= TDAListaDoble.Proximo(me.estructura.hash, pos);
end;

//============================================================================== proximoListaDobleParciales
function proximoListaDobleParciales(var me:tipoMe; pos: integer; regMovim: tiporeglistadatoshash): integer;
var
   r: tiporegPreListaDatosHash;
   regDatosHash: tipoRegPreHash;
   regHash: tdaHashcerrado.tipoRegDatos;
   hash: integer;
begin
   hash:= ObtenerHash(me.Estructura.Hash,regMovim.Clave);
   tdaHashCerrado.CapturarInfo(me.Estructura.Hash, hash, regHash);

   //Capturo el registro en el almacen de datos del pre Hash
   seek(me.Estructura.Datos,regHash.PosEnDatos);
   read(me.Estructura.Datos,regDatosHash); // Obtengo la cabecera

   proximoListaDobleParciales:= TDAListasParciales.Proximo(me.Datos.ListaHash, pos);
end;
end.
