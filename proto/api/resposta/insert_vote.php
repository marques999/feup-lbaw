<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

      if (safe_check($_POST, 'idResposta') && safe_check($_POST, 'votoUtilizador')) {
        
        $idResposta = safe_getId($_POST, 'idResposta');
        $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
        $votoUtilizador = safe_getVote($_POST, 'votoUtilizador');  
        $stmt = $db->prepare("SELECT registarVotoResposta(:idResposta, :idUtilizador, :valor)");
        $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
        $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
        $stmt->bindParam(":valor", $votoUtilizador, PDO::PARAM_INT);
        $stmt->execute();
        $stmt = $db->prepare("SELECT
          COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
          COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
          COALESCE(COUNT(*), 0) AS pontuacao
          FROM VotoResposta
          WHERE idResposta = :idResposta
          GROUP BY idResposta");
        $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
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