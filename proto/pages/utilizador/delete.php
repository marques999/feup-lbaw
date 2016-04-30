<?
  include_once('../../config/init.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $idUtilizador1 = safe_getId($_SESSION, 'idUtilizador');

    if (safe_check($_GET, 'id')) {

      $idUtilizador2 = safe_getId($_GET, 'id');

      if ($idUtilizador1 == $idUtilizador2 || utilizador_isAdministrator($idUtilizador1)) {
        $smarty->assign('idUtilizador', $idUtilizador2);
        $smarty->display('utilizador/delete.tpl');
      }
      else {
        safe_redirect('403.php');
      }
    }
    else {
      $smarty->assign('idUtilizador', $idUtilizador1);
      $smarty->display('utilizador/delete.tpl');
    }
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>