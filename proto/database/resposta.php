<?
  function resposta_inserirResposta($idPergunta, $idUtilizador, $descricao) {
    global $db;
    $stmt = $db->prepare("INSERT INTO Contribuicao(idContribuicao, idAutor. descricao)
      VALUES(DEFAULT, :idUtilizador, :descricao)");
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->bindParam(":descricao", $safeMessage, PDO::PARAM_STR);
    $stmt->execute();
    return $stmt->rowCount();
  }
  function resposta_atualizarResposta($idResposta, $descricao) {
    global $db;
    $stmt = $db->prepare("UPDATE Contribuicao SET descricao = :descricao
      WHERE idContribuicao = :idResposta AND idAutor = :idUtilizador");
    $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
    $stmt->bindParam(":descricao", $safeMessage, PDO::PARAM_STR);
    $stmt->execute();
    return $stmt->rowCount();
  }
  function resposta_apagarResposta($idResposta, $idUtilizador, $isSuperuser) {
    global $db;
    if ($isSuperuser) {
      $stmt = $db->prepare("DELETE FROM Contribuicao WHERE idContribuicao = :idResposta");
    }
    else {
      $stmt = $db->prepare("DELETE FROM Contribuicao WHERE idContribuicao = :idResposta AND idAutor = :idUtilizador");
      $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    }
    $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->rowCount();
  }
  function resposta_destacarResposta($idPergunta, $idResposta) {
    global $db;
    $stmt = $db->prepare("UPDATE Resposta SET melhorResposta = TRUE
      WHERE idPergunta = :idPergunta AND idResposta = :idResposta");
    $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
    $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->rowCount();
  }
  function resposta_inserirComentario($idResposta, $idUtilizador, $descricao) {
    global $db;
    $stmt = $db->prepare("INSERT INTO Contribuicao(idContribuicao, idAutor, descricao)
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
        AND idAutor = :idUtilizador");
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
      COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
      COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
      COALESCE(COUNT(*), 0) AS pontuacao
      FROM VotoResposta
      WHERE idResposta = :idResposta
      GROUP BY idResposta");
    $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetch();
  }
  function resposta_fetchVotosJson($idResposta) {
    return json_encode(resposta_fetchVotos($idResposta));
  }
  function resposta_fetchComments($idResposta) {
    global $db;
    $stmt = $db->prepare("SELECT
        ComentarioResposta.idComentario,
        Utilizador.idUtilizador,
        Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
        Contribuicao.descricao,
        to_char(Contribuicao.dataHora, 'FMDay, DD Month YYYY HH24:MI') as dataHora
      FROM ComentarioResposta
      JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
      JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
      WHERE ComentarioResposta.idResposta = :idResposta");
    $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
  }
  function resposta_fetchCommentsJson($idResposta) {
    return json_encode(resposta_fetchComments($idResposta));
  }
  function resposta_fetchCommentsAfter($idResposta, $ultimoComentario) {
    global $db;
    $stmt = $db->prepare("SELECT
        ComentarioResposta.idComentario,
        Utilizador.idUtilizador,
        Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
        Contribuicao.descricao,
        to_char(Contribuicao.dataHora, 'FMDay, DD Month YYYY HH24:MI') as dataHora
      FROM ComentarioResposta
      JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
      JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
      WHERE ComentarioResposta.idResposta = :idResposta
      AND ComentarioResposta.idComentario > :ultimoComentario");
    $stmt->bindParam(":ultimoComentario", $ultimoComentario, PDO::PARAM_INT);
    $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
    $stmt->execute();
    return json_encode($stmt->fetchAll());
  }
  function resposta_getStats($filterBy) {
    global $db;
    $queryString = "SELECT Utilizador.idUtilizador,
        Utilizador.username,
        Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
        MAX(Contribuicao.idContribuicao) AS ultimaResposta,
        MAX(Contribuicao.dataHora) AS dataHora,
        COALESCE(COUNT(Resposta.idResposta), 0) AS numeroRespostas
      FROM Resposta
      LEFT JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
      LEFT JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
      GROUP BY Utilizador.idUtilizador\n";
    if ($filterBy == 'day') {
      $queryString .= "HAVING MAX(dataHora) > current_date - interval '1 day'\n";
    }
    else if ($filterBy == 'week') {
      $queryString .= "HAVING MAX(dataHora) > current_date - interval '1 week'\n";
    }
    else if ($filterBy == 'month') {
      $queryString .= "HAVING MAX(dataHora) > current_date - interval '1 month'\n";
    }
    else if ($filterBy == 'year') {
      $queryString .= "HAVING MAX(dataHora) > current_date - interval '1 year'\n";
    }
    $queryString .= "ORDER BY numeroRespostas DESC, dataHora DESC LIMIT 5";
    $stmt = $db->query($queryString);
    return json_encode($stmt->fetchAll());
  }
?>