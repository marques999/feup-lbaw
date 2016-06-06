<?
function notificacao_novosComentarios($idSeguidor) {
  global $db;
  $stmt = $db->prepare("SELECT
      Pergunta.idPergunta,
      Pergunta.titulo,
      Autor.idUtilizador,
      Autor.username,
      Autor.primeiroNome || ' ' || Autor.ultimoNome AS nomeUtilizador,
      Autor.removido,
      Contribuicao.descricao,
      Contribuicao.dataHora
    FROM Seguidor
    NATURAL JOIN Pergunta
    NATURAL JOIN ComentarioPergunta
    INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
    INNER JOIN Utilizador Autor ON Autor.idUtilizador = Contribuicao.idUtilizador
    WHERE idSeguidor = :idSeguidor
    AND Contribuicao.dataHora >= dataAcesso");
  $stmt->bindParam(":idSeguidor", $idSeguidor, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function notificacao_novosSeguidores($idSeguidor) {
  global $db;
  $stmt = $db->prepare("SELECT
      Pergunta.idPergunta,
      Pergunta.titulo,
      Pergunta.descricao,
      Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.removido,
      Seguidor.dataInicio AS dataHora
    FROM Seguidor
    NATURAL JOIN Pergunta
    INNER JOIN Seguidor Seguidores
      ON Seguidores.idPergunta = Pergunta.idPergunta
      AND Seguidores.idSeguidor <> Seguidor.idSeguidor
    INNER JOIN Utilizador
      ON Utilizador.idUtilizador = Seguidores.idSeguidor
    WHERE Seguidor.idSeguidor = :idSeguidor
    AND Seguidores.dataInicio >= Seguidor.dataAcesso");
  $stmt->bindParam(":idSeguidor", $idSeguidor, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function notificacao_novasRespostas($idSeguidor) {
  global $db;
  $stmt = $db->prepare("SELECT
      Pergunta.idPergunta,
      Pergunta.titulo,
      Resposta.idResposta,
      Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.removido,
      Contribuicao.descricao,
      Contribuicao.dataHora
    FROM Seguidor
    INNER JOIN Pergunta USING(idPergunta)
    INNER JOIN Resposta USING(idPergunta)
    INNER JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
    INNER JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idUtilizador
    WHERE idSeguidor = :idSeguidor
    AND Contribuicao.dataHora >= dataAcesso");
  $stmt->bindParam(":idSeguidor", $idSeguidor, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
?>