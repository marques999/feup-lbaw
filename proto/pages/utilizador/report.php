<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idModerador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_redirect('utilizador/login.php');
  }

  if (safe_check($_GET, 'id')) {
    $idUtilizador = safe_getId($_GET, 'id');
  }
  else {
    safe_redirect('404.php');
  }

  if (utilizador_isModerator($idModerador) && $idModerador != $idUtilizador) {
    $smarty->assign('idUtilizador', $idUtilizador);
    $smarty->display('utilizador/report.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>