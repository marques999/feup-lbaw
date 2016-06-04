<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (utilizador_isAdministrator($idUtilizador)) {
    $queryCategorias = categoria_listarCategorias();
    $smarty->assign('numberRows', count($queryCategorias) / 4);
    $smarty->assign('categorias', $queryCategorias);
    $smarty->assign('titulo', 'Gerir Categorias');
    $smarty->display('admin/categorias.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>