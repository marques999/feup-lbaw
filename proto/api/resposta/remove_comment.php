<?
  include_once('../../config/init.php');
  include_once('../../database/resposta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idResposta') && safe_check($_POST, 'idComentario')) {

      $idComentario = safe_getId($_POST, 'idComentario');
      $idResposta = safe_getId($_POST, 'idResposta');
      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

      try {
        echo resposta_removerComentario($idResposta, $idComentario, $idUtilizador);
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