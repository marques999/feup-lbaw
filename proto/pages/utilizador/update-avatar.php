<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  $smarty->assign('idUtilizador', $idUtilizador);
  $smarty->assign('utilizador', utilizador_getById($idUtilizador));
  $smarty->assign('titulo', 'Alterar Avatar');
  $smarty->display('utilizador/update-avatar.tpl');
?>