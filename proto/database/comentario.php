<?
function comentario_verificarAutor($idContribuicao, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT idUtilizador FROM Contribuicao
    WHERE idContribuicao = :idContribuicao
    AND idUtilizador = :idUtilizador");
  $stmt->bindParam(":idContribuicao", $idContribuicao, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $result = $stmt->execute();
  return $result && is_array($result);
}
?>