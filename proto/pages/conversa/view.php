<?
  include_once('../../config/init.php');
  include_once('../../database/conversa.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $idConversa = safe_getId($_GET, 'id');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $queryConversa = conversa_listById($idConversa);

    if ($queryConversa && is_array($queryConversa)) {

      $idRemetente = safe_getId($queryConversa, 'idutilizador1');
      $idDestinatario = safe_getId($queryConversa, 'idutilizador2');

      if ($idRemetente == $idUtilizador || $idDestinatario == $idUtilizador) {

        $queryMensagens = conversa_fetchMessages($idConversa);
        $smarty->assign('conversa', $queryConversa);
        $smarty->assign('mensagens', $queryMensagens);
        $smarty->display('conversa/view.tpl');
      }
      else {
        safe_redirect('conversa/list.php');
      }
    }
    else {
      safe_redirect('conversa/list.php');
    }
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>