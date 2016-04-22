<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta')) {

      if (safe_check($_POST, 'descricao')) {

        $idPergunta = safe_getId($_POST, 'idPergunta');
        $idResposta = safe_getId($_POST, 'idResposta');
        $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
        $safeMessage = safe_trim($_POST['descricao']);
        $stmt = $db->prepare("INSERT INTO Contribuicao(idContribuicao, idAutor. descricao)
          VALUES(DEFAULT, :idUtilizador, :descricao)");
        $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
        $stmt->bindParam(":descricao", $safeMessage, PDO::PARAM_STR);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
          safe_redirect(null);
        }
        else {
          safe_error(null, 'Erro na operação, outra resposta com este identificador já existe?');
        }
      }
      else {
        safe_error(null, 'O corpo da resposta não pode estar vazio!');
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