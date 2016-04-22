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
    GROUP BY Pergunta.idPergunta");
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
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
function pergunta_fetchRespostas($idPergunta) {
  global $db;
  $stmt = $db->prepare("SELECT Resposta.idResposta,
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
    JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
    JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
    JOIN Instituicao ON Instituicao.idInstituicao = Utilizador.idInstituicao
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
  $stmt = $db->prepare("SELECT ComentarioPergunta.idComentario,
      Utilizador.idUtilizador,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.removido,
      Contribuicao.descricao,
      Contribuicao.dataHora
    FROM ComentarioPergunta
    JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
    JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
    WHERE ComentarioPergunta.idPergunta = :idPergunta
    ORDER BY ComentarioPergunta.idComentario");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
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