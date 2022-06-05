unit Publicaciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Grids, MEArticulosPublicados, MECategorias,
  Buttons;

type
  TformPublicaciones = class(TForm)
    StringGridPublicaciones: TStringGrid;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    btnSalir: TMenuItem;
    btnAyuda: TBitBtn;
    Label2: TLabel;
    procedure btnSalirClick(Sender: TObject);
    procedure StringGridPublicacionesDblClick(Sender: TObject);
    procedure StringGridPublicacionesDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure btnAyudaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formPublicaciones: TformPublicaciones;

implementation

uses PantallaUsuario, Login, PublicacionSeleccionada, Menu;

{$R *.dfm}

procedure TformPublicaciones.btnSalirClick(Sender: TObject);
begin
  formPublicaciones.Close;
  formUsuario.show;
  formLogin.cargarPublicacionesInicio();
end;

procedure TformPublicaciones.StringGridPublicacionesDblClick(Sender: TObject);
var
  Cur : TPoint;
  x, y, pos:integer;
begin
  GetCursorPos(Cur);
  formMenuUsuario.Left:= cur.x;
  formMenuUsuario.Top:= cur.Y;

  if not (trim(formPublicaciones.StringGridPublicaciones.Cells[0, 1])='') then  // Compruebo que haya al menos UN REGISTRO
  begin

    if (StringGridPublicaciones.Cells[4, StringGridPublicaciones.Row]='Publicado') then
      begin
        formMenuUsuario.btnActivar.Enabled:= true;
        formMenuUsuario.btnPausar.Enabled:= true;
        formMenuUsuario.btnPausar.Visible:= true;
        formMenuUsuario.btnActivar.Visible:= false;
      end;

    if (StringGridPublicaciones.Cells[4, StringGridPublicaciones.Row]='Pausado') then
      begin
        formMenuUsuario.btnActivar.Enabled:= true;
        formMenuUsuario.btnPausar.Enabled:= true;
        formMenuUsuario.btnPausar.Visible:= false;
        formMenuUsuario.btnActivar.Visible:= true;
      end;


    if (StringGridPublicaciones.Cells[4, StringGridPublicaciones.Row]='Anulado') or  (StringGridPublicaciones.Cells[4, StringGridPublicaciones.Row]='Vendido') or (StringGridPublicaciones.Cells[4, StringGridPublicaciones.Row]='Bloqueado') then
      begin
        formMenuUsuario.btnActivar.Enabled:= false;
        formMenuUsuario.btnPausar.Visible:= true;
        formMenuUsuario.btnPausar.Enabled:= false;
        formMenuUsuario.btnActivar.Visible:= false;
      end;


  formMenuUsuario.show;
  formMenuUsuario.labelCodigo.Caption:= StringGridPublicaciones.Cells[0, StringGridPublicaciones.Row];
  formMenuUsuario.labelEstado.Caption:= StringGridPublicaciones.Cells[4, StringGridPublicaciones.Row];
  formPublicaciones.Enabled:= false;
  end;
end;

procedure TformPublicaciones.StringGridPublicacionesDrawCell(
  Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
with Sender as TStringGrid do
  if cells[ACol, ARow] = 'Publicado' then
  begin
    Canvas.Brush.Color:= clGreen;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, Cells[Acol, ARow]);
  end
  else
  if cells[ACol, ARow] = 'Bloqueado' then
  begin
    Canvas.Brush.Color:= clred;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, Cells[Acol, ARow]);
  end
  else
  if cells[ACol, ARow] = 'Pausado' then
  begin
    Canvas.Brush.Color:= clYellow;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, Cells[Acol, ARow]);
  end
  else
  if cells[ACol, ARow] = 'Anulado' then
  begin
    Canvas.Brush.Color:= clPurple;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, Cells[Acol, ARow]);
  end
  else
  if cells[ACol, ARow] = 'Vendido' then
  begin
    Canvas.Brush.Color:= clBlue;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, Cells[Acol, ARow]);
  end
end;

procedure TformPublicaciones.btnAyudaClick(Sender: TObject);
begin
  messagedlg('*Doble Click* para desplegar'+#13+
              'opciones sobre el  registro'+#13+
              'seleccionado.'+#13+ #13+
            '------------ COLORES ------------'+#13+
            'VERDE: publicado.'+#13+
            'ROJO: bloqueado.'+#13+
            'AMARILLO: pausado.'+#13+
            'PURPURA: anulado.'+#13+
            'AZUL: vendido.'+#13+ #13+
            '------------ ADVERTENCIA ------------'+#13+
            'No se puede eliminar/modificar'+#13+
            'publicaciones bloqueadas/anuladas/pausadas.', mtInformation, [mbOk], 0)
end;

end.
