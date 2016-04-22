<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

      if (safe_check($_POST, 'idPergunta') && safe_check($_POST, 'votoUtilizador')) {

        $idPergunta = safe_getId($_POST, 'idPergunta');
        $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
        $votoUtilizador = safe_getVote($_POST, 'votoUtilizador');
        $stmt = $db->prepare("SELECT registarVotoPergunta(:idPergunta, :idUtilizador, :valor)");
        $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
        $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
        $stmt->bindParam(":valor", $votoUtilizador, PDO::PARAM_INT);
        $stmt->execute();
        $stmt = $db->prepare("SELECT
          COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
          COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
          COALESCE(COUNT(*), 0) AS pontuacao
          FROM VotoPergunta
          WHERE idPergunta = :idPergunta
          GROUP BY idPergunta");
        $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
        $stmt->execute();
        echo json_encode($stmt->fetch());
      }
      else {
        http_response_code(400);
      }
  }
  else {
    http_response_code(403);
  }
?>