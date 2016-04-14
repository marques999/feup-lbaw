<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $returnValue = 0;

  if (safe_check($_POST, 'idComentario') && safe_check($_SESSION, 'idUtilizador')) {
    $idComentario = safe_getId($_POST, 'idComentario');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $stmt = $db->prepare("DELETE FROM Contribuicao
      WHERE Contribuicao.idContribuicao = :idComentario
      AND Contribuicao.idAutor = :idUtilizador");
    $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->execute();
    $returnValue = $stmt->rowCount();
  }

  echo json_encode($returnValue);
?>