<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_POST, 'idConversa') && safe_check($_SESSION, 'idUtilizador')) {
    $idConversa = safe_getId($_POST, 'idConversa');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $stmt = $db->prepare("DELETE FROM Pergunta
      WHERE Pergunta.idConversa = :idConversa
      AND (Pergunta.idUtilizador1 = :idUtilizador
      OR Pergunta.idUtilizador2 = :idUtilizador)");
    $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->execute();
  }

  safe_redirect('pages/homepage.php');
?>