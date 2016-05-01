<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta')) {

      $idPergunta = safe_getId($_POST, 'idPergunta');
      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

      if (pergunta_followPergunta($idPergunta, $idUtilizador) > 0) {

        try {
          echo pergunta_contarSeguidores($idPergunta);
        }
        catch (PDOException $e) {
          http_response_code(400);
        }
      }
      else {
        http_response_code(400);
      }
    }
    else {
      http_response_code(400);
    }
  }
  else {
    http_response_code(403);
  }
?>