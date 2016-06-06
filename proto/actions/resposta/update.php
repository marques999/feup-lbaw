<?
  include_once('../../config/init.php');
  include_once('../../database/resposta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_POST, 'idPergunta')) {
    $idPergunta = safe_getId($_POST, 'idPergunta');
  }
  else {
    safe_formerror('Deve especificar uma pergunta primeiro!');
  }

  if (safe_check($_POST, 'idResposta')) {
    $idResposta = safe_getId($_POST, 'idResposta');
  }
  else {
    safe_formerror('Deve especificar uma resposta primeiro!');
  }

  if (safe_strcheck($_POST, 'resposta')) {
    $descricao = safe_trim($_POST, 'resposta');
  }
  else {
    safe_formerror('O corpo da resposta não pode estar em branco!');
  }

  $isOriginalPoster = resposta_verificarAutor($idResposta, $idUtilizador);

  if (!$isOriginalPoster && !safe_checkModerador() && !safe_checkAdministrador()) {
    safe_redirect('403.php');
  }

  try {

    if (resposta_editarResposta($idResposta, $descricao) > 0) {
      safe_redirect("pergunta/view.php?id=$idPergunta#reply-$idResposta");
    }
    else {
      safe_formerror('Erro desconhecido: tentou editar uma resposta inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>