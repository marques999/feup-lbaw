<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  $returnValue = 0;

  if (safe_check($_SESSION, 'idUtilizador') && safe_check($_POST, 'idInstituicao')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $safeEmail = safe_getId($_POST, 'idInstituicao');
    $stmt = $db->prepare('UPDATE Utilizador
      SET idInstituicao = :idInstituicao
      WHERE idUtilizador = :idUtilizador');
    $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
    $stmt->bindParam(':idInstituicao', $idInstituicao, PDO::PARAM_STR);
    $stmt->execute();
    $returnValue = $stmt->rowCount();
  }

  safe_redirect(null);
?>