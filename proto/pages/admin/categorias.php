<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_redirect('utilizador/login.php');
  }

  if (utilizador_isAdministrator($idUtilizador)) {
    $smarty->assign('categorias', categoria_listAll());
    $smarty->assign('titulo', 'Gerir Categorias');
    $smarty->display('admin/categorias.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>