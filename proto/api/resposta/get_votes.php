<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_GET, 'id')) {    
    $idResposta = safe_getId($_GET, 'id');
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
?>