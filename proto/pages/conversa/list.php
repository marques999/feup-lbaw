<?
  include_once('../../config/init.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $smarty->assign('conversas', utilizador_fetchThreads(safe_getId($_SESSION, 'idUtilizador')));
    $smarty->display('conversa/list.tpl');
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>