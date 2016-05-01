<?
  include_once('../../config/init.php');
  include_once('../../database/resposta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!safe_check($_POST, 'idPergunta')) {
    safe_error(null, 'Deve especificar uma pergunta primeiro!');
  }

  if (!safe_check($_POST, 'idResposta')) {
    safe_error(null, 'Deve especificar uma resposta primeiro!');
  }

  if (!safe_strcheck($_POST, 'descricao')) {
    safe_error(null, 'O corpo da resposta não pode estar em branco!');
  }

  $idPergunta = safe_getId($_POST, 'idPergunta');
  $idResposta = safe_getId($_POST, 'idResposta');
  $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  $paginaPergunta = "pergunta/view.php?id=$idPergunta#reply-$idResposta";
  $isOriginalPoster = resposta_verificarAutor($idResposta, $idUtilizador);
  $isAdministrator = utilizador_isAdministrator($idUtilizador);
  $isModerator = utilizador_isModerator($idUtilizador);

  if (!$isOriginalPoster && !$isModerator && !$isAdministrator) {
    safe_redirect('403.php');
  }

  try {

    $safeMessage = safe_trim($_POST, 'descricao');

    if (resposta_atualizarResposta($idResposta, $idUtilizador) > 0) {
      safe_redirect($paginaPergunta);
    }
    else {
      safe_error($paginaPergunta, 'Erro na operação: tentou editar as informações de uma resposta inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>