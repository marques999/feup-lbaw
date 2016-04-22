<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

    if (safe_check($_GET, 'id')) {

      $idPergunta = safe_getId($_GET, 'id');
      $stmt = $db->prepare("UPDATE Pergunta SET ativa = FALSE
        WHERE idPergunta = :idPergunta
        AND idAutor = :idUtilizador");
      $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
      $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);

      try {
        $stmt->execute();
      }
      catch (PDOException $e) {
        safe_error(null, $e->getMessage());
      }

      if ($stmt->rowCount() > 0) {
        safe_redirect(null);
      }
      else {
        safe_error(null, 'Erro na operação, a pergunta não existe?');
      }
    }
    else {
      safe_error(null, 'Deve especificar uma pergunta primeiro!');
    }
  }
  else {
    http_response_code(403);
  }
?>