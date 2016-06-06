<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $smarty->assign('idUtilizador', $idUtilizador);
    $smarty->assign('titulo', 'Alterar Password');
    $smarty->display('utilizador/password.tpl');
  }
  else {
    safe_login();
  }
?>