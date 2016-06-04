<?
  include_once('../../config/init.php');
  include_once('../../database/conversa.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idRemetente = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_POST, 'destinatario')) {
    $idDestinatario = safe_getId($_POST, 'destinatario');
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

    $idConversa = conversa_criarConversa($idRemetente, $idDestinatario, $titulo, $descricao);
    
    if ($idConversa > 0) {
      safe_redirect("conversa/view.php?id=$idConversa");
    }
    else {
      safe_formerror('Erro desconhecido: tentou criar uma conversa que já existe?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>