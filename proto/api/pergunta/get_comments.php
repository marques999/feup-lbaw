<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/pergunta.php');

  if (safe_check($_POST, 'idPergunta')) {

    $idPergunta = safe_getId($_POST, 'idPergunta');

    if (safe_check($_POST, 'ultimoComentario')) {

      try {
        echo pergunta_fetchCommentsAfter($idPergunta, safe_getId($_POST, 'ultimoComentario'));
      }
      catch (PDOException $e) {
        http_response_code(400);
      }
    }
    else {

      try {
        echo pergunta_fetchCommentsJson($idPergunta);
      }
      catch (PDOException $e) {
        http_response_code(400);
      }
    }
  }
  else {
    http_response_code(400);
  }
?>