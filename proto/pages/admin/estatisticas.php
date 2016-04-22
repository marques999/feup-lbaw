<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

    if (utilizador_isAdministrator($idUtilizador)) {
      $smarty->assign('titulo', 'Estatísticas');
      $smarty->display('admin/estatisticas.tpl');
    }
    else {
      safe_redirect('403.php');
    }
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>