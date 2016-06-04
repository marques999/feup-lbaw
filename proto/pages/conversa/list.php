<?
  include_once('../../config/init.php');
  include_once('../../database/conversa.php');
  include_once('../../database/utilizador.php');
  
  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  $smarty->assign('conversas', conversa_listarConversas($idUtilizador));
  $smarty->assign('titulo', 'Mensagens Privadas');
  $smarty->display('conversa/list.tpl');
?>