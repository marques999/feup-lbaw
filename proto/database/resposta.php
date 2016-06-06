<?
function resposta_listByAuthor($idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT Resposta.idResposta,
      Pergunta.idPergunta,
      Pergunta.titulo,
      Pergunta.ativa,
      Contribuicao.descricao,
      Contribuicao.dataHora,
      Resposta.melhorResposta,
      COALESCE(COUNT(valor) FILTER (WHERE valor = 1), 0) AS votosPositivos,
      COALESCE(COUNT(valor) FILTER (WHERE valor = -1), 0) AS votosNegativos,
      COALESCE(SUM(valor), 0) AS pontuacao
    FROM Contribuicao
    INNER JOIN Resposta ON Contribuicao.idContribuicao = Resposta.idResposta
    INNER JOIN Utilizador USING(idUtilizador)
    INNER JOIN Pergunta USING (idPergunta)
    LEFT JOIN VotoResposta USING(idResposta)
    WHERE Contribuicao.idUtilizador = :idUtilizador
    GROUP BY Contribuicao.idContribuicao, Pergunta.idPergunta, Resposta.idResposta
    ORDER BY Contribuicao.dataHora DESC");
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function resposta_listById($idContribuicao) {
  global $db;
  $stmt = $db->prepare("SELECT Resposta.idResposta,
      Pergunta.idPergunta,
      Pergunta.titulo,
      Pergunta.descricao,
      Pergunta.dataHora,
      Contribuicao.descricao,
      Contribuicao.dataHora,
      Contribuicao.idUtilizador,
      Resposta.melhorResposta
    FROM Contribuicao
    INNER JOIN Resposta ON idContribuicao = idResposta
    INNER JOIN Pergunta USING (idPergunta)
    WHERE idContribuicao = :idContribuicao
    LIMIT 1");
  $stmt->bindParam(':idContribuicao', $idContribuicao, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function resposta_verificarAutor($idContribuicao, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT idUtilizador FROM Contribuicao
    WHERE idContribuicao = :idContribuicao
    AND idUtilizador = :idUtilizador");
  $stmt->bindParam(":idContribuicao", $idContribuicao, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  $result = $stmt->fetch();
  return $result && is_array($result);
}
function resposta_inserirResposta($idPergunta, $idUtilizador, $descricao) {
  global $db;
  $db->beginTransaction();
  $stmt = $db->prepare("WITH NovaResposta AS (
    INSERT INTO Contribuicao(idContribuicao, idUtilizador, descricao)
    VALUES(DEFAULT, :idUtilizador, :descricao) RETURNING idContribuicao
  ) INSERT INTO Resposta(idResposta, idPergunta)
    SELECT idContribuicao, :idPergunta
    FROM NovaResposta");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(":descricao", $descricao, PDO::PARAM_STR);
  $stmt->execute();
  $db->commit();
  if ($stmt->rowCount()>0) {
    return $db->lastInsertId('contribuicao_idcontribuicao_seq');
  }
  return 0;
}
function resposta_editarResposta($idContribuicao, $descricao) {
  global $db;
  $stmt = $db->prepare("UPDATE Contribuicao
    SET descricao = :descricao
    WHERE idContribuicao = :idContribuicao");
  $stmt->bindParam(":idContribuicao", $idContribuicao, PDO::PARAM_INT);
  $stmt->bindParam(":descricao", $descricao, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function resposta_apagarResposta($idContribuicao, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("DELETE FROM Contribuicao
    WHERE idContribuicao = :idContribuicao");
  $stmt->bindParam(":idContribuicao", $idContribuicao, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function resposta_destacarResposta($idPergunta, $idResposta) {
  global $db;
  $stmt = $db->prepare("UPDATE Resposta
    SET melhorResposta = TRUE
    WHERE idPergunta = :idPergunta
    AND idResposta = :idResposta");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function resposta_inserirComentario($idResposta, $idUtilizador, $descricao) {
  global $db;
  $db->beginTransaction();
  $stmt = $db->prepare("WITH NovoComentario AS (
    INSERT INTO Contribuicao(idContribuicao, idUtilizador, descricao)
    VALUES(DEFAULT, :idUtilizador, :descricao) RETURNING idContribuicao
  ) INSERT INTO ComentarioResposta(idComentario, idResposta)
    SELECT idContribuicao, :idResposta
    FROM NovoComentario");
  $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(":descricao", $descricao, PDO::PARAM_STR);
  $stmt->execute();
  $db->commit();
  return json_encode($stmt->rowCount());
}
function resposta_removerComentario($idResposta, $idComentario, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("DELETE FROM ComentarioResposta
    WHERE idComentario = :idComentario
    AND idResposta = :idResposta");
  $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
  $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
  $stmt->execute();
  if ($stmt->rowCount() > 0) {
    $stmt = $db->prepare("DELETE FROM Contribuicao
      WHERE idContribuicao = :idComentario
      AND idUtilizador = :idUtilizador");
    $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->execute();
  }
  return json_encode($stmt->rowCount());
}
function resposta_registarVoto($idResposta, $idUtilizador, $valor) {
  global $db;
  $stmt = $db->prepare("SELECT registarVotoResposta(:idResposta, :idUtilizador, :valor)");
  $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(":valor", $valor, PDO::PARAM_INT);
  $stmt->execute();
}
function resposta_fetchVotos($idResposta) {
  global $db;
  $stmt = $db->prepare("SELECT
      COALESCE(COUNT(valor) FILTER (WHERE valor = 1), 0) AS votosPositivos,
      COALESCE(COUNT(valor) FILTER (WHERE valor = -1), 0) AS votosNegativos,
      COALESCE(SUM(valor), 0) AS pontuacao
    FROM VotoResposta
    WHERE idResposta = :idResposta
    GROUP BY idResposta");
  $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function resposta_fetchComments($idResposta) {
  global $db;
  $stmt = $db->prepare("SELECT
      Contribuicao.idContribuicao,
      Contribuicao.descricao,
      to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') as dataHora,
      Utilizador.idUtilizador,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.removido
    FROM ComentarioResposta
    INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
    NATURAL JOIN Utilizador
    WHERE idResposta = :idResposta
    ORDER BY idContribuicao");
  $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function resposta_fetchCommentsAfter($idResposta, $ultimoComentario) {
  global $db;
  $stmt = $db->prepare("SELECT
      Contribuicao.idContribuicao,
      Contribuicao.descricao,
      to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') as dataHora,
      Utilizador.idUtilizador,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.removido
    FROM ComentarioResposta
    INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
    NATURAL JOIN Utilizador
    WHERE idResposta = :idResposta
    AND idComentario > :ultimoComentario
    ORDER BY idContribuicao");
  $stmt->bindParam(":ultimoComentario", $ultimoComentario, PDO::PARAM_INT);
  $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
  $stmt->execute();
  return json_encode($stmt->fetchAll());
}
function resposta_fetchVotosJson($idResposta) {
  return json_encode(resposta_fetchVotos($idResposta));
}
function resposta_fetchCommentsJson($idResposta) {
  return json_encode(resposta_fetchComments($idResposta));
}
?>