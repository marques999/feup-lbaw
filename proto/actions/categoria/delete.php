<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_GET, 'id')) {

      $idCategoria = safe_getId($_GET, 'id');
      $stmt = $db->prepare("DELETE FROM Categoria WHERE idCategoria = :idCategoria");
      $stmt->bindParam(":idCategoria", $idCategoria, PDO::PARAM_INT);

      try {
        $stmt->execute();
      }
      catch (PDOException $e) {
        safe_error('admin/categoria.php', $e->getMessage());
      }

      if ($stmt->rowCount() > 0) {
        safe_redirect('admin/categoria.php');
      }
      else {
        safe_error('admin/categoria.php', 'erro na operação, a categoria não existe?');
      }
    }
    else {
      safe_error('admin/categoria.php', 'deve especificar uma categoria primeiro!');
    }
  }
  else {
    http_response_code(403);
  }
?>