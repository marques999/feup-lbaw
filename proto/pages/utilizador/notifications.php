<?
  include_once('../../config/init.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $smarty->display('utilizador/notifications.tpl');
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>