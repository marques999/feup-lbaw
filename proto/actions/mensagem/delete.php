<?
  include_once('../../config/init.php');
  include_once('../../database/conversa.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('Deve estar autenticado para aceder a esta página!', 'utilizador/login.php');
  }

  if (safe_check($_POST, 'idConversa')) {
    $idConversa = safe_getId($_POST, 'idMensagem');
  }
  else {
    safe_error('Deve especificar uma conversa primeiro!');
  }

  if (safe_check($_POST, 'idMensagem')) {
    $idMensagem = safe_getId($_POST, 'idMensagem');
  }
  else {
    safe_error('Deve especificar uma mensagem primeiro!');
  }

  try {

    if (conversa_apagarMensagem($idConversa, $idMensagem, $idUtilizador) > 0) {
      safe_redirect('conversa/list.php');
    }
    else {
      safe_error('Erro desconhecido: tentou apagar uma mensagem de outra conversa?');
    }
  }
  catch (PDOException $e) {
    safe_error($e->getMessage());
  }
?>