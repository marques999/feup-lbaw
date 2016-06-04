<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (!utilizador_isAdministrator($idUtilizador)) {
    safe_redirect('403.php');
  }

  if (safe_strcheck($_GET, 'id')) {
    $smarty->assign('idInstituicao', safe_trimAll($_GET, 'id'));
    $smarty->assign('titulo', 'Apagar Instituição');
    $smarty->display('instituicao/delete.tpl');
  }
  else {
    safe_redirect('404.php');
  }
?>