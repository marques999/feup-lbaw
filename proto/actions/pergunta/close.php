<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_GET, 'id')) {
    $idPergunta = safe_getId($_GET, 'id');
  }
  else {
    safe_error('Deve especificar uma pergunta primeiro!');
  }

  if (pergunta_verificarAutor($idPergunta, $idUtilizador) || safe_checkModerador() || safe_checkAdministrador()) {

    try {

      if (pergunta_fecharPergunta($idPergunta) > 0) {
        safe_redirect("pergunta/view.php?id=$idPergunta");
      }
      else {
        safe_error('Erro desconhecido: tentou fechar uma pergunta inexistente?');
      }
    }
    catch (PDOException $e) {
      safe_error($e->getMessage());
    }
  }
  else {
    safe_redirect('403.php');
  }
?>