<?
  function resposta_fetchComments($idResposta) {
    global $db;
    $stmt = $db->prepare("SELECT
        Utilizador.idUtilizador,
        Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
        Contribuicao.descricao,
        Contribuicao.dataHora
      FROM ComentarioResposta
      JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
      JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
      WHERE ComentarioResposta.idResposta = :idResposta
      LIMIT 5");
    $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
  }
  function pergunta_fetchAnswers($idPergunta) {
    global $db;
    $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
  }
?>