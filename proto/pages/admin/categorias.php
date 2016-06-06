<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_login();
  }

  if (safe_checkAdministrador()) {
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