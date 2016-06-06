<?
  include_once('../../config/init.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_login();
  }

  if (safe_checkAdministrador()) {
    $smarty->assign('titulo', 'Administração');
    $smarty->display('admin/homepage.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>