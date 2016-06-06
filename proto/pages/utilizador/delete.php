<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_GET, 'id')) {

    $idUtilizador = safe_getId($_GET, 'id');

    if ($idAdministrador == $idUtilizador || safe_checkAdministrador()) {
      $smarty->assign('idUtilizador', $idUtilizador);
    }
    else {
      safe_redirect('403.php');
    }
  }
  else {
    $smarty->assign('idUtilizador', $idAdministrador);
  }

  $smarty->assign('titulo', 'Apagar Utilizador');
  $smarty->display('utilizador/delete.tpl');
?>