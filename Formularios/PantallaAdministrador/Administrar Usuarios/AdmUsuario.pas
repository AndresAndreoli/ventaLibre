unit AdmUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, MEUsuario, Login, Buttons;

type
  TformAdmUsuarios = class(TForm)
    MainMenu1: TMainMenu;
    btnSalir: TMenuItem;
    Label1: TLabel;
    StringGridUsuarios: TStringGrid;
    GroupBox1: TGroupBox;
    ComboBoxListar: TComboBox;
    Label2: TLabel;
    btnAyuda: TBitBtn;
    procedure btnSalirClick(Sender: TObject);
    procedure StringGridUsuariosDblClick(Sender: TObject);
    procedure StringGridUsuariosDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure ComboBoxListarCloseUp(Sender: TObject);
    procedure btnAyudaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAdmUsuarios: TformAdmUsuarios;

implementation

uses Administrador, OpcUsuario;

{$R *.dfm}

procedure TformAdmUsuarios.btnSalirClick(Sender: TObject);
begin
  formAdmUsuarios.close;
  formAdministrador.show;
end;

procedure TformAdmUsuarios.StringGridUsuariosDblClick(Sender: TObject);
var
  Cur : TPoint;
  x, y, pos:integer;
  clave: string;
  reg: MEUsuario.tiporegListaDatosHash;
begin
  if not (StringGridUsuarios.Cells[0, 1]='') and not (StringGridUsuarios.Cells[0, StringGridUsuarios.Row]='ID')   then begin
    formOpcionesUsuario.show;
    formAdmUsuarios.Enabled:= false;
    GetCursorPos(Cur);
    formOpcionesUsuario.Left:= cur.x;
    formOpcionesUsuario.Top:= cur.Y;
    clave:= StringGridUsuarios.Cells[2, StringGridUsuarios.Row];
    MEUsuario.AbrirMe(Usuario);
    MEUsuario.Buscar(Usuario, clave, pos);
    MEUsuario.CapturarInfo(Usuario, reg, pos);
    if reg.bloqueado then
    begin
      formOpcionesUsuario.btnBloquear.Visible:= false;
      formOpcionesUsuario.btnDesbloquear.Visible:= true;
    end
    else
    begin
      formOpcionesUsuario.btnBloquear.Visible:= true;
      formOpcionesUsuario.btnDesbloquear.Visible:= false;
      reg.estado:= false;
      MEUsuario.modificar(Usuario,reg,pos);
    end ;

    formOpcionesUsuario.labelMail.Caption:= reg.Clave;
    MEUsuario.CerrarMe(Usuario);
  end;// IF tabla VACIA
end;

procedure TformAdmUsuarios.StringGridUsuariosDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
with Sender as TStringGrid do
  if (cells[ACol, ARow] = 'Desconectado') or (cells[ACol, ARow] = 'Bloqueado') then
  begin
    Canvas.Brush.Color:= clRed;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, Cells[Acol, ARow]);
  end
  else
  if (cells[ACol, ARow] = 'Conectado') or (cells[ACol, ARow] = 'Desbloqueado') then
  begin
    Canvas.Brush.Color:= clGreen;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect, Rect.Left + 2, rect.Top + 2, Cells[Acol, ARow]);
  end
end;

procedure TformAdmUsuarios.ComboBoxListarCloseUp(Sender: TObject);
begin
  if comboboxlistar.ItemIndex=2 then
    formAdministrador.cargarStringGridUsuarios(2) // bloqueado
  else if (comboboxlistar.ItemIndex=0) then
    formAdministrador.cargarStringGridUsuarios(1) // todos
  else if (comboboxlistar.ItemIndex=1) then
    formAdministrador.cargarStringGridUsuarios(0); //mas vendido
end;

procedure TformAdmUsuarios.btnAyudaClick(Sender: TObject);
begin
messagedlg('*Doble Click* sobre un registro'+#13+
            'para desplegar opciones sobre el'+#13+
            'mismo.', mtInformation, [mbOk], 0);
end;

end.
