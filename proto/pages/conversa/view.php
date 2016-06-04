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

  if (safe_check($_GET, 'id')) {
    $idConversa = safe_getId($_GET, 'id');
  }
  else {
    safe_redirect('conversa/list.php');
  }

  $queryConversa = conversa_listarInformacoes($idConversa);

  if ($queryConversa && is_array($queryConversa)) {
    $idRemetente = safe_getId($queryConversa, 'idutilizador1');
    $idDestinatario = safe_getId($queryConversa, 'idutilizador2');
  }
  else {
    safe_redirect('conversa/list.php');
  }

  if ($idRemetente == $idUtilizador || $idDestinatario == $idUtilizador) {
    $queryMensagens = conversa_obterMensagens($idConversa);
    $smarty->assign('conversa', $queryConversa);
    $smarty->assign('mensagens', $queryMensagens);
    $smarty->assign('titulo', $queryConversa.titulo);
    $smarty->display('conversa/view.tpl');
  }
  else {
    safe_redirect('conversa/list.php');
  }
?>