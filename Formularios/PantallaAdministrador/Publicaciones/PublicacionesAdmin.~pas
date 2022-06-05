unit PublicacionesAdmin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Menus, ComCtrls, MEArticulosPublicados, TiposYconstantes, Login, MECategorias, MEUsuario, MEVentas, TDAColasParcialesV;

type
  TformPublicacionesAdmin = class(TForm)
    Label1: TLabel;
    StringGridPublicaciones: TStringGrid;
    MainMenu1: TMainMenu;
    btnSalir: TMenuItem;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    ComboBoxUsuarios: TComboBox;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    fechaDesde: TDateTimePicker;
    Label4: TLabel;
    fechaHasta: TDateTimePicker;
    Label5: TLabel;
    btnRealizadas: TButton;
    btnCaducadas: TButton;
    btnConversacion: TButton;
    procedure btnSalirClick(Sender: TObject);
    procedure StringGridPublicacionesDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridPublicacionesDblClick(Sender: TObject);
    procedure ComboBoxUsuariosCloseUp(Sender: TObject);
    procedure btnRealizadasClick(Sender: TObject);
    procedure btnCaducadasClick(Sender: TObject);
    procedure btnConversacionClick(Sender: TObject);
  private
  public
    procedure recorrer(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; var contador: integer; var vectorArticulos: array of MEArticulosPublicados.tipoRegDatos);

    procedure filtrar(fechaDesde, fechaHasta: tdatetime; tipo: integer; categoriaID: integer);
  end;

var
  formPublicacionesAdmin: TformPublicacionesAdmin;
  vectorArticulos: array of MEArticulosPublicados.tipoRegDatos;

implementation

uses Administrador, Menu, MenuPublicidad, Publicaciones, Listado,
  ConversacionesAdmin, AdmUsuario;

{$R *.dfm}

procedure TformPublicacionesAdmin.btnSalirClick(Sender: TObject);
begin
  formAdministrador.show;
  formPublicacionesAdmin.Close;
end;

procedure TformPublicacionesAdmin.StringGridPublicacionesDrawCell(
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

procedure TformPublicacionesAdmin.StringGridPublicacionesDblClick(
  Sender: TObject);
var
  Cur : TPoint;
  x, y, pos:integer;
begin
  GetCursorPos(Cur);
  formMenuAdmPublicaciones.top:= cur.Y;
  formMenuAdmPublicaciones.left:= cur.X;
  formMenuAdmPublicaciones.labelCodigo.Caption := formPublicacionesAdmin.StringGridPublicaciones.Cells[0, StringGridPublicaciones.Row];
  
  if not (trim(formPublicacionesAdmin.StringGridPublicaciones.Cells[0, 1])='') then
  begin
      if (formPublicacionesAdmin.StringGridPublicaciones.Cells[8, StringGridPublicaciones.Row]='Vendido') or (formPublicacionesAdmin.StringGridPublicaciones.Cells[8, StringGridPublicaciones.Row]='Anulado') then
        begin
          formMenuAdmPublicaciones.btnBloquear.enabled:= false;
          formMenuAdmPublicaciones.btnBloquear.visible:= true;
          formMenuAdmPublicaciones.btnDesbloquear.visible:= false;
        end else

      if (formPublicacionesAdmin.StringGridPublicaciones.Cells[8, StringGridPublicaciones.Row]='Bloqueado') then
      begin
        formMenuAdmPublicaciones.btnBloquear.enabled:= true;
        formMenuAdmPublicaciones.btnBloquear.visible:= false;
        formMenuAdmPublicaciones.btnDesbloquear.visible:= true;
      end else

      if (formPublicacionesAdmin.StringGridPublicaciones.Cells[8, StringGridPublicaciones.Row]='Publicado') or (formPublicacionesAdmin.StringGridPublicaciones.Cells[8, StringGridPublicaciones.Row]='Pausado') then
      begin
        formMenuAdmPublicaciones.btnBloquear.enabled:= true;
        formMenuAdmPublicaciones.btnBloquear.visible:= true;
        formMenuAdmPublicaciones.btnDesbloquear.visible:= false;
      end;
    formMenuAdmPublicaciones.show;
    formPublicacionesAdmin.Enabled:= false;
  end;
end;

procedure TformPublicacionesAdmin.ComboBoxUsuariosCloseUp(Sender: TObject);
begin
  if (comboboxUsuarios.ItemIndex=0) then
  formAdministrador.cargarPublicacionesAdmin(false, 1)
  else
  formAdministrador.cargarPublicacionesAdmin(true, 1);
end;

procedure TformPublicacionesAdmin.btnRealizadasClick(Sender: TObject);
var
 contador, posPri, posSeg: integer;
 reg: MEUsuario.tiporeglistadatoshash;
begin
if (fechaDesde.DateTime>fechaHasta.DateTime) then
  showmessage('La fecha DESDE tiene que ser menor que la fecha HASTA.')
else
begin
  formListadoPublicaciones.labelCobrada.Visible:= true;
  formListadoPublicaciones.labelTotal.Visible:= true;
  formListadoPublicaciones.editTotal.Visible:= true;
  formListadoPublicaciones.editCobrada.Visible:= true;

  formPublicacionesAdmin.close;
  formListadoPublicaciones.show;

  formListadoPublicaciones.StringGridVentas.Visible:= true;
  formListadoPublicaciones.StringGridCaducado.Visible:= false;
  formListadoPublicaciones.GroupBox1.Visible:= false;
  formListadoPublicaciones.labelRealizadas.Visible:= true;
  formListadoPublicaciones.labelCaducadas.Visible:= false;

  formListadoPublicaciones.GroupBoxCalificacion.Visible:= true;
  formListadoPublicaciones.ComboBoxCalificacion.ItemIndex:=0;


  SetLength(vectorArticulos, strtoint(formListadoPublicaciones.labelRow.caption)-1);

  contador:= 0;
  MEArticulosPublicados.abrir(Publicado);
  recorrer(Publicado, MEArticulosPublicados.raizCategoria(Publicado), contador, vectorArticulos);
  MEArticulosPublicados.cerrar(Publicado);

  filtrar(formPublicacionesAdmin.fechaDesde.DateTime, formPublicacionesAdmin.fechaHasta.DateTime, 1, 999999999); // 1 -> Ventas, 999999999 -> Todas
  formListadoPublicaciones.CheckBoxEstro.Checked:= true;
end;
end; // btnRealizadasClick

//Filtrado
procedure TformPublicacionesAdmin.filtrar(fechaDesde, fechaHasta: tdatetime;
tipo: integer; categoriaID: integer); {tipo = 1 -> vendidos, tipo = 2 -> caducado}
var
  i, contador, pos, cont, cont1: integer;
  corte, calificacion: boolean;
  regNulo,  regVenDat: MEVentas.tipoRegDatos;
  regVenInd: MEVentas.tipoRegIndice;
  comisionCobrada, comisionTotal: real;
  reg: MEUsuario.tiporeglistadatoshash;

begin

// ============================================================================ Limpiar tabla
  for cont :=0 to formListadoPublicaciones.StringGridVentas.colcount-1 do
    for cont1 :=0 to formListadoPublicaciones.StringGridVentas.rowcount-1 do
      formListadoPublicaciones.StringGridVentas.Cells[cont,cont1] := '';

// =========================================================================== Cargar Cabecera
  formListadoPublicaciones.StringGridVentas.Cells[0, 0]:= 'Comprador';
  formListadoPublicaciones.StringGridVentas.Cells[1, 0]:= 'Vendedor';
  formListadoPublicaciones.StringGridVentas.Cells[2, 0]:= 'Articulo';
  formListadoPublicaciones.StringGridVentas.Cells[3, 0]:= 'Fecha Venta';
  formListadoPublicaciones.StringGridVentas.Cells[4, 0]:= 'Importe';
  formListadoPublicaciones.StringGridVentas.Cells[5, 0]:= 'Cobrado';
  formListadoPublicaciones.StringGridVentas.Cells[6, 0]:= 'Comision';

  formListadoPublicaciones.StringGridVentas.ColWidths[0]:=179;
  formListadoPublicaciones.StringGridVentas.ColWidths[1]:=179;
  formListadoPublicaciones.StringGridVentas.ColWidths[3]:=185;
  formListadoPublicaciones.StringGridVentas.ColWidths[4]:=78;
  formListadoPublicaciones.StringGridVentas.ColWidths[5]:=85;
  formListadoPublicaciones.StringGridVentas.ColWidths[6]:=85;

comisionCobrada:= 0;
comisionTotal:= 0;
contador:= 1;
  if (tipo=2) then
  begin 
  for i:=0 to length(vectorArticulos)-1 do
  begin
    if(vectorArticulos[i].estadoPublicacion=4) then
      if (vectorArticulos[i].fechapublicacion>fechaDesde) and (vectorArticulos[i].fechapublicacion<fechaHasta) then
      begin
          if (categoriaID=999999999) then  // 999999999 -> mostrar todas todos los art.
          begin
            formListadoPublicaciones.StringGridCaducado.Cells[0, contador]:= 'Vendedor';
            formListadoPublicaciones.StringGridCaducado.Cells[1, contador]:= vectorArticulos[i].NombreArticulo;
            formListadoPublicaciones.StringGridCaducado.Cells[2, contador]:= floattostr(vectorArticulos[i].precio);
            formListadoPublicaciones.StringGridCaducado.Cells[3, contador]:= datetimetostr(vectorArticulos[i].fechapublicacion);
            formListadoPublicaciones.StringGridCaducado.Cells[4, contador]:= datetimetostr(vectorArticulos[i].fechacierre);
            contador:= contador+1;
            formListadoPublicaciones.StringGridCaducado.RowCount:= contador;
          end
          else if (categoriaID=vectorArticulos[i].IDCategoria) then
          begin
            formListadoPublicaciones.StringGridCaducado.Cells[0, contador]:= 'Vendedor';
            formListadoPublicaciones.StringGridCaducado.Cells[1, contador]:= vectorArticulos[i].NombreArticulo;
            formListadoPublicaciones.StringGridCaducado.Cells[2, contador]:= floattostr(vectorArticulos[i].precio);
            formListadoPublicaciones.StringGridCaducado.Cells[3, contador]:= datetimetostr(vectorArticulos[i].fechapublicacion);
            formListadoPublicaciones.StringGridCaducado.Cells[4, contador]:= datetimetostr(vectorArticulos[i].fechacierre);
            contador:= contador+1;
            formListadoPublicaciones.StringGridCaducado.RowCount:= contador;
          end;
      end;
  end;// For
  end //Tipo 2
  else if (tipo=1) then
  begin
    for i:=0 to length(vectorArticulos)-1 do
    begin
      if(vectorArticulos[i].estadoPublicacion=3) then
        if (vectorArticulos[i].fechacierre>fechaDesde) and (vectorArticulos[i].fechacierre<fechaHasta) then
        begin
          if not formListadoPublicaciones.CheckBoxEstro.Checked then
          begin
              formListadoPublicaciones.StringGridVentas.Cells[0, contador]:= vectorArticulos[i].mailComprador;
              formListadoPublicaciones.StringGridVentas.Cells[1, contador]:= vectorArticulos[i].mailVendedor;
              formListadoPublicaciones.StringGridVentas.Cells[2, contador]:= vectorArticulos[i].NombreArticulo;
              formListadoPublicaciones.StringGridVentas.Cells[3, contador]:= datetimetostr(vectorArticulos[i].fechacierre);
              formListadoPublicaciones.StringGridVentas.Cells[4, contador]:= floattostr(vectorArticulos[i].precio);

              MEVentas.abrir(Venta);
              if MEVentas.buscar(Venta, vectorArticulos[i].IDcomprador, pos) then
              begin
              corte:= false;
              regNulo.clave:= -1;
              regNulo.siguiente:= -1;
              regVenInd:= MEVEntas.obtenerIndice(Venta, pos);
              TDAColasParcialesV.Encolar(Venta, regNulo, regVenInd, pos);
              while not corte do
              begin
                TDAColasParcialesV.Frente(Venta, regVenDat, regVenInd);
                TDAColasParcialesV.Decolar(Venta, regVenInd, pos);
                if regVenDat.clave<>-1 then
                begin
                  if (regVenDat.Clave=strtoint(vectorArticulos[i].Clave)) then
                  begin
                    if regVenDat.comisionCobrada then
                    begin
                      formListadoPublicaciones.StringGridVentas.Cells[5, contador]:= (formatfloat('0.00', (regVenDat.precioVenta*regVenDat.porcentajeComision/100)));
                      comisionCobrada:= comisionCobrada + strtofloat(formatfloat('0.00', (regVenDat.precioVenta*regVenDat.porcentajeComision/100)));
                    end
                    else
                      formListadoPublicaciones.StringGridVentas.Cells[5, contador]:= 'No';
                    comisionTotal:= comisionTotal + strtofloat(formatfloat('0.00', (regVenDat.precioVenta*regVenDat.porcentajeComision/100)));

                    formListadoPublicaciones.StringGridVentas.Cells[6, contador]:= inttostr(regVenDat.porcentajeComision)+' %';
                  end;
                  TDAColasParcialesV.Encolar(Venta, regVenDat, regVenInd, pos);
                end
                else
                  corte:=true;
              end; //While-corte
              end; // Conversacion Encontrada
              MEVentas.cerrar(Venta);

              contador:= contador+1;
              formListadoPublicaciones.StringGridVentas.RowCount:= contador;
          end // CheckBoxentro = false
          else begin
          //---------------------------------------------------------------------- CHECKEAR LA CALIFICACION
          calificacion:= false;
          MEVentas.abrir(Venta);
          if MEVentas.buscar(Venta, vectorArticulos[i].IDcomprador, pos) then
          begin
          corte:= false;
          regNulo.clave:= -1;
          regNulo.siguiente:= -1;
          regVenInd:= MEVEntas.obtenerIndice(Venta, pos);
          TDAColasParcialesV.Encolar(Venta, regNulo, regVenInd, pos);
          while not corte do
          begin
            TDAColasParcialesV.Frente(Venta, regVenDat, regVenInd);
            TDAColasParcialesV.Decolar(Venta, regVenInd, pos);
            if regVenDat.clave<>-1 then
            begin
              //showmessage(inttostr(regVenDat.calificacion)+' '+inttostr(formlistadoPublicaciones.ComboBoxCalificacion.ItemIndex-1));
              if (regVenDat.Clave=strtoint(vectorArticulos[i].Clave)) and (regVenDat.calificacion=formlistadoPublicaciones.ComboBoxCalificacion.ItemIndex-1) then
              begin
                if regVenDat.comisionCobrada then
                begin
                  formListadoPublicaciones.StringGridVentas.Cells[5, contador]:= (formatfloat('0.00', (regVenDat.precioVenta*regVenDat.porcentajeComision/100)));
                  comisionCobrada:= comisionCobrada + strtofloat(formatfloat('0.00', (regVenDat.precioVenta*regVenDat.porcentajeComision/100)));
                end
                else
                  formListadoPublicaciones.StringGridVentas.Cells[5, contador]:= 'No';
                comisionTotal:= comisionTotal + strtofloat(formatfloat('0.00', (regVenDat.precioVenta*regVenDat.porcentajeComision/100)));
                formListadoPublicaciones.StringGridVentas.Cells[6, contador]:= inttostr(regVenDat.porcentajeComision)+' %';
                calificacion:= true;
              end;// IF CORROBORAR ARTICULO y CALIFICACION
              TDAColasParcialesV.Encolar(Venta, regVenDat, regVenInd, pos);
            end
            else
              corte:=true;
          end; //While-corte
          end; // Conversacion Encontrada
          MEVentas.cerrar(Venta);

          if calificacion then
          begin
              formListadoPublicaciones.StringGridVentas.Cells[0, contador]:= vectorArticulos[i].mailComprador;
              formListadoPublicaciones.StringGridVentas.Cells[1, contador]:= vectorArticulos[i].mailVendedor;
              formListadoPublicaciones.StringGridVentas.Cells[2, contador]:= vectorArticulos[i].NombreArticulo;
              formListadoPublicaciones.StringGridVentas.Cells[3, contador]:= datetimetostr(vectorArticulos[i].fechacierre);
              formListadoPublicaciones.StringGridVentas.Cells[4, contador]:= floattostr(vectorArticulos[i].precio);

              contador:= contador+1;
              formListadoPublicaciones.StringGridVentas.RowCount:= contador;
          end;//If calificacion
          end;// CheckBoxentro = true
        end; //If VENDIDOS
    end;// For
    formListadoPublicaciones.editTotal.text:= floattostr(comisionTotal);
    formListadoPublicaciones.editCobrada.text:= floattostr(comisionCobrada);
    formListadoPublicaciones.editTotal.Font.Color:= clWindowText;
    formListadoPublicaciones.editCobrada.font.color:= clWindowText;
  end;// Tipo 2
end;// filtrar

// Recorrido PreOrden RECURSIVO
procedure TformPublicacionesAdmin.recorrer(var Arbol: tipoPublicados; pos: TiposYconstantes.tipoposicion; var contador: integer; var vectorArticulos: array of MEArticulosPublicados.tipoRegDatos);
var
  regInd: MEArticulosPublicados.TipoRegIndice;
  regDatos: MEArticulosPublicados.TipoRegDatos;
  estado: string;
begin

  If pos<>MEArticulosPublicados.posNula(Arbol) then
  begin
    MEArticulosPublicados.capturarCategorias(Arbol, pos, regInd);
    MEArticulosPublicados.capturarArticulo(Arbol, regInd, regDatos);


  // =========================================================================== Cargar Vector Articulos
    vectorArticulos[contador]:= regDatos;
    contador:= contador +1;

    recorrer(Arbol, MEArticulosPublicados.hijoIzquierdoCategoria(Arbol, pos), contador, vectorArticulos);
    recorrer(Arbol, MEArticulosPublicados.hijoDerechoCategoria(Arbol, pos), contador, vectorArticulos);
  end;
end; //recorrer

procedure TformPublicacionesAdmin.btnCaducadasClick(Sender: TObject);
var
  cont, cont1, contador, pos: integer;
  regCat: MECategorias.tiporegdatos;
begin
if (fechaDesde.DateTime>fechaHasta.DateTime) then
  showmessage('La fecha DESDE tiene que ser menor que la fecha HASTA.')
else
begin
  formListadoPublicaciones.CheckBoxEstro.Checked:= false;

  formListadoPublicaciones.labelCobrada.Visible:= false;
  formListadoPublicaciones.labelTotal.Visible:= false;
  formListadoPublicaciones.editTotal.Visible:= false;
  formListadoPublicaciones.editCobrada.Visible:= false;

  formPublicacionesAdmin.close;
  formListadoPublicaciones.show;

  formListadoPublicaciones.StringGridVentas.Visible:= false;
  formListadoPublicaciones.StringGridCaducado.Visible:= true;
  formListadoPublicaciones.GroupBox1.Visible:= true;
  formListadoPublicaciones.labelRealizadas.Visible:= false;
  formListadoPublicaciones.labelCaducadas.Visible:= true;

  formListadoPublicaciones.GroupBoxCalificacion.Visible:= false;
  formListadoPublicaciones.ComboBoxCalificacion.ItemIndex:=0;

  SetLength(vectorArticulos, strtoint(formListadoPublicaciones.labelRow.caption)-1);

// ============================================================================ Cargar combobox
  formListadoPublicaciones.ComboBoxCategorias.Clear;
  formListadoPublicaciones.ComboBoxCategorias.Items.Add('Todas');
  formListadoPublicaciones.ComboBoxCategorias.ItemIndex:= 0;
  MECategorias.AbrirMe(Categoria);

  pos:= MECategorias.Primero(Categoria);
  while pos<>MECategorias.PosNula(Categoria) do
  begin
    MECategorias.Capturar(Categoria, pos, regCat);
    formListadoPublicaciones.ComboBoxCategorias.Items.Add(inttostr(regCat.Clave) +' - '+ regCat.categoria);
    pos:= MECategorias.Proximo(Categoria, pos);
  end;
  MECategorias.CerrarMe(Categoria);
  
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


  contador:= 0;
  MEArticulosPublicados.abrir(Publicado);
  recorrer(Publicado, MEArticulosPublicados.raizCategoria(Publicado), contador, vectorArticulos);
  MEArticulosPublicados.cerrar(Publicado);

  filtrar(formPublicacionesAdmin.fechaDesde.DateTime, formPublicacionesAdmin.fechaHasta.DateTime, 2, 999999999); // 2 -> caducada
end;
end;// btnCaducadasClick


procedure TformPublicacionesAdmin.btnConversacionClick(Sender: TObject);
var
  posPri, posSeg, contador, ventas: integer;
  reg:MEUsuario.tiporegListaDatosHash;
begin
 formPublicacionesAdmin.close;
 formConversacionesAdmin.show;

 formConversacionesAdmin.comboboxVendedor.Clear;
 formConversacionesAdmin.comboboxComprador.Clear;
 formConversacionesAdmin.comboboxArticulo.Clear;

 //============================================================================ Cargar Combo Box
  MEUsuario.AbrirMe(Usuario);

  formConversacionesAdmin.comboboxVendedor.Items.Add('Ninguno');
  formConversacionesAdmin.comboboxComprador.Items.Add('Ninguno');
  formConversacionesAdmin.comboboxArticulo.Items.Add('Ninguno');

  posPri:= MEUsuario.primeroListaDoble(Usuario);
  while (posPri<>MEUsuario._posnula) do
  begin
    posSeg:= MEUsuario.primeroListaDobleParciales(Usuario, posPri);
    While (posSeg<>MEUsuario._posnula) do
    begin
    MEUsuario.CapturarInfo(Usuario, reg, posSeg);
     if (reg.Clave<>'administrador@ventalibre.com') then
      begin
      formConversacionesAdmin.comboboxVendedor.Items.Add(reg.Clave);
      formConversacionesAdmin.comboboxComprador.Items.Add(reg.Clave);
      end;// Si no es ADMINISTRADOR
    FormAdmUsuarios.StringGridUsuarios.RowCount:= contador;
    posSeg:= MEUsuario.proximoListaDobleParciales(Usuario, posSeg, reg);
    end;
    posPri:= MEUsuario.proximoListaDoble(Usuario, posPri);
  end;

  formConversacionesAdmin.comboboxVendedor.ItemIndex:= 0;
  formConversacionesAdmin.comboboxComprador.ItemIndex:= 0;
  formConversacionesAdmin.comboboxArticulo.ItemIndex:= 0;

  MEUsuario.CerrarMe(Usuario);

end;

end.

