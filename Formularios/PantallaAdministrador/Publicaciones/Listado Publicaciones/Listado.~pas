unit Listado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Menus, Login, MEArticulosPublicados;

type
  TformListadoPublicaciones = class(TForm)
    labelRealizadas: TLabel;
    StringGridVentas: TStringGrid;
    MainMenu1: TMainMenu;
    btnSalir: TMenuItem;
    labelRow: TLabel;
    StringGridCaducado: TStringGrid;
    GroupBox1: TGroupBox;
    ComboBoxCategorias: TComboBox;
    Label2: TLabel;
    labelCaducadas: TLabel;
    labelTotal: TLabel;
    labelCobrada: TLabel;
    editTotal: TEdit;
    editCobrada: TEdit;
    GroupBoxCalificacion: TGroupBox;
    ComboBoxCalificacion: TComboBox;
    CheckBoxEstro: TCheckBox;
    procedure btnSalirClick(Sender: TObject);
    procedure ComboBoxCategoriasCloseUp(Sender: TObject);
    procedure ComboBoxCalificacionCloseUp(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formListadoPublicaciones: TformListadoPublicaciones;

implementation

uses PublicacionesAdmin, Publicaciones;

{$R *.dfm}

procedure TformListadoPublicaciones.btnSalirClick(Sender: TObject);
begin
formListadoPublicaciones.CheckBoxEstro.Checked:= false;

formListadoPublicaciones.close;
formPublicacionesAdmin.show;

end;

procedure TformListadoPublicaciones.ComboBoxCategoriasCloseUp(Sender: TObject);
var
  contador, categoriaID, cont, cont1: integer;
begin
  // ============================================================================ Limpiar tabla
  for cont :=0 to formListadoPublicaciones.StringGridCaducado.colcount-1 do
    for cont1 :=0 to formListadoPublicaciones.StringGridCaducado.rowcount-1 do
      formListadoPublicaciones.StringGridCaducado.Cells[cont,cont1] := '';

// =========================================================================== Cargar Cabecera
  formListadoPublicaciones.StringGridCaducado.Cells[0, 0]:= 'Vendedor';
  formListadoPublicaciones.StringGridCaducado.Cells[1, 0]:= 'Articulo';
  formListadoPublicaciones.StringGridCaducado.Cells[2, 0]:= 'Precio';
  formListadoPublicaciones.StringGridCaducado.Cells[3, 0]:= 'Fecha Publicacion';
  formListadoPublicaciones.StringGridCaducado.Cells[4, 0]:= 'Fecha Cierre';

  formListadoPublicaciones.StringGridCaducado.ColWidths[0]:=220;
  formListadoPublicaciones.StringGridCaducado.ColWidths[2]:=110;
  formListadoPublicaciones.StringGridCaducado.ColWidths[3]:=210;
  formListadoPublicaciones.StringGridCaducado.ColWidths[4]:=210;

  contador:= 0; SetLength(vectorArticulos, strtoint(formListadoPublicaciones.labelRow.caption)-1);
  MEArticulosPublicados.abrir(Publicado);
  FormPublicacionesAdmin.recorrer(Publicado, MEArticulosPublicados.raizCategoria(Publicado), contador, vectorArticulos);
  MEArticulosPublicados.cerrar(Publicado);

  if comboboxCategorias.ItemIndex = 0 then
    categoriaID:= 999999999   // 999999999 -> mostrar todas las categorias
  else
    categoriaID:= strtoint(trim(Copy((comboboxCategorias.Items[comboboxCategorias.ItemIndex]),0,2)));

  FormPublicacionesAdmin.filtrar(formPublicacionesAdmin.fechaDesde.DateTime, formPublicacionesAdmin.fechaHasta.DateTime, 2, categoriaID); // 2 -> caducada
end;

procedure TformListadoPublicaciones.ComboBoxCalificacionCloseUp(
  Sender: TObject);
begin
  if (comboboxCalificacion.ItemIndex=0) then
  begin
    checkboxestro.Checked:= false;
    formPublicacionesAdmin.filtrar(formPublicacionesAdmin.fechaDesde.DateTime, formPublicacionesAdmin.fechaHasta.DateTime, 1, 999999999);
  end
  else
  begin
    checkboxestro.Checked:= true;
    formPublicacionesAdmin.filtrar(formPublicacionesAdmin.fechaDesde.DateTime, formPublicacionesAdmin.fechaHasta.DateTime, 1, 999999999);
  end;
end;



end.
