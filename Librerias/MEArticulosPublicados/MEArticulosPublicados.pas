Unit MEArticulosPublicados;

interface
uses
	TDAArbolesAVL, TiposYconstantes, Dialogs;
	
type

  tipoRegDatos=TDAArbolesAVL.registroDatos;
  tipoRegIndice=TDAArbolesAVL.registroIndice;
	tipoPublicados=TDAArbolesAVL.tipoArticulos;
	
procedure crear(var me:tipoPublicados; ruta, nombre: string);
procedure abrir(var me:tipoPublicados);
procedure cerrar(var me:tipoPublicados);

function vacioVendedor(var me:tipoPublicados):boolean;
function vacioCategorias(var me:tipoPublicados):boolean;

function buscarVendedor(var me:tipoPublicados; clave:tipoClave; var pos:tipoposicion):boolean;
function buscarCategorias(var me:tipoPublicados; clave:tipoClave; var pos:tipoposicion):boolean;

procedure insertar(var Me: tipoArticulos; reg:registroDatos; idVendedor:tipoposicion; idCategoria:tipoposicion);
procedure eliminar(var Me: tipoArticulos; regCategoria:registroIndice; regVendedor:registroIndice);
procedure capturarVendedor(var Me: tipoArticulos; pos:tipoposicion; var reg:registroIndice);
procedure capturarCategorias(var Me: tipoArticulos; pos:tipoposicion; var reg:registroIndice);
procedure capturarArticulo(var Me: tipoArticulos; regIndice:registroIndice; var reg:registroDatos);
procedure modificar(var Me: tipoArticulos; regIndice:registroIndice; reg:registroDatos);

function raizVendedor(var Me: tipoArticulos): tipoposicion;
function raizCategoria(var Me: tipoArticulos): tipoposicion;
function hijoDerechoVendedor(var Me: tipoArticulos; pos: tipoposicion): tipoposicion;
function hijoDerechoCategoria(var Me: tipoArticulos; pos: tipoposicion): tipoposicion;
function hijoIzquierdoVendedor(var Me: tipoArticulos; pos: tipoposicion): tipoposicion;
function hijoIzquierdoCategoria(var Me: tipoArticulos; pos: tipoposicion): tipoposicion;

function posNula(Var Me:tipoArticulos):tipoposicion;


implementation
uses SysUtils;

procedure crear(var me:tipoPublicados; ruta, nombre: string);
begin
	TDAArbolesAVL.crear(me, ruta, nombre);
end;

procedure abrir(var me:tipoPublicados);
begin
	TDAArbolesAVL.abrir(me);
end;

procedure cerrar(var me:tipoPublicados);
begin
	TDAArbolesAVL.cerrar(me);
end;

function vacioVendedor(var me:tipoPublicados):boolean;
begin
	vacioVendedor:= TDAArbolesAVL.vacio(me,true);
end;

function vacioCategorias(var me:tipoPublicados):boolean;
begin
	vacioCategorias:= TDAArbolesAVL.vacio(me,false);
end;

function buscarVendedor(var me:tipoPublicados; clave:tipoClave; var pos:tipoposicion):boolean;
begin
	buscarVendedor := TDAArbolesAVL.buscar(me,pos,clave,true);
end;

function buscarCategorias(var me:tipoPublicados; clave:tipoClave; var pos:tipoposicion):boolean;
begin
	buscarCategorias := TDAArbolesAVL.buscar(me,pos,clave,false);
end;

procedure insertar(var Me: tipoArticulos; reg:registroDatos; idVendedor:tipoposicion; idCategoria:tipoposicion);
var pos, posEnDatos:tipoposicion; regVendedor,regCategoria:registroIndice;
begin
  reg.clave:=inttostr(TDAArbolesAVL.ultimoId(me));

  //inserto en vendedor
	regVendedor.clave:=inttostr(idVendedor)+reg.clave;
	regVendedor.id:=idVendedor;//inserto en vendedor
	if not(TDAArbolesAVL.buscar(me, pos, regVendedor.clave, true)) then
  	TDAArbolesAVL.insertar(me, regVendedor, reg, pos, true, posEnDatos);

	//inserto en categorias
	regCategoria.clave:=inttostr(idCategoria)+reg.clave;
	regCategoria.id:=idCategoria;
	if not(TDAArbolesAVL.buscar(me, pos, regCategoria.clave, false)) then
	  TDAArbolesAVL.insertar(me, regCategoria, reg, pos, false, posEnDatos);
end;

procedure eliminar(var Me: tipoArticulos; regCategoria:registroIndice; regVendedor:registroIndice);
var pos:tipoposicion; regIndice:registroIndice;
begin
 if (TDAArbolesAVL.buscar(me, pos, regVendedor.clave, true)) then
 begin
  //TDAArbolesAVL.Capturar(me,pos,regIndice,true);
  TDAArbolesAVL.Eliminar(me,pos,true);
 end;
 if(TDAArbolesAVL.buscar(me, pos, regCategoria.clave, false)) then
  TDAArbolesAVL.Eliminar(me,pos,false);
end;

procedure capturarVendedor(var Me: tipoArticulos; pos:tipoposicion; var reg:registroIndice);
begin
	TDAArbolesAVL.capturar(me, pos, reg, true);
end;

procedure capturarCategorias(var Me: tipoArticulos; pos:tipoposicion; var reg:registroIndice);
begin
	TDAArbolesAVL.capturar(me, pos, reg, false);
end;  

procedure capturarArticulo(var Me: tipoArticulos; regIndice:registroIndice; var reg:registroDatos);
begin
	TDAArbolesAVL.capturarDatos(me, regIndice.posicion, reg); //no es necesario pasar un booleano, porque le pega directamente al metdo
end;

procedure modificar(var Me: tipoArticulos; regIndice:registroIndice; reg:registroDatos);//modificar el articulo en dat
begin
	TDAArbolesAVL.modificar(me, regIndice.posicion, reg);
end;

function raizVendedor(var Me: tipoArticulos): tipoposicion;
begin
	raizVendedor := TDAArbolesAVL.getRaiz(me,true);
end;

function raizCategoria(var Me: tipoArticulos): tipoposicion;
begin
	raizCategoria := TDAArbolesAVL.getRaiz(me,false);
end;

function hijoDerechoVendedor(var Me: tipoArticulos; pos: tipoposicion): tipoposicion;
begin
	hijoDerechoVendedor := TDAArbolesAVL.hijoDerecho(me, pos, true);
end;

function hijoDerechoCategoria(var Me: tipoArticulos; pos: tipoposicion): tipoposicion;
begin
	hijoDerechoCategoria := TDAArbolesAVL.hijoDerecho(me, pos, false);
end;

function hijoIzquierdoVendedor(var Me: tipoArticulos; pos: tipoposicion): tipoposicion;
begin
	hijoIzquierdoVendedor := TDAArbolesAVL.hijoIzquierdo(me, pos, true);
end;

function hijoIzquierdoCategoria(var Me: tipoArticulos; pos: tipoposicion): tipoposicion;
begin
	hijoIzquierdoCategoria := TDAArbolesAVL.hijoIzquierdo(me, pos, false);
end;

function posNula(Var Me:tipoArticulos):tipoposicion;
begin
	posNula := TDAArbolesAVL.PosNula(me);
end;

end.
