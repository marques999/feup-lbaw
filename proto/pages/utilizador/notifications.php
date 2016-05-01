<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $smarty->display('utilizador/notifications.tpl');
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>