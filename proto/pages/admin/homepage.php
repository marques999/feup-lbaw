<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if ($_SESSION['idUtilizador']) {

    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $isAdministrator = utilizador_isAdministrator($_SESSION['idUtilizador']);

    if ($isAdministrator) {
      $smarty->display('admin/homepage.tpl');
    }
    else {
      safe_redirect('403.php');
    }
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>