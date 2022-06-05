unit MenuPublicidad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MEArticulosPublicados, Login, MEUsuario;

type
  TformMenuAdmPublicaciones = class(TForm)
    labelCodigo: TLabel;
    btnBloquear: TButton;
    btnDesbloquear: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBloquearClick(Sender: TObject);
    procedure btnDesbloquearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMenuAdmPublicaciones: TformMenuAdmPublicaciones;

implementation

uses PublicacionesAdmin, Administrador, ConversacionesAdmin, AdmUsuario;

{$R *.dfm}

procedure TformMenuAdmPublicaciones.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  formPublicacionesAdmin.enabled:= true;
  formMenuAdmPublicaciones.hide;
end;

procedure TformMenuAdmPublicaciones.btnBloquearClick(Sender: TObject);
var
  pos: integer;
  regInd: MEArticulosPublicados.tipoRegIndice;
  regDatos: MEArticulosPublicados.tipoREgDatos;
begin
MEArticulosPublicados.abrir(Publicado);
MEArticulosPublicados.buscarCategorias(Publicado, labelCodigo.Caption, pos);
MEArticulosPublicados.capturarCategorias(Publicado, pos, regInd);
MEArticulosPublicados.capturarArticulo(Publicado, regInd, regDatos);
regDatos.estadoPublicacion:= 5; //Bloqueado
MEArticulosPublicados.modificar(Publicado, regInd, regDatos);
MEArticulosPublicados.cerrar(Publicado);

formPublicacionesAdmin.enabled:= true;
formMenuAdmPublicaciones.hide;

//Actualizo tabla
if (formPublicacionesAdmin.comboboxUsuarios.ItemIndex=0) then
  formAdministrador.cargarPublicacionesAdmin(false, 1)
  else
  formAdministrador.cargarPublicacionesAdmin(true, 1);
end;

procedure TformMenuAdmPublicaciones.btnDesbloquearClick(Sender: TObject);
var
  pos: integer;
  regInd: MEArticulosPublicados.tipoRegIndice;
  regDatos: MEArticulosPublicados.tipoREgDatos;
begin
MEArticulosPublicados.abrir(Publicado);
MEArticulosPublicados.buscarCategorias(Publicado, labelCodigo.Caption, pos);
MEArticulosPublicados.capturarCategorias(Publicado, pos, regInd);
MEArticulosPublicados.capturarArticulo(Publicado, regInd, regDatos);
regDatos.estadoPublicacion:= 2; //Pausado
MEArticulosPublicados.modificar(Publicado, regInd, regDatos);
MEArticulosPublicados.cerrar(Publicado);

formPublicacionesAdmin.enabled:= true;
formMenuAdmPublicaciones.hide;

//Actualizo tabla
if (formPublicacionesAdmin.comboboxUsuarios.ItemIndex=0) then
  formAdministrador.cargarPublicacionesAdmin(false, 1)
  else
  formAdministrador.cargarPublicacionesAdmin(true, 1);
end;

end.
