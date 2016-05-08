<?
  include_once('../../config/init.php');
  include_once('../../database/conversa.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (safe_check($_POST, 'idConversa')) {
    $idConversa = safe_getId($_POST, 'idMensagem');
  }
  else {
    safe_error(null, 'Deve especificar uma conversa primeiro!');
  }

  if (safe_check($_POST, 'idMensagem')) {
    $idMensagem = safe_getId($_POST, 'idMensagem');
  }
  else {
    safe_error(null, 'Deve especificar uma mensagem primeiro!');
  }

  try {

    if (conversa_apagarMensagem($idConversa, $idMensagem, $idUtilizador) > 0) {
      safe_redirect("conversa/list.php");
    }
    else {
      safe_error(null, 'Erro na operação, tentou apagar uma conversa de outro utilizador?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>