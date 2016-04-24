<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/pergunta.php');

  if (safe_check($_POST, 'idPergunta')) {

    try {
      echo pergunta_fetchVotesJson(safe_getId($_POST, 'idPergunta'));
    }
    catch (PDOException $e) {
      http_response_code(400);
    }
  }
  else {
    http_response_code(400);
  }
?>