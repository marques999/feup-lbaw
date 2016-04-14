<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $stmt = $db->prepare('UPDATE Utilizador SET ativo = FALSE WHERE idUtilizador = :idUtilizador');
    $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);

    if ($stmt->rowCount() > 0) {
      
      if (isset($_SESSION['username'])) {
        unset($_SESSION['username']);
      }

      if (isset($_SESSION['idUtilizador'])) {
        unset($_SESSION['idUtilizador']);
      }

      session_destroy();
    }
  }

  safe_redirect(null);
?>