<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_redirect('utilizador/login.php');
  }

  if (utilizador_isAdministrator($idUtilizador)) {
    $smarty->assign('instituicoes', instituicao_listAll());
    $smarty->assign('titulo', 'Gerir Instituições');
    $smarty->display('admin/instituicoes.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>