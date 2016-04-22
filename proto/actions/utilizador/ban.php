<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
    $isAdministrator = utilizador_isAdministrator($idUtilizador);

    if ($isAdministrator) {

      if (safe_check($_GET, 'id')) {
        $idUtilizador =
        $stmt = $db->prepare('UPDATE Utilizador SET ativo = FALSE WHERE idUtilizador = :idUtilizador');
        $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);

        try {
          $stmt->execute();
        }
        catch (PDOException $e) {
          safe_error(null, $e->getMessage());
        }

        if ($stmt->rowCount() > 0) {
          safe_redirect('admin/utilizadores.php');
        }
        else {
          safe_error(null, 'Erro na operação, utilizador inexistente?');
        }
      }
      else {
        safe_error(null, 'Deve especificar uma utilizador primeiro!');
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