<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta')) {

      $hasCategoria = safe_check($_POST, 'idCategoria');
      $queryString = "UPDATE Pergunta SET ";
      $numberColumns = 0;

      if ($hasCategoria) {
        $queryString .= 'idCategoria = :idCategoria';
        $numberColumns++;
      }

      $hasTitulo = safe_check($_POST, 'titulo');

      if ($hasTitulo) {
        $queryString += ($numberColumns > 0 ? : ' AND titulo = :titulo' : 'titulo = :titulo';
        $numberColumns++;
      }

      $hasDescricao = safe_check($_POST, 'descricao');

      if ($hasDescricao) {
        $queryString += ($numberColumns > 0 ? ' AND descricao = :descricao' : 'descricao = :descricao');
        $numberColumns++;
      }

      $queryString += ' WHERE idPergunta = :idPergunta AND idAutor = :idUtilizador';

      if ($numberColumns > 0) {

        $idPergunta = safe_getId($_POST, 'idPergunta');
        $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
        $stmt = $db->prepare($queryString);
        $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
        $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);

        if ($hasCategoria) {
          $safeCategoria = safe_getId($_POST, 'idCategoria');
          $stmt->bindParam(":idCategoria", $idCategoria, PDO::PARAM_INT);
        }

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
          safe_redirect("pergunta/view.php?id=$idPergunta");
        }
        else {
          safe_error(null, 'Erro na operação, tentou editar uma pergunta de outro utilizador?');
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
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }
?>