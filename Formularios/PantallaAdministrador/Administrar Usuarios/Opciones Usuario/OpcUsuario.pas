unit OpcUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MEUsuario, Login, MEArticulosPublicados, MEVentas, TiposYconstantes, TDAColasParcialesV;

type
  TformOpcionesUsuario = class(TForm)
    btnBloquear: TButton;
    btnDesbloquear: TButton;
    labelMail: TLabel;
    btnCompras: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBloquearClick(Sender: TObject);
    procedure btnDesbloquearClick(Sender: TObject);
    procedure btnComprasClick(Sender: TObject);
  private
    procedure cargarMisCompras(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; idUsuario: integer; var contador: integer);
  public
    { Public declarations }
  end;

var
  formOpcionesUsuario: TformOpcionesUsuario;

implementation

uses AdmUsuario, Administrador, ComprasUsu;

{$R *.dfm}

procedure TformOpcionesUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  formAdmUsuarios.Enabled:= true;
  formOpcionesUsuario.hide;
end;

procedure TformOpcionesUsuario.btnBloquearClick(Sender: TObject);
var
  pos: integer;
  reg: MEUsuario.tiporegListaDatosHash;
begin
MEUsuario.AbrirMe(usuario);
MEUsuario.Buscar(Usuario, labelMail.Caption, pos);
MEUsuario.CapturarInfo(Usuario, reg, pos);
reg.bloqueado:= true;
MEUsuario.modificar(Usuario, reg, pos);
MEUsuario.CerrarMe(Usuario);

formOpcionesUsuario.Hide;
formAdmUsuarios.Enabled:= true;
formAdministrador.cargarStringGridUsuarios(1);
end;

procedure TformOpcionesUsuario.btnDesbloquearClick(Sender: TObject);
var
  pos: integer;
  reg: MEUsuario.tiporegListaDatosHash;
begin
MEUsuario.AbrirMe(usuario);
MEUsuario.Buscar(Usuario, labelMail.Caption, pos);
MEUsuario.CapturarInfo(Usuario, reg, pos);
reg.bloqueado:= false;
MEUsuario.modificar(Usuario, reg, pos);
MEUsuario.CerrarMe(Usuario);

formOpcionesUsuario.Hide;
formAdmUsuarios.Enabled:= true;
formAdministrador.cargarStringGridUsuarios(1);

end;
procedure TformOpcionesUsuario.btnComprasClick(Sender: TObject);
var
  cont, idUsuario, cont1, contador, posPri: integer;
  reg: MEUsuario.tiporeglistadatoshash;
begin
formComprasAdmin.show;
formOpcionesUsuario.Close;
formAdmUsuarios.Hide;

// ============================================================================= Limpiar tabla
  for cont :=0 to formComprasAdmin.stringgridCompras.colcount-1 do
    for cont1 :=0 to formComprasAdmin.stringgridCompras.rowcount-1 do
      formComprasAdmin.stringgridCompras.Cells[cont,cont1] := '';

//============================================================================== Cabecera publicados
  formComprasAdmin.stringgridCompras.Cells[0, 0]:= 'Titulo';
  formComprasAdmin.stringgridCompras.Cells[1, 0]:= 'Fecha Compra';
  formComprasAdmin.stringgridCompras.Cells[2, 0]:= 'Vendedor';
  formComprasAdmin.stringgridCompras.Cells[3, 0]:= 'Importe';
  formComprasAdmin.stringgridCompras.Cells[4, 0]:= 'Calificacion';
  formComprasAdmin.stringgridCompras.Cells[5, 0]:= '-Pagado';

//============================================================================== Cargar Cuerpo
  //Obtener ID usuario
  MEUsuario.AbrirMe(Usuario);
  MEUsuario.Buscar(Usuario, formOpcionesUsuario.labelMail.Caption, posPri);
  MEUsuario.CapturarInfo(Usuario, reg, posPri);
  idUsuario:= reg.IDUsuario;
  MEUsuario.CerrarMe(Usuario);

  contador:=1;
  MEArticulosPublicados.abrir(Publicado);
  cargarMisCompras(Publicado, MEArticulosPublicados.raizCategoria(Publicado), idUsuario, contador);
  MEArticulosPublicados.cerrar(Publicado);
end;

procedure TformOpcionesUsuario.cargarMisCompras(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; idUsuario: integer; var contador: integer);
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;
  reg: MEUsuario.tiporegListaDatosHash;
  posPri, posSeg :integer;
  corte: boolean;
  regNulo, regVenDat:MEVentas.tiporegDatos;
  regVenInd: MEVentas.tipoRegIndice;
  calificacion: string;
begin
  If pos<>MEArticulosPublicados.posNula(Arbol) then
  begin
    MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);

    if (regDatos.estadoPublicacion = 3) and (regDatos.IDcomprador=idUsuario) then
  // =========================================================================== Cargar Cuerpo
        begin
          formComprasAdmin.stringgridCompras.Cells[0, contador]:= regDatos.Clave+' - '+regDatos.NombreArticulo;
          formComprasAdmin.stringgridCompras.Cells[1, contador]:= datetimetostr(regDatos.fechacierre);

          //Obtener VENDEDOR
          MEUsuario.AbrirMe(Usuario);
          posPri:= MEUsuario.primeroListaDoble(Usuario);
          while (posPri<>MEUsuario._posnula) do
          begin
            posSeg:= MEUsuario.primeroListaDobleParciales(Usuario, posPri);
            While (posSeg<>MEUsuario._posnula) do
            begin
              MEUsuario.CapturarInfo(Usuario, reg, posSeg);
              if (reg.IDUsuario=regDatos.IDVendedor) then
              begin
                formComprasAdmin.stringgridCompras.Cells[2, contador]:= reg.nombre;
              end;
            posSeg:= MEUsuario.proximoListaDobleParciales(Usuario, posSeg, reg);
            end;
            posPri:= MEUsuario.proximoListaDoble(Usuario, posPri);
          end;
          MEUsuario.CerrarMe(Usuario);

          formComprasAdmin.stringgridCompras.Cells[3, contador]:= floattostr(regDatos.precio);

          //obtener Calificacion
          MEVentas.abrir(Venta);
          if MEVentas.buscar(Venta, idUsuario, posPri) then
          begin
          corte:= false;
          regNulo.clave:= -1;
          regNulo.siguiente:= -1;
          regVenInd:= MEVentas.obtenerIndice(Venta, posPri);
          TDAColasParcialesV.Encolar(Venta, regNulo, regVenInd, posPri);
          while not corte do
          begin
            TDAColasParcialesV.Frente(Venta, regVenDat, regVenInd);
            TDAColasParcialesV.Decolar(Venta, regVenInd, posPri);
            if regVenDat.clave<>-1 then
            begin
              if (strtoint(regDatos.Clave)=regVenDat.Clave) then
              begin
                case (regVenDat.calificacion) of
                 0: calificacion:='Sin calificar';
                 1: calificacion:='Recomendable';
                 2: calificacion:='Neutral';
                 3: calificacion:='No Recomendable';
                end;//Case

                if regVenDat.comisionCobrada then
                  formComprasAdmin.stringgridCompras.Cells[5, contador]:= 'Pagado'
                else
                  formComprasAdmin.stringgridCompras.Cells[5, contador]:= 'No Pagado';
              end;//if

              TDAColasParcialesV.Encolar(Venta, regVenDat, regVenInd, posPri);
            end
            else
              corte:=true;
          end; //While-corte
          end; // Conversacion Encontrada
          MEVentas.cerrar(Venta);

          formComprasAdmin.stringgridCompras.Cells[4, contador]:= calificacion; //0=Sin calificar aún; 1=Recomendable; 2=Neutral; 3=No recomendable;

          contador:= contador +1;
          formComprasAdmin.stringgridCompras.RowCount:= contador;
        end;

    cargarMisCompras(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), idUsuario, contador);
    cargarMisCompras(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), idUsuario, contador);
  end;

end;

end.
