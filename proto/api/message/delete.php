<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $returnValue = 0;

  if (safe_check($_POST, 'idMensagem') && safe_check($_SESSION, 'idUtilizador')) {
    $idMensagem = safe_getId($_POST, 'idMensagem');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $stmt = $db->prepare("DELETE FROM Mensagem
      WHERE Mensagem.idMensagem = :idMensagem
      AND Mensagem.idAutor = :idUtilizador");
    $stmt->bindParam(":idMensagem", $idMensagem, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->execute();
    $returnValue = $stmt->rowCount();
  }

  echo json_encode($returnValue);
?>