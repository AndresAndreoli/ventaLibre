unit EditElimCategorias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, MECategorias, MEArticulosPublicados, TiposYconstantes;

type
  TformElimModCategoria = class(TForm)
    Label1: TLabel;
    labelNombreRubro: TLabel;
    editNombreRubro: TEdit;
    labelComision: TLabel;
    editComision: TMaskEdit;
    Label2: TLabel;
    btnVolver: TButton;
    btnEditar: TButton;
    btnEliminar: TButton;
    labelPosCategoria: TLabel;
    labelID: TLabel;
    procedure btnVolverClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
  private
    procedure recorrer(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; idCategoria: integer;var existe: boolean);
  public
    { Public declarations }
  end;

var
  formElimModCategoria: TformElimModCategoria;

implementation

uses Categorias, Administrador, Login;

{$R *.dfm}

procedure TformElimModCategoria.btnVolverClick(Sender: TObject);
begin
  formElimModCategoria.Close;
  formCategorias.show;
end;

procedure TformElimModCategoria.btnEditarClick(Sender: TObject);
var
  regCategorias: MECategorias.TipoRegDatos;
  existe: boolean;
begin
existe:= false;

  MEARticulosPublicados.abrir(Publicado);
  recorrer(Publicado, MEArticulosPublicados.raizCategoria(Publicado), strtoint(labelID.caption), existe);
  MEArticulosPublicados.cerrar(Publicado);


  if existe then
    showmessage('La categoria posee publicaciones activas')
  else
if (editNombreRubro.Text='') or (trim(editComision.Text)='') then
  showmessage('Complete todos los campos')
else
  if Dialogs.MessageDlg('Deseas modificar la categoria?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    MECategorias.AbrirMe(Categoria);
    MECategorias.Capturar(Categoria, strtoint(labelPosCategoria.Caption), regCategorias);
    regCategorias.categoria:= editNombreRubro.Text;
    regCategorias.comision:= strtoint(trim(editComision.Text));
    MECategorias.Modificar(Categoria, strtoint(labelPosCategoria.Caption), regCategorias);
    MECategorias.CerrarMe(Categoria);

    MessageDlg('Modificador correctamente.', mtConfirmation, [mbOk], 0);

    formAdministrador.btnCategorias.Click;
    formElimModCategoria.Close;
  end;
end;

procedure TformElimModCategoria.btnEliminarClick(Sender: TObject);
var
  existe: boolean;
begin
  existe:= false;

  MEARticulosPublicados.abrir(Publicado);
  recorrer(Publicado, MEArticulosPublicados.raizCategoria(Publicado), strtoint(labelID.caption), existe);
  MEArticulosPublicados.cerrar(Publicado);


  if existe then
    showmessage('La categoria posee publicaciones activas')
  else
    if Dialogs.MessageDlg('Deseas dar de baja la categoria?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      MECategorias.AbrirMe(Categoria);
      MECategorias.Eliminar(Categoria, strtoint(labelPosCategoria.Caption));
      MECategorias.CerrarMe(Categoria);

      MessageDlg('Eliminado correctamente.', mtConfirmation, [mbOk], 0);

      formAdministrador.btnCategorias.Click;
      formElimModCategoria.Close;
    end;
end;

// Recorrido PreOrden RECURSIVO
procedure TformElimModCategoria.recorrer(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; idCategoria: integer; var existe: boolean);
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;
  estado: string;
begin
  If pos<>MEArticulosPublicados.posNula(Arbol) then
  begin
    MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);

    if (idCategoria=regDatos.IDCategoria) and (not existe) then
      existe:= true;

    recorrer(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), idCategoria, existe);
    recorrer(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), idCategoria, existe);
  end;
end; //recorrer

end.
