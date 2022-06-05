unit MisVentas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, ComCtrls;

type
  TformMisVentas = class(TForm)
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    StringGridMisVentas: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    ComboBoxCalificacion: TComboBox;
    Label3: TLabel;
    DateTimePickerDesde: TDateTimePicker;
    DateTimePickerHasta: TDateTimePicker;
    Label4: TLabel;
    Label5: TLabel;
    procedure Salir1Click(Sender: TObject);
    procedure StringGridMisVentasDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure ComboBoxCalificacionCloseUp(Sender: TObject);
    procedure DateTimePickerDesdeCloseUp(Sender: TObject);
    procedure DateTimePickerHastaCloseUp(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMisVentas: TformMisVentas;

implementation

uses PantallaUsuario, Login;

{$R *.dfm}

procedure TformMisVentas.Salir1Click(Sender: TObject);
begin
  formMisVentas.close;
  formUsuario.show;
  formLogin.cargarPublicacionesInicio();
end;

procedure TformMisVentas.StringGridMisVentasDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
with Sender as TStringGrid do
  if cells[ACol, ARow] = 'No Pagado' then
  begin
    Canvas.Brush.Color:= clRed;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, Cells[Acol, ARow]);
  end
  else
  if cells[ACol, ARow] = 'Pagado' then
  begin
    Canvas.Brush.Color:= clgreen;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, Cells[Acol, ARow]);
  end;
end;

procedure TformMisVentas.ComboBoxCalificacionCloseUp(Sender: TObject);
begin
  if ComboBoxCalificacion.ItemIndex = 0 then
    formUsuario.cargarMisVentas(98) // 98 -> Sil filtro pero restricciones de fecha
  else
    formUsuario.cargarMisVentas(ComboBoxCalificacion.ItemIndex-1); // Depende de lo que seleccione filtro
end;

procedure TformMisVentas.DateTimePickerDesdeCloseUp(Sender: TObject);
begin
if ComboBoxCalificacion.ItemIndex = 0 then
    formUsuario.cargarMisVentas(98) // 98 -> Sil filtro pero restricciones de fecha
  else
    formUsuario.cargarMisVentas(ComboBoxCalificacion.ItemIndex-1); // Depende de lo que seleccione filtro
end;

procedure TformMisVentas.DateTimePickerHastaCloseUp(Sender: TObject);
begin
if ComboBoxCalificacion.ItemIndex = 0 then
    formUsuario.cargarMisVentas(98) // 98 -> Sil filtro pero restricciones de fecha
  else
    formUsuario.cargarMisVentas(ComboBoxCalificacion.ItemIndex-1); // Depende de lo que seleccione filtro
end;

end.
