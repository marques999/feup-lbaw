<?
  include_once('../../config/init.php');
  include_once('../../database/resposta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idResposta') && safe_check($_POST, 'votoUtilizador')) {

      try {
        resposta_registarVoto(
          safe_getId($_POST, 'idResposta'),
          safe_getId($_SESSION, 'idUtilizador'),
          safe_getVote($_POST, 'votoUtilizador')
        );
      }
      catch (PDOException $e) {
        http_response_code(400);
      }

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
  }
  else {
    http_response_code(403);
  }
?>