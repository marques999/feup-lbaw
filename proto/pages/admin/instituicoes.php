<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_login();
  }

  if (safe_checkAdministrador()) {
    $smarty->assign('instituicoes', instituicao_listarInstituicoes());
    $smarty->assign('titulo', 'Gerir Instituições');
    $smarty->display('admin/instituicoes.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>