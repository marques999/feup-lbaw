<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

    if (safe_check($_POST, 'id')) {

      $idPergunta = safe_getId($_POST, 'id');
      $stmt = $db->prepare("DELETE FROM Seguidor
        WHERE idSeguidor = :idUtilizador
        AND idPergunta = :idPergunta");
      $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
      $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
      $stmt->execute();

      echo json_encode($stmt->rowCount());
    }
    else {
      http_response_code(400);
    }
  }
  else {
    http_response_code(403);
  }
?>