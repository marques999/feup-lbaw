<?
  include_once('../../config/init.php');
  include_once('../../database/conversa.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('Deve estar autenticado para aceder a esta página!', 'utilizador/login.php');
  }

  if (safe_check($_POST, 'idDestinatario')) {
    $idDestinatario = safe_getId($_POST, 'idDestinatario')
  }
  else {
    safe_formerror('Deve especificar um destinatário primeiro!');
  }

  if (safe_strcheck($_POST, 'titulo')) {
    $titulo = safe_trim($_POST, 'titulo');
  }
  else {
    safe_formerror('O assunto da conversa não pode estar em branco!');
  }

  if (safe_strcheck($_POST, 'descricao')) {
    $descricao = safe_trim($_POST, 'descricao');
  }
  else {
    safe_formerror('O corpo da mensagem não pode estar em branco!');
  }

  try {

    if (conversa_criarConversa($idUtilizador, $idDestinatario, $titulo, $descricao) < 1) {
      safe_formerror('Erro desconhecido: tentou criar uma conversa que já existe?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>