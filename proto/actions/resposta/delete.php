<?
  include_once('../../config/init.php');
  include_once('../../database/resposta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_GET, 'idp')) {
    $idPergunta = safe_getId($_GET, 'idp');
  }
  else {
    safe_error('Deve especificar uma pergunta primeiro!');
  }

  if (safe_check($_GET, 'idr')) {
    $idResposta = safe_getId($_GET, 'idr');
  }
  else {
    safe_error('Deve especificar uma resposta primeiro!');
  }

  if (resposta_verificarAutor($idResposta, $idUtilizador) || safe_checkModerador() || safe_checkAdministrador()) {

    try {

      if (resposta_apagarResposta($idResposta) > 0) {
        safe_redirect("pergunta/view.php?id=$idPergunta");
      }
      else {
        safe_error('Erro na operação: tentou apagar uma resposta inexistente?');
      }
    }
    catch (PDOException $e) {
      safe_error($e->getMessage());
    }
  }
  else {
    //safe_redirect('403.php');
  }
?>