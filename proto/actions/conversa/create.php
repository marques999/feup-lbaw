<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/conversa.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!safe_check($_POST, 'idDestinatario')) {
    safe_error(null, 'Deve especificar um destinatário primeiro!');
  }

  if (!safe_check($_POST, 'titulo')) {
    safe_error(null, 'O assunto da conversa não pode estar em branco!');
  }

  if (!safe_check($_POST, 'descricao')) {
    safe_error(null, 'O corpo da mensagem não pode estar em branco!');
  }

  try {

    $idRemetente = safe_getId($_SESSION, 'idUtilizador');
    $idDestinatario = safe_getId($_POST, 'idDestinatario');
    $safeTitulo = safe_trim($_POST, 'titulo');

    if (conversa_criarThread($idRemetente, $idDestinatario, $safeTitulo) < 1) {
      safe_error(null, 'Erro desconhecido, tentou aceder a uma conversa inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }

  try {

    $safeDescricao = safe_trim($_POST, 'descricao');
    $idConversa = $db->lastInsertId('conversa_idconversa_seq');

    if (conversa_enviarMensagem($idConversa, $idRemetente, $safeDescricao) > 0) {
      safe_redirect("conversa/view.php?id=$idConversa");
    }
    else {
      safe_error(null, 'Erro desconhecido, tentou aceder a uma conversa inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>