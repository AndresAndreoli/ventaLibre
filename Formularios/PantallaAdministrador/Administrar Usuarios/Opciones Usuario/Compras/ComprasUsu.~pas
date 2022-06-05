unit ComprasUsu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Menus;

type
  TformComprasAdmin = class(TForm)
    StringGridCompras: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    procedure Salir1Click(Sender: TObject);
    procedure StringGridComprasDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formComprasAdmin: TformComprasAdmin;

implementation

uses AdmUsuario;

{$R *.dfm}

procedure TformComprasAdmin.Salir1Click(Sender: TObject);
begin
  formComprasAdmin.Close;
  formAdmUsuarios.show;
end;

procedure TformComprasAdmin.StringGridComprasDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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

end.
