<?
  include_once('../../config/init.php');
  include_once('../../database/resposta.php');

  if (safe_check($_POST, 'idResposta')) {

    try {
      echo resposta_fetchVotosJson(safe_getId($_POST, 'idResposta'));
    }
    catch (PDOException $e) {
      http_response_code(400);
    }
  }
  else {
    http_response_code(400);
  }
?>