<?
  include_once('../../config/init.php');
  include_once('../../database/conversa.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idRemetente = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('Deve estar autenticado para aceder a esta página!', 'utilizador/login.php');
  }

  if (safe_check($_POST, 'idConversa')) {
    $idConversa = safe_getId($_POST, 'idConversa');
  }
  else {
    safe_formerror('Deve especificar uma conversa primeiro!');
  }

  if (safe_strcheck($_POST, 'descricao')) {
    $descricao = $_POST['descricao'];
  }
  else {
    safe_formerror('O corpo da mensagem não pode estar em branco!');
  }

  try {

    if (conversa_enviarMensagem($idConversa, $idRemetente, $descricao) > 0) {
      safe_redirect("conversa/view.php?id=$idConversa");
    }
    else {
      safe_formerror('Erro desconhecido: tentou responder a uma conversa inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>