<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_POST, 'idPergunta') && safe_check($_SESSION, 'idUtilizador')) {
    $idPergunta = safe_getId($_POST, 'idPergunta');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $stmt = $db->prepare("DELETE FROM Pergunta
      WHERE Pergunta.idPergunta = :idPergunta
      AND Pergunta.idAutor = :idUtilizador");
    $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->execute();
  }

  safe_redirect('pages/homepage.php');
?>