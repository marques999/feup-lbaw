<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta') && safe_check($_POST, 'votoUtilizador')) {

      try {
        pergunta_registarVoto(
          safe_getId($_POST, 'idPergunta'),
          safe_getId($_SESSION, 'idUtilizador'),
          safe_getVote($_POST, 'votoUtilizador')
        );
      }
      catch (PDOException $e) {
        http_response_code(400);
      }

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
  }
  else {
    http_response_code(403);
  }
?>