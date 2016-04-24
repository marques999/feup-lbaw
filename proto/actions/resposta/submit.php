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

  if (!safe_check($_POST, 'descricao')) {
    safe_error(null, 'O corpo da resposta não pode estar em branco!');
  }

  try {

    $idPergunta = safe_getId($_POST, 'idPergunta');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $safeMessage = safe_trim($_POST['descricao']);

    if (resposta_inserirResposta($idPergunta, $idUtilizador, $safeMessage) > 0) {
      $idResposta = $db->lastInsertId('contribuicao_idcontribuicao_seq');
      safe_redirect("pergunta/view.php?=$idPergunta#reply-$idResposta");
    }
    else {
       safe_error(null, 'Erro na operação, outra resposta com este identificador já existe?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>