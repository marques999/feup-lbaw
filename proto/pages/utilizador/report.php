<?
  include_once('../../config/init.php');
  include_once('../../database/report.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idModerador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_GET, 'id')) {
    $idUtilizador = safe_getId($_GET, 'id');
    $readOnly = false;
  }
  else {
    $readOnly = true;
  }

  if (utilizador_isModerator($idModerador)) {

    if ($readOnly || $idModerador == $idUtilizador) {
      $queryReports = report_listarReports();
      $smarty->assign('reports', $queryReports);
      $smarty->assign('reports_count', count($queryReports));
      $smarty->assign('titulo', 'Reports');
      $smarty->display('report/list.tpl');
    }
    else {
      $queryUtilizador = utilizador_getById($idUtilizador);
      $smarty->assign('utilizador', $queryUtilizador);
      $smarty->assign('titulo', 'Denunciar Utilizador');
      $smarty->display('report/submit.tpl');
    }
  }
  else {
    safe_redirect('403.php');
  }
?>