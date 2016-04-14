<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/utilizador.php');

  $returnValue = 0;

  if (safe_check($_SESSION, 'idUtilizador') && safe_check($_POST, 'email')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $safeEmail = safe_trim($_POST, 'email');
    $stmt = $db->prepare('UPDATE Utilizador
      SET email = :email
      WHERE idUtilizador = :idUtilizador');
    $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
    $stmt->bindParam(':email', $safeEmail, PDO::PARAM_STR);
    $stmt->execute();
    $returnValue = $stmt->rowCount();
  }

  safe_redirect(null);
?>