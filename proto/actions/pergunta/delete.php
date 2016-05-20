<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('Deve estar autenticado para aceder a esta página!', 'utilizador/login.php');
  }

  if (safe_check($_POST, 'idPergunta')) {
    $idPergunta = safe_getId($_POST, 'idPergunta');
  }
  else {
    safe_error('Deve especificar uma pergunta primeiro!');
  }

  $isOriginalPoster = pergunta_verificarAutor($idPergunta, $idUtilizador);
  $isAdministrator = utilizador_isAdministrator($idUtilizador);

  if (!$isOriginalPoster && !$isAdministrator) {
    safe_redirect('403.php');
  }

  try {

    if (pergunta_apagarPergunta($idPergunta, $idUtilizador) > 0) {
      safe_redirect(null);
    }
    else {
      safe_error('Erro desconhecido: tentou apagar uma pergunta inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error($e->getMessage());
  }
?>