<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idResposta') && safe_check($_POST, 'descricao')) {
          
      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
      $safeDescricao = safe_trim($_POST['descricao']);
      $stmt = $db->prepare("INSERT INTO Contribuicao(idAutor, descricao) VALUES(:idUtilizador, :descricao)");
      $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
      $stmt->bindParam(":descricao", $safeDescricao, PDO::PARAM_STR);
      $stmt->execute();

      $idComentario = $idConversa = $db->lastInsertId('contribuicao_idcontribuicao_seq');
      $idResposta = safe_getId($_POST, 'idResposta');
      $stmt = $db->prepare("INSERT INTO ComentarioResposta(idComentario, idResposta) VALUES(:idComentario, :idResposta)");
      $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
      $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
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