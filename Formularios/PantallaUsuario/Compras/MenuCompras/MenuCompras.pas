unit MenuCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TDAColasParcialesV, MEVentas, Login, MEArticulosPublicados;

type
  TformMenuCompras = class(TForm)
    ComboBoxCalificacion: TComboBox;
    btnCalificar: TButton;
    btnPagar: TButton;
    labelIDPub: TLabel;
    labelIDUsuario: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBoxCalificacionCloseUp(Sender: TObject);
    procedure btnCalificarClick(Sender: TObject);
    procedure btnPagarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMenuCompras: TformMenuCompras;

implementation

uses Compras, PantallaUsuario;

{$R *.dfm}

procedure TformMenuCompras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  formMenuCompras.hide;
  formMisCompras.show;
  formMiscompras.enabled:= true;
end;

procedure TformMenuCompras.ComboBoxCalificacionCloseUp(Sender: TObject);
begin
  if (comboboxCalificacion.itemIndex=0) then
    btnCalificar.Enabled:= false
  else
    btnCalificar.Enabled:= true;
end;

procedure TformMenuCompras.btnCalificarClick(Sender: TObject);
var
  pos, contador: integer;
  regVenInd: MEVentas.TipoRegIndice;
  regVenDat, regNulo: MEVentas.TipoRegDatos;
  corte: boolean;
  regCatInd: MEArticulosPublicados.tipoRegIndice;
  regCatDat: MEArticulosPublicados.tipoRegDatos;
begin

  MEArticulosPublicados.abrir(Publicado);
  MEArticulosPublicados.buscarCategorias(Publicado, labelIDPub.Caption, pos);
  MEArticulosPublicados.capturarCategorias(Publicado, pos, regCatInd);
  MEARticulosPublicados.capturarArticulo(Publicado, regCatInd, regCatDat);
  MEArticulosPublicados.cerrar(Publicado);

  corte:= false;
  MEVentas.abrir(Venta);
  if MEVentas.buscar(Venta, strtoint(labelIDUsuario.caption), pos) then
  begin
  corte:= false;
  regNulo.clave:= -1;
  regNulo.siguiente:= -1;
  regVenInd:= MEVentas.obtenerIndice(Venta, pos);
  TDAColasParcialesV.Encolar(Venta, regNulo, regVenInd, pos);
  while not corte do
  begin
    TDAColasParcialesV.Frente(Venta, regVenDat, regVenInd);
    TDAColasParcialesV.Decolar(Venta, regVenInd, pos);
    if regVenDat.clave<>-1 then
    begin
      //showmessage(inttostr(regVenDat.clave)+' '+(regCatDat.clave));
      if (regVenDat.Clave=strtoint(regCatdat.Clave)) then
      begin
        regVenDat.calificacion:= comboboxcalificacion.itemindex; // AGREGO LA CALIFICACION A LA COMPRA
      end;
      TDAColasParcialesV.Encolar(Venta, regVenDat, regVenInd, pos);
    end
    else
      corte:=true;
  end; //While-corte
  end; // Conversacion Encontrada
  MEVentas.cerrar(Venta);

  formMenuCompras.hide;
  formMisCompras.show;
  formMiscompras.enabled:= true;

  MEArticulosPublicados.abrir(Publicado);
  contador:=1;
  formusuario.cargarMisCompras(Publicado, MEArticulosPublicados.raizCategoria(Publicado), strtoint(labelIDUsuario.caption), contador);
  MEArticulosPublicados.cerrar(Publicado);

  comboboxCalificacion.ItemIndex:=0;
end;

procedure TformMenuCompras.btnPagarClick(Sender: TObject);
var
  pos, contador: integer;
  regVenInd: MEVentas.TipoRegIndice;
  regVenDat, regNulo: MEVentas.TipoRegDatos;
  corte: boolean;
  regCatInd: MEArticulosPublicados.tipoRegIndice;
  regCatDat: MEArticulosPublicados.tipoRegDatos;
begin
if messagedlg('Desea realizar el pago?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) = mrYes then
begin
  MEArticulosPublicados.abrir(Publicado);
  MEArticulosPublicados.buscarCategorias(Publicado, labelIDPub.Caption, pos);
  MEArticulosPublicados.capturarCategorias(Publicado, pos, regCatInd);
  MEARticulosPublicados.capturarArticulo(Publicado, regCatInd, regCatDat);
  MEArticulosPublicados.cerrar(Publicado);

  corte:= false;
  MEVentas.abrir(Venta);
  if MEVentas.buscar(Venta, strtoint(labelIDUsuario.caption), pos) then
  begin
  corte:= false;
  regNulo.clave:= -1;
  regNulo.siguiente:= -1;
  regVenInd:= MEVentas.obtenerIndice(Venta, pos);
  TDAColasParcialesV.Encolar(Venta, regNulo, regVenInd, pos);
  while not corte do
  begin
    TDAColasParcialesV.Frente(Venta, regVenDat, regVenInd);
    TDAColasParcialesV.Decolar(Venta, regVenInd, pos);
    if regVenDat.clave<>-1 then
    begin
      if (regVenDat.Clave=strtoint(regCatDat.Clave)) then
      begin
        regVenDat.comisionCobrada:= true;  // ACTUALIZO EL PAGO DE LA COMISION
      end;
      TDAColasParcialesV.Encolar(Venta, regVenDat, regVenInd, pos);
    end
    else
      corte:=true;
  end; //While-corte
  end; // Conversacion Encontrada
  MEVentas.cerrar(Venta);

  formMenuCompras.hide;
  formMisCompras.show;
  formMiscompras.enabled:= true;

  MEArticulosPublicados.abrir(Publicado);
  contador:=1;
  formusuario.cargarMisCompras(Publicado, MEArticulosPublicados.raizCategoria(Publicado), strtoint(labelIDUsuario.caption), contador);
  MEArticulosPublicados.cerrar(Publicado);
end;
end;

end.
