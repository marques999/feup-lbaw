<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/resposta.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
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

  // verificar autor
  $idPergunta = safe_getId($_POST, 'idPergunta');
  $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  $paginaPergunta = "pergunta/view.php?id=$idPergunta#reply-$idResposta";
  $isSuperuser = utilizador_isAdministrator($idUtilizador) || utilizador_isModerator($idUtilizador);

  try {

    $idResposta = safe_getId($_POST, 'idResposta');
    $safeMessage = safe_trim($_POST, 'descricao');

    if (resposta_atualizarResposta($idResposta, $idUtilizador) > 0) {
      safe_redirect($paginaPergunta);
    }
    else {
      safe_error($paginaPergunta, 'Erro na operação, tentou editar uma resposta de outro utilizador?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>