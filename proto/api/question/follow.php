<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $returnValue = 0;

  if (safe_check($_POST, 'idPergunta') && safe_check($_SESSION, 'idUtilizador')) {
    $idPergunta = safe_getId($_POST, 'idPergunta');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $stmt = $db->prepare("INSERT INTO Seguidor(idSeguidor, idPergunta)
      VALUES(:idUtilizador, :idPergunta");
    $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->execute()
    $returnValue = $stmt->rowCount();
  }

  echo json_encode($returnValue);
?>