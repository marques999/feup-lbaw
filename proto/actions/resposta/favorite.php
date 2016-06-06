<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/resposta.php');

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
  
  if (!pergunta_verificarAutor($idPergunta, $idUtilizador)
      && !safe_checkModerador()
      && !safe_checkAdministrador()) {
    safe_redirect('403.php');
  }

  if (safe_check($_GET, 'idr')) {
    $idResposta = safe_getId($_GET, 'idr');
  }
  else {
    safe_error('Deve especificar uma resposta primeiro!');
  }

  try {

    if (resposta_destacarResposta($idPergunta, $idResposta) > 0) {
      safe_redirect("pergunta/view.php?id=$idPergunta");
    }
    else {
      safe_error('Erro na operação: tentou destacar uma resposta inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error($e->getMessage());
  }
?>