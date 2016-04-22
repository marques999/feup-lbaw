<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta') && safe_check($_POST, 'idResposta') && safe_check($_POST, 'descricao')) {

      $idPergunta = safe_getId($_POST, 'idPergunta');
      $idResposta = safe_getId($_POST, 'idResposta');
      $stmt = $db->prepare("SELECT idPergunta FROM Resposta WHERE idResposta = :idResposta");
      $stmt->bindParam(':idResposta', $idResposta, PDO::PARAM_INT);
      $stmt->execute();

      if (count($stmt->fetchAll()) > 0) {

        $safeMessage = safe_trim($_POST['descricao']);
        $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
        $stmt = $db->prepare("UPDATE Contribuicao SET descricao = :descricao
          WHERE idContribuicao = :idResposta AND idAutor = :idUtilizador");
        $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
        $stmt->bindParam(":descricao", $safeMessage, PDO::PARAM_STR);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            safe_redirect(null);
        }
        else {
          safe_error("pergunta/view.php?id=$idPergunta", 'Erro na operação: tentou editar uma resposta de outro utilizador, ou pergunta inexistente...');
        }
      }
      else {
        safe_error("pergunta/view.php?id=$idPergunta", 'O par de identificadores pergunta/resposta especificado não existe!');
      }
    }
    else {
      safe_error('homepage.php', 'Deve especificar todos os parâmetros da operação primeiro!');
    }
  }
  else {
    http_response_code(403);
  }
?>