<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

    if (safe_check($_POST, 'idPergunta')) {

      $idPergunta = safe_getId($_POST, 'idPergunta');
      $stmt = $db->prepare("INSERT INTO Seguidor(idSeguidor, idPergunta) VALUES(:idUtilizador, :idPergunta)");
      $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
      $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
      $stmt->execute();

      if ($stmt->rowCount() > 0) {

        $stmt = $db->prepare("SELECT COUNT(*) FROM Seguidor WHERE idPergunta = :idPergunta");
        $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);

        try {
          $stmt->execute();
        }
        catch (PDOException $e) {
          http_response_code(400);
        }

        echo json_encode($stmt->fetch());
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