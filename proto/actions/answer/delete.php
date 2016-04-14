<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_POST, 'idResposta') && safe_check($_SESSION, 'idUtilizador')) {
    $idResposta = safe_getId($_POST, 'idResposta');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $stmt = $db->prepare("DELETE FROM Contribuicao
      WHERE Contribuicao.idContribuicao = :idResposta
      AND Contribuicao.idAutor = :idUtilizador");
    $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->execute();
  }

  safe_redirect(null);
?>