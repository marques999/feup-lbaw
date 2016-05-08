<?
function pergunta_pesquisar($query, $filter, $sort, $order) {
  global $db;
  $emptyQuery = empty($query);
  if ($emptyQuery) {
    $queryString = "SELECT
      Pergunta.idPergunta,
      Utilizador.idUtilizador,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.ativo,
      Utilizador.removido,
      Pergunta.titulo,
      Pergunta.descricao,
      Pergunta.dataHora,
      Pergunta.ativa,
      COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
      COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
      COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
      votosPositivos - votosNegativos AS pontuacao
    FROM Pergunta
    LEFT JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    LEFT JOIN (SELECT idPergunta,
      COUNT(valor) FILTER (WHERE valor = 1) AS votosPositivos,
      COUNT(valor) FILTER (WHERE valor = -1) AS votosNegativos
      FROM VotoPergunta
      GROUP BY idPergunta)
      AS TabelaVotos
      USING (idPergunta)
    LEFT JOIN (SELECT idPergunta, COUNT(*)
      FROM Resposta
      GROUP BY idPergunta)
      AS TabelaRespostas
      USING (idPergunta)";
  }
  else {
    $queryString = "SELECT
      QueryPrincipal.idPergunta,
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
      FROM PerguntasPesquisa, plainto_tsquery('portuguese', :stringPesquisa) AS query
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
      USING (idPergunta)";
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
    $queryString .= ' ORDER BY numeroRespostas';
  }
  else if ($sort == 'rank') {
    $queryString .= ' ORDER BY rank';
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
function utilizador_pesquisar($query, $filter, $sort, $order) {
  global $db;
  $emptyQuery = empty($query);
  if ($emptyQuery) {
    $queryString = "SELECT
      Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.email
    FROM Utilizador";
  }
  else {
    $queryString = "SELECT
      UtilizadoresPesquisa.idUtilizador,
      UtilizadoresPesquisa.username,
      UtilizadoresPesquisa.nomeUtilizador,
      UtilizadoresPesquisa.email,
      ts_rank_cd(UtilizadoresPesquisa.pesquisa, query) AS rank
    FROM UtilizadoresPesquisa, plainto_tsquery('english', :stringPesquisa) AS query
    WHERE query @@ pesquisa";
  }
  if ($filter == 'active') {
    if ($emptyQuery) {
      $queryString .= ' WHERE ativo AND NOT removido';
    }
    else {
      $queryString .= ' AND ativo AND NOT removido';
    }
  }
  else if ($filter == 'removed') {
    if ($emptyQuery) {
      $queryString .= ' WHERE removido';
    }
    else {
      $queryString .= ' AND removido';
    }
  }
  else if ($filter == 'banned') {
    if ($emptyQuery) {
      $queryString .= ' WHERE NOT ativo AND NOT removido';
    }
    else {
      $queryString .= ' AND NOT ativo AND NOT removido';
    }
  }
  if ($sort == 'username') {
    $queryString .= ' ORDER BY username';
  }
  else if ($sort == 'email') {
    $queryString .= ' ORDER BY email';
  }
  else if ($sort == 'name') {
    $queryString .= ' ORDER BY nomeUtilizador';
  }
  else if ($sort == 'date') {
    $queryString .= ' ORDER BY dataRegisto';
  }
  else {
    if ($emptyQuery) {
      $queryString .= ' ORDER BY idUtilizador';
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
    if ($sort == 'rank') {
      $queryString .= ' DESC';
    }
    else {
      $queryString .= ' ASC';
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