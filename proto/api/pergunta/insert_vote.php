<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta') && safe_check($_POST, 'votoUtilizador')) {

      $idPergunta = safe_getId($_POST, 'idPergunta');
      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

      try {
        pergunta_registarVoto($idPergunta, $idUtilizador, $_POST['votoUtilizador']);
      }
      catch (PDOException $e) {
        http_response_code(400);
      }

      try {
        echo pergunta_fetchVotesJson($idPergunta);
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