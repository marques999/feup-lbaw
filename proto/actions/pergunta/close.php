<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!safe_check($_GET, 'id')) {
    safe_error(null, 'Deve especificar uma pergunta primeiro!');
  }

  $idPergunta = safe_getId($_GET, 'id');
  $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  $isOriginalPoster = pergunta_verificarAutor($idPergunta, $idUtilizador);
  $isAdministrator = utilizador_isAdministrator($idUtilizador);
  $isModerator = utilizador_isModerator($idUtilizador);

  if (!$isOriginalPoster && !$isModerator && !$isAdministrator) {
    safe_redirect('403.php');
  }

  try {

    if (pergunta_fecharPergunta($idPergunta, $idUtilizador) > 0) {
      safe_redirect("pergunta/view.php?id=$idPergunta");
    }
    else {
      safe_error(null, 'Erro desconhecido: tentou fechar uma pergunta inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>