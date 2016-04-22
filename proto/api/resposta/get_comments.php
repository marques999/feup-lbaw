<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_POST, 'idResposta')) {

    $idResposta = safe_getId($_POST, 'idResposta');

    if (safe_check($_POST, 'ultimoComentario')) {
      $ultimoComentario = safe_getId($_POST, 'ultimoComentario');
      $stmt = $db->prepare("SELECT
          ComentarioResposta.idComentario,
          Utilizador.idUtilizador,
          Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
          Contribuicao.descricao,
          Contribuicao.dataHora
        FROM ComentarioResposta
        JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
        JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
        WHERE ComentarioResposta.idResposta = :idResposta
        AND ComentarioResposta.idComentario > :ultimoComentario");
      $stmt->bindParam(":ultimoComentario", $ultimoComentario, PDO::PARAM_INT);
    }
    else {
      $stmt = $db->prepare("SELECT
          ComentarioResposta.idComentario,
          Utilizador.idUtilizador,
          Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
          Contribuicao.descricao,
          Contribuicao.dataHora
        FROM ComentarioResposta
        JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
        JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
        WHERE ComentarioResposta.idResposta = :idResposta");
    }

    $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
    $stmt->execute();
    echo json_encode($stmt->fetchAll());
  }
  else {
    http_response_code(400);
  }
?>