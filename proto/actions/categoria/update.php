<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idCategoria')) {

      $idCategoria = safe_getId($_GET, 'id');

      if ($safe_check($_POST, 'nome')) {

        $stmt = $db->prepare("UPDATE Categoria SET nome = :nome WHERE idInstituicao = :idInstituicao");
        $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);

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
          safe_error('admin/categoria.php', 'Erro na operação, categoria inexistente?');
        }
      }
      else {
        safe_error('admin/categoria.php', 'Operação sem efeito, nenhum campo foi alterado...');
      }
    }
    else {
      safe_error('admin/categoria.php', 'Deve especificar uma categoria primeiro!');
    }
  }
  else {
    http_response_code(403);
  }
?>