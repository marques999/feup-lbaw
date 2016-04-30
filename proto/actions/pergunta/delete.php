<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!safe_check($_POST, 'idPergunta')) {
    safe_error(null, 'Deve especificar uma pergunta primeiro!');
  }

  try {

    $idPergunta = safe_getId($_POST, 'idPergunta');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

    if (pergunta_apagarPergunta($idPergunta, $idUtilizador) > 0) {
      safe_redirect(null);
    }
    else {
      safe_error(null, 'Erro na operação, tentou apagar uma pergunta de outro utilizador?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>