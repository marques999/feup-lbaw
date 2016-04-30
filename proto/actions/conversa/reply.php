<?
  include_once('../../config/init.php');
  include_once('../../database/conversa.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!safe_check($_POST, 'idConversa')) {
    safe_error(null, 'Deve especificar uma conversa primeiro!');
  }

  if (!safe_strcheck($_POST, 'descricao')) {
    safe_error(null, 'O corpo da mensagem não pode estar em branco!');
  }

  try {

    $idConversa = safe_getId($_POST, 'idConversa');
    $idRemetente = safe_getId($_SESSION, 'idUtilizador');
    $safeDescricao = safe_trim($_POST, 'descricao');

    if (conversa_enviarMensagem($idConversa, $idRemetente, $safeDescricao) > 0) {
      safe_redirect("conversa/view.php?id=$idConversa");
    }
    else {
      safe_error(null, 'Erro na operação, tentou aceder a uma conversa inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>