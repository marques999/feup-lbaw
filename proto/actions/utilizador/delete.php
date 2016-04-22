<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $isAdministrator = false;
    $ownAccount = !safe_check($_GET, 'id');

    if ($ownAccount) {
      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    }
    else {
      $idUtilizador = safe_getId($_GET, 'id');
      $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
      $isAdministrator = utilizador_isAdministrator($idUtilizador);
    }

    if ($ownAccount || $isAdministrator) {

      $stmt = $db->prepare('UPDATE Utilizador SET removido = TRUE WHERE idUtilizador = :idUtilizador');
      $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);

      try {
        $stmt->execute();
      }
      catch (PDOException $e) {
        safe_error(null, $e->getMessage());
      }

      if ($stmt->rowCount() > 0) {

        if ($isAdministrator) {
          safe_redirect('admin/utilizadores.php');
        }
        else {

          if (isset($_SESSION['username'])) {
            unset($_SESSION['username']);
          }

          if (isset($_SESSION['idUtilizador'])) {
            unset($_SESSION['idUtilizador']);
          }

          session_destroy();
          safe_redirect('homepage.php');
        }
      }
      else {
        safe_error(null, 'Erro na operação, utilizador inexistente?');
      }
    }
    else {
      http_response_code(403);
    }
  }
  else {
    http_response_code(403);
  }
?>