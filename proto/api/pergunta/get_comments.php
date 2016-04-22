<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_POST, 'idPergunta')) {

    $idPergunta = safe_getId($_POST, 'idPergunta');

    if (safe_check($_POST, 'ultimoComentario')) {
      $ultimoComentario = safe_getId($_POST, 'ultimoComentario');
      $stmt = $db->prepare("SELECT
          ComentarioPergunta.idComentario,
          Utilizador.idUtilizador,
          Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
          Contribuicao.descricao,
          Contribuicao.dataHora
        FROM ComentarioPergunta
        JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
        JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
        WHERE ComentarioPergunta.idPergunta = :idPergunta
        AND ComentarioPergunta.idComentario > :ultimoComentario");
      $stmt->bindParam(":ultimoComentario", $ultimoComentario, PDO::PARAM_INT);
    }
    else {
      $stmt = $db->prepare("SELECT
          ComentarioPergunta.idComentario,
          Utilizador.idUtilizador,
          Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
          Contribuicao.descricao,
          Contribuicao.dataHora
        FROM ComentarioPergunta
        JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
        JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
        WHERE ComentarioPergunta.idPergunta = :idPergunta");
    }

    $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
    $stmt->execute();
    echo json_encode($stmt->fetchAll());
  }
  else {
    http_response_code(400);
  }
?>