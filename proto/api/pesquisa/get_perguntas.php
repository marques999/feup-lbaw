<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $stringPesquisa = safe_trim($_GET['query']);
  $filterBy = safe_trim($_GET['filter']);
  $sortBy = safe_trim($_GET['sort']);
  $orderBy = safe_trim($_GET['order']);
  $noSearch = empty($stringPesquisa); 

  if ($noSearch) {
    $queryString = "SELECT Pergunta.idPergunta,
        Utilizador.idUtilizador,
        Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
        Pergunta.titulo,
        Pergunta.descricao,
        Pergunta.dataHora,
        Pergunta.ativa,
        COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
        COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
        COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
        COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao
      FROM Pergunta
      LEFT JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
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
  else {
    $queryString = "SELECT QueryPrincipal.idPergunta,
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
        USING (idPergunta)";
  }

  if ($filterBy == 'now') {
    
    if ($noSearch) {
      $queryString .= " WHERE dataHora > current_date - interval '1 day'";
    }
    else {
      $queryString .= " AND dataHora > current_date - interval '1 day'";
    }
  }
  else if($filterBy == 'day') {

        if ($noSearch) {
      $queryString .= " WHERE dataHora > current_date - interval '2 days'";
    }
    else {
      $queryString .= " AND dataHora > current_date - interval '2 days'";
    }
  }
  else if ($filterBy == 'week') {

    if ($noSearch) {
      $queryString .= " WHERE dataHora > current_date - interval '7 days'";
    }
    else {
      $queryString .= " AND dataHora > current_date - interval '7 days'";
    }
  }
  else if ($filterBy == 'month') {

    if ($noSearch) {
      $queryString .= " WHERE dataHora > current_date - interval '1 month'";
    }
    else {
      $queryString .= " AND dataHora > current_date - interval '1 month'";
    }
  }
  else if ($filterBy == 'year') {

    if ($noSearch) {
      $queryString .= " WHERE dataHora > current_date - interval '1 year'";
    }
    else {
      $queryString .= " AND dataHora > current_date - interval '1 year'";
    }
  }

  if ($sortBy == 'title') {
    $queryString .= ' ORDER BY titulo';
  }
  else if ($sortBy == 'date') {
    $queryString .= ' ORDER BY dataHora';
  }
  else if ($sortBy == 'score') {
    $queryString .= ' ORDER BY pontuacao';
  }
  else if ($sortBy == 'answers') {
    $queryString .= ' ORDER BY numeroRespostas';
  }
  else {
    $queryString .= ' ORDER BY rank';
  }
  
  if ($orderBy == 'descending') {
    $queryString .= ' DESC';
  }
  else if ($orderBy == 'ascending') {
    $queryString .= ' ASC';
  }
  else {
    $queryString .= $defaultOrder[$sortBy];

    if ($sortBy == 'title') {
      $queryString .= ' ASC';
    }
    else {
      $queryString .= ' DESC';
    }
  }

  $stmt = $db->prepare($queryString);
  
  if (!$noSearch)  {
    $stmt->bindParam(':stringPesquisa', $stringPesquisa, PDO::PARAM_STR);
  }
  
  $stmt->execute();
  echo json_encode($stmt->fetchAll());
?>