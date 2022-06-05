unit crearCategorias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, MECategorias, Categorias;

type
  TformCrearCategoria = class(TForm)
    Label1: TLabel;
    labelNombreRubro: TLabel;
    labelComision: TLabel;
    editNombreRubro: TEdit;
    Label2: TLabel;
    editComision: TMaskEdit;
    btnCrear: TButton;
    btnVolver: TButton;
    procedure btnVolverClick(Sender: TObject);
    procedure btnCrearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formCrearCategoria: TformCrearCategoria;

implementation

uses Administrador;

{$R *.dfm}

procedure TformCrearCategoria.btnVolverClick(Sender: TObject);
begin
  editNombreRubro.Text:= '';
  editComision.Text:='';
  formCrearCategoria.Close;
  formCategorias.show;
end;

procedure TformCrearCategoria.btnCrearClick(Sender: TObject);
var
  reg, regAux: MECategorias.TipoRegDatos;
  pos: integer;
begin
if (editNombreRubro.Text='') or (trim(editComision.Text)='') then
  showmessage('Complete todos los campos')
else
  if Dialogs.MessageDlg('Deseas dar de alta la categoria?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    MECategorias.AbrirMe(Categoria);
    MECategorias.Buscar(Categoria, MECategorias.UltimoID(Categoria), pos);
    reg.Clave:= MECategorias.UltimoID(Categoria);
    reg.categoria:= editNombreRubro.Text;
    reg.comision:= strtoint(trim(editComision.Text));
    MECategorias.Insertar(Categoria, pos, reg);
    MECategorias.CerrarMe(Categoria);
    showmessage('Categoria creada correctamente.');
    editNombreRubro.Text:= '';
    editComision.Text:='';
    formCrearCategoria.Close;
    formAdministrador.btnCategorias.Click;
  end;
end;

end.
