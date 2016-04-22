<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idInstituicao')) {
  
      $queryString = "UPDATE Instituicao SET ";
      $hasNome = $safe_check($_POST, 'nome');
      $numberColumns = 0;

      if ($hasNome) {
        $queryString += "nome = :nome";
        $numberColumns++;
      }

      $hasSigla = $safe_check($_POST, 'sigla');

      if ($hasSigla) {
        $queryString += ($numberColumns > 0 ? ' AND sigla = :sigla' : 'sigla = :sigla');
        $numberColumns++;
      }

      $hasMorada = $safe_check($_POST, 'morada');

      if ($hasMorada) {
        $queryString += ($numberColumns > 0 ? ' AND morada = :morada' : 'morada = :morada');
        $numberColumns++;
      }

      $hasContacto = $safe_check($_POST, 'contacto');

      if ($hasContacto) {
        $queryString += ($numberColumns > 0 ? ' AND contacto = :contacto' : 'contacto = :contacto');
        $numberColumns++;
      }

      $hasWebsite = $safe_check($_POST, 'website');

      if ($hasWebsite) {
        $queryString += ($numberColumns > 0 ? ' AND website = :website' : 'website = :website');
      }

      $queryString += ' WHERE idInstituicao = :idInstituicao';

      if ($numberColumns > 0) {
        
        $idInstituicao = safe_getId($_GET, 'id');
        $stmt = $db->prepare($queryString);
        $stmt->bindParam(":idInstituicao", $idInstituicao, PDO::PARAM_INT);

        if ($hasNome) {
          $safeNome = safe_trim($_POST, 'nome');
          $stmt->bindParam(':nome', $safeNome, PDO::PARAM_STR);
        }

        if ($hasSigla) {
          $safeSigla = safe_trim($_POST, 'sigla');
          $stmt->bindParam(':sigla', $safeSigla, PDO::PARAM_STR);
        }

        if ($hasMorada) {
          $safeMorada = safe_trim($_POST, 'morada');
          $stmt->bindParam(':morada', $safeMorada, PDO::PARAM_STR);
        }

        if ($hasContacto) {
          $safeContacto = safe_trim($_POST, 'contacto');
          $stmt->bindParam(':contacto', $safeContacto, PDO::PARAM_STR);
        }

        if ($hasWebsite) {
          $safeWebsite = safe_trim($_POST, 'website');
          $stmt->bindParam(':website', $safeWebsite, PDO::PARAM_STR);
        }
        
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
         safe_error('admin/instituicao.php', 'Operação sem efeito, nenhum campo foi alterado...');
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