program VentaLibre;

uses
  Forms,
  Login in 'Formularios\Login\Login.pas' {formLogin},
  Registrarse in 'Formularios\Registrarse\Registrarse.pas' {formRegistrarse},
  TiposYconstantes in 'Librerias\TiposYconstantes\TiposYconstantes.pas',
  MEUsuario in 'Librerias\MEUsuario\MEUsuario.pas',
  TDAHashCerrado in 'Librerias\MEUsuario\HashCerrado\TDAHashCerrado.pas',
  TDAListasParciales in 'Librerias\MEUsuario\ListaDobleParcial\TDAListasParciales.pas',
  TDAListaDoble in 'Librerias\MEUsuario\ListaDoble\TDAListaDoble.pas',
  PantallaUsuario in 'Formularios\PantallaUsuario\PantallaUsuario.pas' {formUsuario},
  PerfilUsuario in 'Formularios\PantallaUsuario\Perfil\PerfilUsuario.pas' {formPerfilUsuario},
  Administrador in 'Formularios\PantallaAdministrador\Administrador.pas' {formAdministrador},
  Categorias in 'Formularios\PantallaAdministrador\Categorias\Categorias.pas' {formCategorias},
  MECategorias in 'Librerias\MECategorias\MECategorias.pas',
  TDAListaDobleCat in 'Librerias\MECategorias\ListaDoble\TDAListaDobleCat.pas',
  crearCategorias in 'Formularios\PantallaAdministrador\Categorias\ABM Categorias\crearCategorias.pas' {formCrearCategoria},
  EditElimCategorias in 'Formularios\PantallaAdministrador\Categorias\ABM Categorias\EditElimCategorias.pas' {formElimModCategoria},
  MEArticulosPublicados in 'Librerias\MEArticulosPublicados\MEArticulosPublicados.pas',
  TDAArbolesAVL in 'Librerias\MEArticulosPublicados\TDAArbolesAVL\TDAArbolesAVL.pas',
  Ventas in 'Formularios\PantallaUsuario\Vender\Ventas.pas' {formVentas},
  Publicaciones in 'Formularios\PantallaUsuario\Publicaciones\Publicaciones.pas' {formPublicaciones},
  PublicacionSeleccionada in 'Formularios\PantallaUsuario\Publicaciones\Publicacion seleccionada\PublicacionSeleccionada.pas' {formPubSeleccionada},
  AdmUsuario in 'Formularios\PantallaAdministrador\Administrar Usuarios\AdmUsuario.pas' {formAdmUsuarios},
  OpcUsuario in 'Formularios\PantallaAdministrador\Administrar Usuarios\Opciones Usuario\OpcUsuario.pas' {formOpcionesUsuario},
  Menu in 'Formularios\PantallaUsuario\Publicaciones\Publicacion menu\Menu.pas' {formMenuUsuario},
  PublicacionesAdmin in 'Formularios\PantallaAdministrador\Publicaciones\PublicacionesAdmin.pas' {formPublicacionesAdmin},
  MenuPublicidad in 'Formularios\PantallaAdministrador\Publicaciones\Menu Publicidad\MenuPublicidad.pas' {formMenuAdmPublicaciones},
  Listado in 'Formularios\PantallaAdministrador\Publicaciones\Listado Publicaciones\Listado.pas' {formListadoPublicaciones},
  TDACola in 'Librerias\MEConversaciones\Colas\TDACola.pas',
  TDAColasParciales in 'Librerias\MEConversaciones\Colas Parciales\TDAColasParciales.pas',
  MEConversaciones in 'Librerias\MEConversaciones\MEConversaciones.pas',
  PubSeleccionada in 'Formularios\PantallaUsuario\Publicacion Comprar\PubSeleccionada.pas' {formPubComprar},
  Conversacion in 'Formularios\PantallaUsuario\Publicaciones\Publicacion menu\Conversaciones\Conversacion.pas' {formConversaciones},
  ConversacionesAdmin in 'Formularios\PantallaAdministrador\Publicaciones\Menu Publicidad\Conversaciones\ConversacionesAdmin.pas' {formConversacionesAdmin},
  MEVentas in 'Librerias\MEVentas\MEVentas.pas',
  TDAColasParcialesV in 'Librerias\MEVentas\Colas Parciales\TDAColasParcialesV.pas',
  TDAColaV in 'Librerias\MEVentas\Colas\TDAColaV.pas',
  Compras in 'Formularios\PantallaUsuario\Compras\Compras.pas' {formMisCompras},
  MenuCompras in 'Formularios\PantallaUsuario\Compras\MenuCompras\MenuCompras.pas' {formMenuCompras},
  Herramientas in 'Formularios\PantallaAdministrador\Herramientas\Herramientas.pas' {formHerramientas},
  MisVentas in 'Formularios\PantallaUsuario\MisVentas\MisVentas.pas' {formMisVentas},
  ComprasUsu in 'Formularios\PantallaAdministrador\Administrar Usuarios\Opciones Usuario\Compras\ComprasUsu.pas' {formComprasAdmin};
  

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformLogin, formLogin);
  Application.CreateForm(TformRegistrarse, formRegistrarse);
  Application.CreateForm(TformUsuario, formUsuario);
  Application.CreateForm(TformPerfilUsuario, formPerfilUsuario);
  Application.CreateForm(TformAdministrador, formAdministrador);
  Application.CreateForm(TformCategorias, formCategorias);
  Application.CreateForm(TformCrearCategoria, formCrearCategoria);
  Application.CreateForm(TformElimModCategoria, formElimModCategoria);
  Application.CreateForm(TformVentas, formVentas);
  Application.CreateForm(TformPublicaciones, formPublicaciones);
  Application.CreateForm(TformPubSeleccionada, formPubSeleccionada);
  Application.CreateForm(TformAdmUsuarios, formAdmUsuarios);
  Application.CreateForm(TformOpcionesUsuario, formOpcionesUsuario);
  Application.CreateForm(TformMenuUsuario, formMenuUsuario);
  Application.CreateForm(TformPublicacionesAdmin, formPublicacionesAdmin);
  Application.CreateForm(TformMenuAdmPublicaciones, formMenuAdmPublicaciones);
  Application.CreateForm(TformListadoPublicaciones, formListadoPublicaciones);
  Application.CreateForm(TformPubComprar, formPubComprar);
  Application.CreateForm(TformConversaciones, formConversaciones);
  Application.CreateForm(TformConversacionesAdmin, formConversacionesAdmin);
  Application.CreateForm(TformMisCompras, formMisCompras);
  Application.CreateForm(TformMenuCompras, formMenuCompras);
  Application.CreateForm(TformHerramientas, formHerramientas);
  Application.CreateForm(TformMisVentas, formMisVentas);
  Application.CreateForm(TformComprasAdmin, formComprasAdmin);
  Application.Run;
end.
