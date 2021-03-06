unit Categorias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Menus, StdCtrls, MECategorias, TiposYconstantes, Buttons;

type
  TformCategorias = class(TForm)
    StringGridCategorias: TStringGrid;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    labelCategorias: TLabel;
    btnNuevo: TButton;
    btnAyuda: TBitBtn;
    procedure Salir1Click(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure StringGridCategoriasDblClick(Sender: TObject);
    procedure btnAyudaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formCategorias: TformCategorias;
  Categoria: MECategorias.tipoMe;

implementation

uses Administrador, crearCategorias, EditElimCategorias, AdmUsuario;

{$R *.dfm}

procedure TformCategorias.Salir1Click(Sender: TObject);
begin
  formCategorias.Close;
  formAdministrador.show;
end;

procedure TformCategorias.btnNuevoClick(Sender: TObject);
begin
  formCategorias.Close;
  formCrearCategoria.show;
end;

procedure TformCategorias.StringGridCategoriasDblClick(Sender: TObject);
var
  codCategoria, pos: integer;
  regCategorias: MECategorias.TipoRegDatos;
begin
if not (StringGridCategorias.Cells[0, 1]='') then begin
  MECategorias.AbrirMe(Categoria);
  {Validar que no haya articulos VENDIDOS o a VENDER}  {POR RAZONES DE AMBIGUEDADES en el tp, no se puede modificar/eliminar categorias que contengan publicaciones, ya sea activa, pausada, bloqueada, anulada, etc}
  if (strtoint(StringGridCategorias.Cells[3, StringGridCategorias.Row])>0) or (strtoint(StringGridCategorias.Cells[4, StringGridCategorias.Row])>0) or (strtoint(StringGridCategorias.Cells[5, StringGridCategorias.Row])>0) or (strtoint(StringGridCategorias.Cells[6, StringGridCategorias.Row])>0) then
    messagedlg('No se puede modificar/eliminar articulos con publicaciones activas o vendidas', mtWarning, [mbOk], 0)
  else
    begin
      codCategoria:= strtoint(StringGridCategorias.Cells[0, StringGridCategorias.Row]);
      MECategorias.Buscar(Categoria, codCategoria, pos);
      MECategorias.Capturar(Categoria, pos, regCategorias);

      formElimModCategoria.editNombreRubro.Text := regCategorias.categoria;
      formElimModCategoria.editComision.Text    := inttostr(regCategorias.comision);
      formElimModCategoria.labelID.Caption:= inttostr(regCategorias.Clave);

      formElimModCategoria.labelPosCategoria.Caption:= inttostr(pos);

      formElimModCategoria.show;
      formCategorias.Close;
    end;

    MECategorias.CerrarMe(Categoria);
  end; // IF TABLA VACIA
end;

procedure TformCategorias.btnAyudaClick(Sender: TObject);
begin
messagedlg('Para eliminar/modificar una CATEGORIA'+#13+
            'debe hacer doble Click sobre la categoria'+#13+
            'deseada.'+#13+ #13+
            '------------ ADVERTENCIA ------------'+#13+
            'Si la categoria posee articulos en venta'+#13+
            'o vendididos, no podras realizar tales'+#13+
            'acciones.'+#13+
            '--------------- NOTA ----------------'+#13+
            'Por temas de ambiguedad en el TP, no se puede'+#13+
            'eliminar/modificar categorias con publicaciones.', mtInformation, [mbOk], 0)
end;

end.
