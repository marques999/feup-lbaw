<?
  include_once('../../config/init.php');
  include_once('../../database/conversa.php');
  include_once('../../database/utilizador.php');
  
  if (safe_check($_SESSION, 'idUtilizador')) {
    $smarty->assign('conversas', conversa_obterConversas(safe_getId($_SESSION, 'idUtilizador')));
    $smarty->assign('titulo', 'Mensagens Privadas');
    $smarty->display('conversa/list.tpl');
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>