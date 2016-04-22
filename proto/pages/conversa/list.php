<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if ($_SESSION['idUtilizador']) {
  	$idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $smarty->assign('conversas', utilizador_fetchThreads($idUtilizador));
  	$smarty->display('conversa/list.tpl');
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>