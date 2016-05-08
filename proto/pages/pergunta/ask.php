<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
  	$smarty->assign('titulo', 'Nova Pergunta');
    $smarty->display('pergunta/ask.tpl');
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>