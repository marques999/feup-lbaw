<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (utilizador_isAdministrator($idUtilizador)) {
    $smarty->assign('titulo', 'Administração');
    $smarty->display('admin/homepage.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>