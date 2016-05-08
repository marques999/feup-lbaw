<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/resposta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (safe_check($_GET, 'idp')) {
    $idPergunta = safe_getId($_GET, 'idp');
  }
  else {
    safe_error(null, 'Deve especificar uma pergunta primeiro!');
  }

  $isOriginalPoster = pergunta_verificarAutor($idPergunta, $idUtilizador);
  $isAdministrator = utilizador_isAdministrator($idUtilizador);
  $isModerator = utilizador_isModerator($idUtilizador);

  if (!$isOriginalPoster && !$isModerator && !$isAdministrator) {
    safe_redirect('403.php');
  }

  if (safe_check($_GET, 'idr')) {
    $idResposta = safe_getId($_GET, 'idr');
  }
  else {
    safe_error(null, 'Deve especificar uma resposta primeiro!');
  }

  try {

    if (resposta_destacarResposta($idPergunta, $idResposta) > 0) {
      safe_redirect("pergunta/view.php?id=$idPergunta");
    }
    else {
      safe_error(null, 'Erro na operação: tentou destacar uma resposta inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>