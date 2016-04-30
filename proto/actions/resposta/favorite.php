<?
  include_once('../../config/init.php');
  include_once('../../database/resposta.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!safe_check($_GET, 'idp')) {
    safe_error(null, 'Deve especificar uma pergunta primeiro!');
  }

  if (!safe_check($_GET, 'idr')) {
    safe_error(null, 'Deve especificar uma resposta primeiro!');
  }

  try {

    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $idPergunta = safe_getId($_GET, 'idp');
    $idResposta = safe_getId($_GET, 'idr');

    if (resposta_destacarResposta($idPergunta, $idResposta) > 0) {
      safe_redirect("pergunta/view.php?id=$idPergunta");
    }
    else {
      safe_error(null, 'Erro na operação, tentou apagar uma resposta inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>