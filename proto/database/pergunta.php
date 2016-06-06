<?
function pergunta_listByAuthor($idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT
      Pergunta.idPergunta,
      Pergunta.titulo,
      Pergunta.descricao,
      Pergunta.dataHora,
      Pergunta.ativa,
      Pergunta.pontuacao,
      COALESCE(COUNT(valor) FILTER (WHERE valor = 1), 0) AS votosPositivos,
      COALESCE(COUNT(valor) FILTER (WHERE valor = -1), 0) AS votosNegativos
    FROM Pergunta
    NATURAL JOIN Utilizador
    LEFT JOIN VotoPergunta USING(idPergunta)
    WHERE Pergunta.idUtilizador = :idUtilizador
    GROUP BY idPergunta
    ORDER BY dataHora DESC");
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function pergunta_verificarAutor($idPergunta, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT FROM Pergunta WHERE idPergunta = :idPergunta AND idUtilizador = :idUtilizador");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  $result = $stmt->fetch();
  return $result && is_array($result);
}
function pergunta_visitarPergunta($idPergunta, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT visitarPergunta(:idPergunta, :idUtilizador)");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
}
function pergunta_inserirPergunta($idUtilizador, $idCategoria, $titulo, $descricao) {
  global $db;
  if (isset($descricao)) {
    $stmt = $db->prepare("INSERT INTO Pergunta(idPergunta, idCategoria, idUtilizador, titulo, descricao)
    VALUES(DEFAULT, :idCategoria, :idUtilizador, :titulo, :descricao)");
    $stmt->bindParam(":descricao", $descricao, PDO::PARAM_STR);
  }
  else {
    $stmt = $db->prepare("INSERT INTO Pergunta(idPergunta, idCategoria, idUtilizador, titulo)
    VALUES(DEFAULT, :idCategoria, :idUtilizador, :titulo)");
  }
  $stmt->bindParam(":idCategoria", $idCategoria, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(":titulo", $titulo, PDO::PARAM_STR);
  $stmt->execute();
  if($stmt->rowCount()){
    return $db->lastInsertId('pergunta_idpergunta_seq');
  }
  return 0;
}
function pergunta_editarPergunta($idPergunta, $idCategoria, $titulo, $descricao) {
  global $db;
  $numberColumns = 0;
  $queryString = "UPDATE Pergunta SET ";
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
  $stmt = $db->prepare("DELETE FROM Pergunta WHERE idPergunta = :idPerguntad");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function pergunta_activarPergunta($idPergunta, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("UPDATE Pergunta SET ativa = TRUE WHERE idPergunta = :idPergunta");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function pergunta_fecharPergunta($idPergunta, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("UPDATE Pergunta SET ativa = FALSE WHERE idPergunta = :idPergunta");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
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
function pergunta_listarCategorias($idCategoria) {
  global $db;
  $stmt = $db->prepare("(SELECT Categoria.*
    FROM Categoria
    WHERE Categoria.idCategoria = :idCategoria)
    UNION (SELECT Categorias.*
    FROM Categoria
    INNER JOIN CategoriaInstituicao CI1 USING(idCategoria)
    INNER JOIN CategoriaInstituicao CI2 USING(idInstituicao)
    INNER JOIN Categoria Categorias ON Categorias.idCategoria = CI2.idCategoria
    WHERE Categoria.idCategoria = :idCategoria
    AND Categorias.idCategoria <> Categoria.idCategoria
    GROUP BY Categorias.idCategoria
    ORDER BY random() LIMIT 4)");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function pergunta_listarInformacoes($idPergunta) {
  global $db;
  $stmt = $db->prepare("SELECT
      Pergunta.idPergunta,
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
      Pergunta.pontuacao,
      COALESCE(TabelaSeguidores.count, 0) AS numeroSeguidores,
      COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
      COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos
    FROM Pergunta
    INNER JOIN Utilizador USING(idUtilizador)
    LEFT JOIN Instituicao USING(idInstituicao)
    LEFT JOIN (SELECT idPergunta,
      COUNT(valor) FILTER (WHERE valor = 1) AS votosPositivos,
      COUNT(valor) FILTER (WHERE valor = -1) AS votosNegativos
      FROM VotoPergunta
      WHERE idPergunta = idPergunta
      GROUP BY idPergunta)
      AS TabelaVotos
      USING (idPergunta)
    LEFT JOIN (SELECT idPergunta, COUNT(*)
      FROM Seguidor
      WHERE idPergunta = idPergunta
      GROUP BY idPergunta)
      AS TabelaSeguidores
      USING (idPergunta)
    WHERE idPergunta = :idPergunta");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function pergunta_listarRelacionadas($idCategoria, $idPergunta) {
  global $db;
  $stmt = $db->prepare("SELECT
      Pergunta.idPergunta,
      Pergunta.titulo,
      Utilizador.username
    FROM CategoriaInstituicao
    INNER JOIN CategoriaInstituicao CategoriasRelacionadas USING(idInstituicao)
    INNER JOIN Pergunta ON Pergunta.idCategoria = CategoriasRelacionadas.idCategoria
    INNER JOIN Utilizador USING(idUtilizador)
    WHERE CategoriaInstituicao.idCategoria = :idCategoria
    AND Pergunta.idPergunta <> :idPergunta
    GROUP BY Pergunta.idPergunta, Utilizador.username
    ORDER BY random() LIMIT 5");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->bindParam(':idPergunta', $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
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
  $stmt = $db->prepare("WITH NovoComentario AS (
    INSERT INTO Contribuicao(idContribuicao, idUtilizador, descricao)
    VALUES(DEFAULT, :idUtilizador, :descricao) RETURNING idContribuicao
  ) INSERT INTO ComentarioPergunta(idComentario, idPergunta)
    SELECT idContribuicao, :idPergunta
    FROM NovoComentario");
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(":descricao", $descricao, PDO::PARAM_STR);
  $stmt->execute();
  return json_encode($stmt->rowCount());
}
function pergunta_removerComentario($idPergunta, $idComentario, $idUtilizador) {
  global $db;
  $db->beginTransaction();
  $stmt = $db->prepare("DELETE FROM ComentarioPergunta WHERE idComentario = :idComentario AND idPergunta = :idPergunta");
  $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
  $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
  $stmt->execute();
  if ($stmt->rowCount() > 0) {
    $stmt = $db->prepare("DELETE FROM Contribuicao WHERE idContribuicao = :idComentario AND idUtilizador = :idUtilizador");
    $stmt->bindParam(":idComentario", $idComentario, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->execute();
    $db->commit();
  }
  else {
    $db->rollback();
  }
  return json_encode($stmt->rowCount());
}
function pergunta_informacoesUtilizador($idUtilizador, $idPergunta) {
  global $db;
  $stmt = $db->prepare('SELECT
      VotoPergunta.valor,
      Seguidor.idSeguidor
    FROM Pergunta
    LEFT JOIN VotoPergunta
      ON VotoPergunta.idPergunta = Pergunta.idPergunta
      AND VotoPergunta.idUtilizador = :idUtilizador
    LEFT JOIN Seguidor
      ON Seguidor.idPergunta = Pergunta.idPergunta
      AND Seguidor.idSeguidor = :idUtilizador
    WHERE Pergunta.idPergunta = :idPergunta
    LIMIT 1');
  $stmt->bindParam(':idPergunta', $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function pergunta_fetchVotes($idPergunta) {
  global $db;
  $stmt = $db->prepare("SELECT
      COALESCE(COUNT(valor) FILTER (WHERE valor = 1), 0) AS votosPositivos,
      COALESCE(COUNT(valor) FILTER (WHERE valor = -1), 0) AS votosNegativos,
      COALESCE(SUM(valor), 0) AS pontuacao
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
function pergunta_obterVotosRespostas($idPergunta, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT
      Resposta.idResposta,
      VotosUtilizador.valor
    FROM Resposta
    JOIN VotoResposta VotosUtilizador USING(idResposta)
    WHERE Resposta.idPergunta = :idPergunta
    AND VotosUtilizador.idUtilizador = :idUtilizador");
  $stmt->bindParam(':idPergunta', $idPergunta, PDO::PARAM_INT);
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function pergunta_obterRespostas($idPergunta) {
  global $db;
  $stmt = $db->prepare("SELECT
      Resposta.idResposta,
      Resposta.melhorResposta,
      Utilizador.idUtilizador,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.username,
      Utilizador.removido,
      Instituicao.sigla,
      Contribuicao.descricao,
      Contribuicao.dataHora,
      COALESCE(TabelaComentarios.count, 0) AS numeroComentarios,
      COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
      COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos
    FROM Resposta
    INNER JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
    INNER JOIN Utilizador USING(idUtilizador)
    LEFT JOIN Instituicao USING(idInstituicao)
    LEFT JOIN (SELECT idResposta,
      COUNT(valor) FILTER (WHERE valor = 1) AS votosPositivos,
      COUNT(valor) FILTER (WHERE valor = -1) AS votosNegativos
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
function pergunta_obterComentarios($idPergunta) {
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
  return json_encode(pergunta_obterComentarios($idPergunta));
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
function pergunta_pesquisar($query, $filter, $sort, $order) {
  global $db;
  $emptyQuery = empty($query);
  if ($emptyQuery) {
    $queryString = "SELECT
      Pergunta.idPergunta,
      Utilizador.idUtilizador,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.removido,
      Pergunta.titulo,
      Pergunta.descricao,
      Pergunta.dataHora,
      Pergunta.ativa,
      Pergunta.pontuacao,
      Pergunta.respostas
    FROM Pergunta
    NATURAL JOIN Utilizador";
  }
  else {
    $queryString = "SELECT
      PerguntasPesquisa.idPergunta,
      PerguntasPesquisa.idUtilizador,
      PerguntasPesquisa.nomeUtilizador,
      PerguntasPesquisa.removido,
      PerguntasPesquisa.titulo,
      PerguntasPesquisa.dataHora,
      PerguntasPesquisa.ativa,
      PerguntasPesquisa.pontuacao,
      PerguntasPesquisa.respostas,
      ts_rank_cd(pesquisa, query) AS rank,
      ts_headline('portuguese', conteudo, query) AS descricao
    FROM PerguntasPesquisa, plainto_tsquery('portuguese', :stringPesquisa) AS query
    WHERE query @@ pesquisa";
  }
  if ($filter == 'now') {
    if ($emptyQuery) {
      $queryString .= " WHERE dataHora > current_date - interval '1 day'";
    }
    else {
      $queryString .= " AND dataHora > current_date - interval '1 day'";
    }
  }
  else if($filter == 'day') {
    if ($emptyQuery) {
      $queryString .= " WHERE dataHora > current_date - interval '2 days'";
    }
    else {
      $queryString .= " AND dataHora > current_date - interval '2 days'";
    }
  }
  else if ($filter == 'week') {
    if ($emptyQuery) {
      $queryString .= " WHERE dataHora > current_date - interval '7 days'";
    }
    else {
      $queryString .= " AND dataHora > current_date - interval '7 days'";
    }
  }
  else if ($filter == 'month') {
    if ($emptyQuery) {
      $queryString .= " WHERE dataHora > current_date - interval '1 month'";
    }
    else {
      $queryString .= " AND dataHora > current_date - interval '1 month'";
    }
  }
  else if ($filter == 'year') {
    if ($emptyQuery) {
      $queryString .= " WHERE dataHora > current_date - interval '1 year'";
    }
    else {
      $queryString .= " AND dataHora > current_date - interval '1 year'";
    }
  }
  if ($sort == 'title') {
    $queryString .= ' ORDER BY titulo';
  }
  else if ($sort == 'date') {
    $queryString .= ' ORDER BY dataHora';
  }
  else if ($sort == 'score') {
    $queryString .= ' ORDER BY pontuacao';
  }
  else if ($sort == 'answers') {
    $queryString .= ' ORDER BY respostas';
  }
  else {
    if ($emptyQuery) {
      $queryString .= ' ORDER BY dataHora';
    }
    else {
      $queryString .= ' ORDER BY rank';
    }
  }
  if ($order == 'descending') {
    $queryString .= ' DESC';
  }
  else if ($order == 'ascending') {
    $queryString .= ' ASC';
  }
  else {
    if ($sort == 'title') {
      $queryString .= ' ASC';
    }
    else {
      $queryString .= ' DESC';
    }
  }
  $stmt = $db->prepare($queryString);
  if (!$emptyQuery)  {
    $stmt->bindParam(':stringPesquisa', $query, PDO::PARAM_STR);
  }
  try {
    $stmt->execute();
  }
  catch (PDOException $e) {
    return false;
  }
  return json_encode($stmt->fetchAll());
}
?>