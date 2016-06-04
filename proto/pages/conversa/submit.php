<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idRemetente = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_GET, 'id')) {
    $idDestinatario = safe_getId($_GET, 'id');
  }
  else {
    safe_formerror("O identificador do destinatário não pode estar em branco!");
  }

  if ($idRemetente != $idDestinatario) {
    $queryUtilizador = utilizador_getById($idDestinatario);
    $smarty->assign('utilizador', $queryUtilizador);
    $smarty->assign('titulo', 'Enviar Mensagem');
    $smarty->display('conversa/submit.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>