unit TiposYconstantes;

interface

uses
  Sysutils, dialogs;

const
  llaveCrifrado = 10; // Llave CIFRADO contraseña
  //diasPublicacion = 90;

  vectorProvincias: array[0..23] of string = (
      'CABA',
      'BUENOS AIRES',
      'CATAMARCA',
      'CORDOBA',
      'CORRIENTES',
      'ENTRE RIOS',
      'JUJUY',
      'MENDOZA',
      'LA RIOJA',
      'SALTA',
      'SAN JUAN',
      'SAN LUIS',
      'SANTA FE',
      'SANTIAGO DEL ESTERO',
      'TUCUMAN',
      'CHACO',
      'CHUBUT',
      'FORMOSA',
      'MISIONES',
      'NEUQUEN',
      'LA PAMPA',
      'RIO NEGRO',
      'SANTA CRUZ',
      'TIERRA DEL FUEGO'
      );

  _PosNula = -1;
  _PrimerElemento = 0;
  _ClaveNula = '';
  _Hash = 80;

type
  TipoPosicion      = Longint;
  TipoEnlace        = Longint;
  TipoEstado        = Byte;
  TipoComision      = integer;
  TipoClave         = String[30];
  TipoClaveNumerica = integer;
  TipoCategoria     = String[30];
  TipoInfo          = String[30];
  TipoDescripcion   = String[255];
  TipoPrecio        = real;
  TipoFecha         = tdatetime;
  TipoFoto          = string[100];
  TipoBloqueado     = boolean;
  TipoProvincia     = integer;
  TipoMensaje       = string[100];
  TipoNombre        = string[50];
  tipoComisionCobrada = boolean;

procedure cargarCarpetas(ruta: string);


var
  firstPartImg, carpImagenes, carpArchivos, imgAdmin, imgPub, imgDesco: string;

implementation
procedure cargarCarpetas(ruta: string);
begin
  firstPartImg := ruta;

  carpImagenes := firstPartImg+'\Datos\Imagenes\';
  carpArchivos := firstPartImg+'\Datos\Archivos\';
  imgDesco :=     firstPartImg+'\Datos\Imagenes\noBorrar\Desconocido.jpg';
  imgPub :=       firstPartImg+'\Datos\Imagenes\noBorrar\articulos.jpg';
  imgAdmin:=      firstPartImg+'\Datos\Imagenes\noBorrar\Administrador.jpg';
end;

end.
