unit Compras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, MEUsuario, Login;

type
  TformMisCompras = class(TForm)
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    stringgridCompras: TStringGrid;
    procedure Salir1Click(Sender: TObject);
    procedure stringgridComprasDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure stringgridComprasDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMisCompras: TformMisCompras;

implementation

uses PantallaUsuario, MenuCompras;

{$R *.dfm}

procedure TformMisCompras.Salir1Click(Sender: TObject);
begin
  formMisCompras.Close;
  formUsuario.show;
  formLogin.cargarPublicacionesInicio();
end;

procedure TformMisCompras.stringgridComprasDrawCell(Sender: TObject; ACol,
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

procedure TformMisCompras.stringgridComprasDblClick(Sender: TObject);
var
Cur : TPoint;
  x, y, pos:integer;
  reg: MEUsuario.tiporegListaDatosHash;
begin
  if not (stringgridCompras.Cells[0, stringgridCompras.Row]='') then
  begin
    GetCursorPos(Cur);
    formMenuCompras.top:= cur.Y;
    formMenuCompras.left:= cur.X;
    MEUsuario.AbrirMe(Usuario);
    MEUsuario.Buscar(Usuario, formUsuario.labelMail.Caption, pos);
    MEUsuario.CapturarInfo(Usuario, reg, pos);
    MEUsuario.CerrarMe(Usuario);
    formMenuCompras.labelIDUsuario.Caption:= inttostr(reg.IDUsuario);
    formMenuCompras.labelIDPub.Caption := stringgridCompras.Cells[0, stringgridCompras.Row];
    formMenuCompras.Show;
    formMiscompras.Enabled:= false;

    if stringgridCompras.Cells[5, stringgridCompras.Row]='Recomendable' then
      formMenuCompras.ComboBoxCalificacion.ItemIndex:= 1;

    if stringgridCompras.Cells[5, stringgridCompras.Row]='Neutral' then
      formMenuCompras.ComboBoxCalificacion.ItemIndex:= 2;

    if stringgridCompras.Cells[5, stringgridCompras.Row]='No Recomendable' then
      formMenuCompras.ComboBoxCalificacion.ItemIndex:= 3;

    if stringgridCompras.Cells[5, stringgridCompras.Row]='Sin calificar' then
      formMenuCompras.ComboBoxCalificacion.ItemIndex:= 0;

    if stringgridCompras.Cells[5, stringgridCompras.Row]<>'Sin calificar' then
    begin
      formMenuCompras.ComboBoxCalificacion.Enabled:= false;
      formMenuCompras.btnCalificar.Enabled:= false;
    end
    else
    begin
      formMenuCompras.ComboBoxCalificacion.Enabled:= true;
      formMenuCompras.btnCalificar.Enabled:= false;
    end;

    if stringgridCompras.Cells[6, stringgridCompras.Row]='Pagado' then
      formMenuCompras.btnPagar.Enabled:= false
    else
      formMenuCompras.btnPagar.Enabled:= true;
  end;
end;
end.
