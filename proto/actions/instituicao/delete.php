<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_GET, 'id')) {

      $idInstituicao = safe_getId($_GET, 'id');
      $stmt = $db->prepare("DELETE FROM Instituicao WHERE idInstituicao = :idInstituicao");
      $stmt->bindParam(":idInstituicao", $idInstituicao, PDO::PARAM_INT);

      try {
        $stmt->execute();
      }
      catch (PDOException $e) {
        safe_error('admin/instituicao.php', $e->getMessage());
      }

      if ($stmt->rowCount() > 0) {
        safe_redirect('admin/instituicao.php');
      }
      else {
        safe_error('admin/instituicao.php', 'Erro na operação, a instituição não existe?');
      }
    }
    else {
      safe_error('admin/instituicao.php', 'Deve especificar uma instituição primeiro!');
    }
  }
  else {
    http_response_code(403);
  }
?>