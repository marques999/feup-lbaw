<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_strcheck($_GET, 'id')) {
    $idInstituicao = safe_trimAll($_GET, 'id');
  }
  else {
    safe_redirect('404.php');
  }

  if (safe_checkAdministrador()) {
    $smarty->assign('idInstituicao', $idInstituicao);
    $smarty->assign('titulo', 'Apagar Instituição');
    $smarty->display('instituicao/delete.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>