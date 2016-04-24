<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/resposta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idResposta') && safe_check($_POST, 'votoUtilizador')) {

      $idResposta = safe_getId($_POST, 'idResposta');
      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

      try {
        resposta_registarVoto($idResposta, $idUtilizador, $_POST['votoUtilizador']);
      }
      catch (PDOException $e) {
        http_response_code(400);
      }

      try {
        echo resposta_fetchVotosJson($idResposta);
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