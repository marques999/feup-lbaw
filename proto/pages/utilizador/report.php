<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $idModerador = safe_getId($_SESSION, 'idUtilizador');

    if (safe_check($_GET, 'id')) {

      $idUtilizador = safe_getId($_GET, 'id');

      if (utilizador_isModerator($idModerador) && $idModerador != $idUtilizador) {
        $smarty->assign('idUtilizador', $idUtilizador);
        $smarty->display('utilizador/report.tpl');
      }
      else {
        safe_redirect('403.php');
      }
    }
    else {
      safe_redirect('404.php');
    }
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>