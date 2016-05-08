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
    FROM Resposta
    INNER JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
    LEFT JOIN VotoResposta USING(idResposta)
    INNER JOIN Pergunta USING (idPergunta)
    INNER JOIN Utilizador USING(idUtilizador)
    WHERE Contribuicao.idUtilizador = :idUtilizador
    GROUP BY Contribuicao.idContribuicao, Pergunta.idPergunta, Resposta.idResposta
    ORDER BY Contribuicao.dataHora DESC");
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function resposta_verificarAutor($idContribuicao, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT FROM Contribuicao
    WHERE idContribuicao = :idContribuicao
    AND idUtilizador = :idUtilizador");
  $stmt->bindParam(":idContribuicao", $idContribuicao, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $result = $stmt->execute();
  return $result && is_array($result);
}
function resposta_inserirResposta($idPergunta, $idUtilizador, $descricao) {
  global $db;
  $stmt = $db->prepare("INSERT INTO Contribuicao(idContribuicao, idUtilizador. descricao)
    VALUES(DEFAULT, :idUtilizador, :descricao)");
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(":descricao", $safeMessage, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function resposta_editarResposta($idResposta, $descricao) {
  global $db;
  $stmt = $db->prepare("UPDATE Contribuicao
    SET descricao = :descricao
    WHERE idContribuicao = :idResposta
    AND idUtilizador = :idUtilizador");
  $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
  $stmt->bindParam(":descricao", $safeMessage, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function resposta_apagarResposta($idResposta, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("DELETE FROM Contribuicao WHERE idContribuicao = :idResposta");
  $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
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
  $stmt = $db->prepare("INSERT INTO Contribuicao(idContribuicao, idUtilizador, descricao)
    VALUES(DEFAULT, :idUtilizador, :descricao)");
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(":descricao", $descricao, PDO::PARAM_STR);
  $stmt->execute();
  $idComentario = $db->lastInsertId('contribuicao_idcontribuicao_seq');
  $stmt = $db->prepare("INSERT INTO ComentarioResposta(idComentario, idResposta)
    VALUES(:idComentario, :idResposta)");
  $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
  $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
  $stmt->execute();
  return json_encode($stmt->rowCount());
}
function resposta_removerComentario($idResposta, $idComentario, $idUtilizador) {
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
    WHERE idResposta = :idResposta");
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
    AND idComentario > :ultimoComentario");
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
function resposta_getStats($filterBy) {
  global $db;
  $queryString = "SELECT
      Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      MAX(Contribuicao.idContribuicao) AS ultimaResposta,
      MAX(Contribuicao.dataHora) AS dataHora,
      COALESCE(COUNT(Resposta.idResposta), 0) AS count
    FROM Resposta
    INNER JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
    NATURAL JOIN Utilizador
    GROUP BY Utilizador.idUtilizador";
  if ($filterBy == 'day') {
    $queryString .= " HAVING MAX(dataHora) > current_date - interval '1 day' ";
  }
  else if ($filterBy == 'week') {
    $queryString .= " HAVING MAX(dataHora) > current_date - interval '1 week' ";
  }
  else if ($filterBy == 'month') {
    $queryString .= " HAVING MAX(dataHora) > current_date - interval '1 month' ";
  }
  else if ($filterBy == 'year') {
    $queryString .= " HAVING MAX(dataHora) > current_date - interval '1 year' ";
  }
  $queryString .= "ORDER BY count DESC, dataHora DESC LIMIT 5";
  $stmt = $db->query($queryString);
  return json_encode($stmt->fetchAll());
}
?>