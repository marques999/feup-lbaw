<?
  include_once('../../config/init.php');
  include_once('../../database/resposta.php');
  include_once('../../database/utilizador.php');

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

  if (safe_strcheck($_POST, 'descricao')) {
    $descricao = safe_trimAll($_POST, 'descricao');
  }
  else {
    safe_formerror('O corpo da resposta não pode estar em branco!');
  }

  $isOriginalPoster = resposta_verificarAutor($idResposta, $idUtilizador);
  $isAdministrator = utilizador_isAdministrator($idUtilizador);
  $isModerator = utilizador_isModerator($idUtilizador);

  if (!$isOriginalPoster && !$isModerator && !$isAdministrator) {
    safe_redirect('403.php');
  }

  try {

    if (resposta_atualizarResposta($idResposta, $idUtilizador, $descricao) > 0) {
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