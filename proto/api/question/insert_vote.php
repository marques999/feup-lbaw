<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $returnValue = 0;

  if (safe_check($_POST, 'idPergunta') && safe_check($_SESSION, 'idUtilizador')) {
    $idPergunta = safe_getId($_POST, 'idPergunta');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $votoUtilizador = safe_getVote($_POST['votoUtilizador']);
    $stmt = $db->prepare("SELECT registarVotoPergunta(:idPergunta, :idUtilizador, :valor)");
    $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->bindParam(":valor", $votoUtilizador, PDO::PARAM_INT);
    $returnValue = $stmt->execute();
  }

  echo json_encode($returnValue);
?>