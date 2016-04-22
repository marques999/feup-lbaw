<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta')) {

      $queryString = "UPDATE Pergunta SET ";
      $hasTitulo = $safe_check($_POST, 'titulo');
      $numberColumns = 0;

      if ($hasTitulo) {
        $queryString += "titulo = :titulo";
        $numberColumns++;
      }

      $hasDescricao = $safe_check($_POST, 'descricao');

      if ($hasDescricao) {
        $queryString += ($numberColumns > 0 ? ' AND descricao = :descricao' : 'descricao = :descricao');
        $numberColumns++;
      }

      $queryString += ' WHERE idPergunta = :idPergunta';

      if ($numberColumns > 0) {

        $idPergunta = safe_getId($_POST, 'idPergunta');
        $stmt = $db->prepare($queryString);
        $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);

        if ($hasTitulo) {
          $safeTitulo = safe_trim($_POST, 'titulo');
          $stmt->bindParam(':titulo', $safeTitulo, PDO::PARAM_STR);
        }

        if ($hasDescricao) {
          $safeDescricao = safe_trim($_POST, 'descricao');
          $stmt->bindParam(':descricao', $safeDescricao, PDO::PARAM_STR);
        }

        try {
          $stmt->execute();
        }
        catch (PDOException $e) {
          safe_error(null, $e->getMessage());
        }

        if ($stmt->rowCount() > 0) {
            safe_redirect('admin/instituicao.php');
        }
        else {
          safe_error(null, 'Erro na operação, a pergunta não existe?');
        }
      }
      else {
         safe_error(null, 'Operação sem efeito, nenhum dos campos foi alterado...');
      }
    }
    else {
      safe_error(null, 'Deve especificar uma pergunta primeiro!');
    }
  }
  else {
    http_response_code(403);
  }
?>