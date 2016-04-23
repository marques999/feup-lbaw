<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta') && safe_check($_POST, 'descricao')) {

      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
      $safeDescricao = safe_trim($_POST['descricao']);
      $stmt = $db->prepare("INSERT INTO Contribuicao(idContribuicao, idAutor, descricao) VALUES(DEFAULT, :idUtilizador, :descricao)");
      $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
      $stmt->bindParam(":descricao", $safeDescricao, PDO::PARAM_STR);
      $stmt->execute();

      $idComentario = $db->lastInsertId('contribuicao_idcontribuicao_seq');
      $idPergunta = safe_getId($_POST, 'idPergunta');
      $stmt = $db->prepare("INSERT INTO ComentarioPergunta(idComentario, idPergunta) VALUES(:idComentario, :idPergunta)");
      $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
      $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);

      try {
        $stmt->execute();
      }
      catch (PDOException $e) {
        http_response_code(400);
      }

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