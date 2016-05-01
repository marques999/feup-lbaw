<?
function pergunta_listByAuthor($idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT Pergunta.idPergunta,
      Pergunta.titulo,
      Pergunta.descricao,
      Pergunta.dataHora,
      Pergunta.ativa,
      COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
      COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
      COALESCE(SUM(valor), 0) AS pontuacao
    FROM Utilizador
    JOIN Pergunta ON Utilizador.idUtilizador = Pergunta.idAutor
    LEFT JOIN VotoPergunta USING(idPergunta)
    WHERE Utilizador.idUtilizador = :idUtilizador
    GROUP BY Pergunta.idPergunta
    ORDER BY Pergunta.dataHora DESC");
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function pergunta_verificarAutor($idPergunta, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT FROM Pergunta
    WHERE idPergunta = :idPergunta
    AND idAutor = :idUtilizador");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $result = $stmt->execute();
  return $result && is_array($result);
}
function pergunta_inserirPergunta($idUtilizador, $idCategoria, $titulo, $descricao) {
  global $db;
  if (isset($descricao)) {
    $stmt = $db->prepare("INSERT INTO Pergunta(idPergunta, idCategoria, idAutor, titulo, descricao)
    VALUES(DEFAULT, :idCategoria, :idUtilizador, :titulo, :descricao)");
    $stmt->bindParam(":descricao", $safeMessage, PDO::PARAM_STR);
  }
  else {
    $stmt = $db->prepare("INSERT INTO Pergunta(idPergunta, idCategoria, idAutor, titulo)
    VALUES(DEFAULT, :idCategoria, :idUtilizador, :titulo)");
  }
  $stmt->bindParam(":idCategoria", $idCategoria, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(":titulo", $safeTitle, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function pergunta_editarPergunta($idPergunta, $idCategoria, $titulo, $descricao) {
  global $db;
  $numberColumns = 0;
  $queryString = "UPDATE Instituicao SET ";
  if ($idCategoria!=null) {
    $queryString .= "idCategoria = :idCategoria";
    $numberColumns++;
  }
  if ($titulo!=null) {
    $queryString .= ($numberColumns > 0 ? ', titulo = :titulo' : 'titulo = :titulo');
    $numberColumns++;
  }
  if ($descricao!=null) {
    $queryString .= ($numberColumns > 0 ? ', descricao = :descricao' : 'descricao = :descricao');
    $numberColumns++;
  }
  $queryString .= ' WHERE idPergunta = :idPergunta';
  $stmt = $db->prepare($queryString);
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  if ($idCategoria!=null) {
    $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  }
  if ($titulo!=null) {
    $stmt->bindParam(':titulo', $titulo, PDO::PARAM_STR);
  }
  if ($descricao!=null) {
    $stmt->bindParam(':descricao', $descricao, PDO::PARAM_STR);
  }
  $stmt->execute();
  return $stmt->rowCount();
}
function pergunta_apagarPergunta($idPergunta, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("DELETE FROM Pergunta
    WHERE idPergunta = :idPergunta
    AND idAutor = :idUtilizador");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function pergunta_fecharPergunta($idPergunta, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("UPDATE Pergunta SET ativa = FALSE
    WHERE idPergunta = :idPergunta
    AND idAutor = :idUtilizador");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function pergunta_followPergunta($idPergunta, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("INSERT INTO Seguidor(idSeguidor, idPergunta) VALUES(:idUtilizador, :idPergunta)");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function pergunta_unfollowPergunta($idPergunta, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("DELETE FROM Seguidor WHERE idSeguidor = :idUtilizador AND idPergunta = :idPergunta");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function pergunta_contarSeguidores($idPergunta) {
  global $db;
  $stmt = $db->prepare("SELECT COUNT(*) FROM Seguidor WHERE idPergunta = :idPergunta");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return json_encode($stmt->fetch());
}
function pergunta_listById($idPergunta) {
  global $db;
  $stmt = $db->prepare("SELECT Pergunta.idPergunta,
      Pergunta.idCategoria,
      Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeutilizador,
      Utilizador.removido,
      Instituicao.sigla,
      Pergunta.titulo,
      Pergunta.descricao,
      Pergunta.dataHora,
      Pergunta.ativa,
      COALESCE(TabelaSeguidores.count, 0) AS numeroSeguidores,
      COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
      COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
      COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao
    FROM Pergunta
    JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    JOIN Instituicao USING(idInstituicao)
    LEFT JOIN (SELECT idPergunta,
        SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
        SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
        FROM VotoPergunta
        WHERE idPergunta = :idPergunta
        GROUP BY idPergunta)
        AS TabelaVotos
        USING (idPergunta)
    LEFT JOIN (SELECT idPergunta, COUNT(*)
        FROM Seguidor
        WHERE idPergunta = :idPergunta
        GROUP BY idPergunta)
        AS TabelaSeguidores
        USING (idPergunta)
    WHERE Pergunta.idPergunta = :idPergunta");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function pergunta_registarVoto($idPergunta, $idUtilizador, $valor) {
  global $db;
  $stmt = $db->prepare("SELECT registarVotoPergunta(:idPergunta, :idUtilizador, :valor)");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(":valor", $valor, PDO::PARAM_INT);
  $stmt->execute();
}
function pergunta_inserirComentario($idPergunta, $idUtilizador, $descricao) {
  global $db;
  $stmt = $db->prepare("INSERT INTO Contribuicao(idContribuicao, idAutor, descricao)
    VALUES(DEFAULT, :idUtilizador, :descricao)");
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(":descricao", $descricao, PDO::PARAM_STR);
  $stmt->execute();
  $idComentario = $db->lastInsertId('contribuicao_idcontribuicao_seq');
  $stmt = $db->prepare("INSERT INTO ComentarioPergunta(idComentario, idPergunta)
    VALUES(:idComentario, :idPergunta)");
  $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return json_encode($stmt->rowCount());
}
function pergunta_removerComentario($idPergunta, $idComentario, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("DELETE FROM ComentarioPergunta
    WHERE idComentario = :idComentario
    AND idPergunta = :idPergunta");
  $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
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
function pergunta_userFollows($idUtilizador, $idPergunta) {
  global $db;
  $stmt = $db->prepare('SELECT idSeguidor FROM Seguidor WHERE idSeguidor = :idUtilizador AND idPergunta = :idPergunta');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(':idPergunta', $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  $result = $stmt->fetch();
  return ($result && is_array($result) && $result['idseguidor'] == $idUtilizador);
}
function pergunta_userVote($idUtilizador, $idPergunta) {
  global $db;
  $stmt = $db->prepare('SELECT valor FROM VotoPergunta WHERE idAutor = :idUtilizador AND idPergunta = :idPergunta');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(':idPergunta', $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch()['valor'];
}
function pergunta_fetchRelacionadas($idCategoria, $idPergunta) {
  global $db;
  $stmt = $db->prepare("SELECT
      Pergunta.idPergunta,
      Pergunta.titulo,
      Utilizador.username
    FROM CategoriaInstituicao
    INNER JOIN CategoriaInstituicao CategoriasRelacionadas USING(idInstituicao)
    INNER JOIN Pergunta ON Pergunta.idCategoria = CategoriasRelacionadas.idCategoria
    INNER JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    WHERE CategoriaInstituicao.idCategoria = :idCategoria
    AND Pergunta.idPergunta <> :idPergunta
    GROUP BY Pergunta.idPergunta, Utilizador.username
    ORDER BY random() LIMIT 5");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->bindParam(':idPergunta', $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function pergunta_fetchVotes($idPergunta) {
  global $db;
  $stmt = $db->prepare("SELECT
      COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
      COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
      COALESCE(COUNT(*), 0) AS pontuacao
    FROM VotoPergunta
    WHERE idPergunta = :idPergunta
    GROUP BY idPergunta");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function pergunta_fetchVotesJson($idPergunta) {
  return json_encode(pergunta_fetchVotes($idPergunta));
}
function pergunta_fetchRespostas($idPergunta) {
  global $db;
  $stmt = $db->prepare("SELECT
      Resposta.idResposta,
      Utilizador.idUtilizador,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.username,
      Utilizador.removido,
      Instituicao.sigla,
      Contribuicao.descricao,
      Contribuicao.dataHora,
      COALESCE(TabelaComentarios.count, 0) AS numeroComentarios,
      COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
      COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
      COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
      Resposta.melhorResposta
    FROM Resposta
    INNER JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
    INNER JOIN Utilizador USING(idUtilizador)
    LEFT JOIN Instituicao ON Instituicao.idInstituicao = Utilizador.idInstituicao
    LEFT JOIN (SELECT idResposta,
        SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
        SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
        FROM VotoResposta
        GROUP BY idResposta)
        AS TabelaVotos
        USING (idResposta)
    LEFT JOIN (SELECT idResposta, COUNT(*)
        FROM ComentarioResposta
        GROUP BY idResposta)
        AS TabelaComentarios
        USING (idResposta)
    WHERE Resposta.idPergunta = :idPergunta
    ORDER BY Resposta.idResposta");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function pergunta_fetchComments($idPergunta) {
  global $db;
  $stmt = $db->prepare("SELECT
      ComentarioPergunta.idComentario,
      Utilizador.idUtilizador,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.removido,
      Contribuicao.descricao,
      to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') as dataHora
    FROM ComentarioPergunta
    INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
    NATURAL JOIN Utilizador
    WHERE idPergunta = :idPergunta
    ORDER BY idComentario");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function pergunta_fetchCommentsJson($idPergunta) {
  return json_encode(pergunta_fetchComments($idPergunta));
}
function pergunta_fetchCommentsAfter($idPergunta, $ultimoComentario) {
  global $db;
  $stmt = $db->prepare("SELECT
      ComentarioPergunta.idComentario,
      Utilizador.idUtilizador,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.removido,
      Contribuicao.descricao,
      to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') as dataHora
    FROM ComentarioPergunta
    INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
    NATURAL JOIN Utilizador
    WHERE idPergunta = :idPergunta
    AND idComentario > :ultimoComentario
    ORDER BY idComentario");
  $stmt->bindParam(":ultimoComentario", $ultimoComentario, PDO::PARAM_INT);
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return json_encode($stmt->fetchAll());
}
function pergunta_pesquisar($queryString) {
  global $db;
  $stmt = $db->prepare("SELECT QueryPrincipal.idPergunta,
      QueryPrincipal.idUtilizador,
      QueryPrincipal.nomeUtilizador,
      QueryPrincipal.titulo,
      QueryPrincipal.dataHora,
      QueryPrincipal.ativa,
      COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
      COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
      COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
      COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
      ts_headline('portuguese', QueryPrincipal.conteudo, query) AS descricao,
      QueryPrincipal.rank
    FROM (SELECT PerguntasPesquisa.*, query, ts_rank_cd(pesquisa, query) AS rank
      FROM PerguntasPesquisa, plainto_tsquery('portuguese', :queryString) AS query
      WHERE query @@ pesquisa
      ORDER BY rank DESC) AS QueryPrincipal
    LEFT JOIN (SELECT idPergunta,
      SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
      SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
      FROM VotoPergunta
      GROUP BY idPergunta)
      AS TabelaVotos
      USING (idPergunta)
    LEFT JOIN (SELECT idPergunta, COUNT(*)
      FROM Resposta
      GROUP BY idPergunta)
      AS TabelaRespostas
      USING (idPergunta)");
  $stmt->bindParam(":queryString", $queryString, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function pergunta_getStats($filterBy) {
  global $db;
  $queryString = "SELECT
      Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      MAX(Pergunta.idPergunta) AS ultimaPergunta,
      MAX(Pergunta.dataHora) AS dataHora,
      COALESCE(COUNT(Pergunta.idPergunta), 0) AS numeroPerguntas
    FROM Pergunta
    LEFT JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
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
  $queryString .= "ORDER BY numeroPerguntas DESC, dataHora DESC LIMIT 5";
  $stmt = $db->query($queryString);
  return json_encode($stmt->fetchAll());
}
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
    WHERE ComentarioResposta.idResposta = :idResposta");
  $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
?>