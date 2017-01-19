<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
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
    safe_error('Deve especificar uma pergunta primeiro!');
  }

  if (!pergunta_verificarAutor($idPergunta, $idUtilizador) && !safe_checkAdministrador()) {
    safe_redirect('403.php');
  }

  try {

    if (pergunta_apagarPergunta($idPergunta) > 0) {
      safe_redirect('homepage.php');
    }
    else {
      safe_error('Erro desconhecido: tentou apagar uma pergunta inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error($e->getMessage());
  }
?>