<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta') && safe_check($_POST, 'idComentario')) {

      $idComentario = safe_getId($_POST, 'idComentario');
      $idPergunta = safe_getId($_POST, 'idPergunta');
      $stmt = $db->prepare("DELETE FROM ComentarioPergunta
        WHERE idComentario = :idComentario
        AND idPergunta = :idPergunta");
      $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
      $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
      $stmt->execute();

      if ($stmt->rowCount() > 0) {
        $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
        $stmt = $db->prepare("DELETE FROM Contribuicao
          WHERE idContribuicao = :idComentario
          AND idAutor = :idUtilizador");
        $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
        $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
          http_response_code(200);
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
      http_response_code(400);
    }
  }
  else {
    http_response_code(403);
  }
?>