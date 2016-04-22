<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $stringPesquisa = safe_trim($_GET['query']);
  $filterBy = safe_trim($_GET['filter']);
  $sortBy = safe_trim($_GET['sort']);
  $orderBy = safe_trim($_GET['order']);
  $noSearch = empty($stringPesquisa); 

  if ($noSearch) {
    $queryString = "SELECT Utilizador.idUtilizador,
        Utilizador.username,
        Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
        Utilizador.email 
      FROM Utilizador";
  }
  else {
    $queryString = "SELECT UtilizadoresPesquisa.idUtilizador,
        UtilizadoresPesquisa.username,
        UtilizadoresPesquisa.nomeUtilizador,
        UtilizadoresPesquisa.email,
        ts_rank_cd(UtilizadoresPesquisa.pesquisa, query) AS rank
      FROM UtilizadoresPesquisa, plainto_tsquery('english', :stringPesquisa) AS query
      WHERE query @@ pesquisa";
  }

  if ($filterBy == 'active') {
    
    if ($noSearch) {
      $queryString .= ' WHERE ativo = TRUE and removido = FALSE';
    }
    else {
      $queryString .= ' AND ativo = TRUE and removido = FALSE';
    }
  }
  else if ($filterBy == 'removed') {

    if ($noSearch) {
      $queryString .= ' WHERE removido = TRUE';
    }
    else {
      $queryString .= ' AND removido = TRUE';
    }
  }
  else if ($filterBy == 'banned') {

    if ($noSearch) {
      $queryString .= ' WHERE ativo = FALSE AND removido = FALSE';
    }
    else {
      $queryString .= ' AND ativo = FALSE AND removido = FALSE';
    }
  }

  if ($sortBy == 'username') {
    $queryString .= ' ORDER BY username';
  }
  else if ($sortBy == 'email') {
    $queryString .= ' ORDER BY email';
  }
  else if ($sortBy == 'name') {
    $queryString .= ' ORDER BY nomeUtilizador';
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

    if ($sortBy == 'rank') {
      $queryString .= ' DESC';
    }
    else {
      $queryString .= ' ASC';
    }
  }

  $stmt = $db->prepare($queryString);
  
  if (!$noSearch)  {
    $stmt->bindParam(':stringPesquisa', $stringPesquisa, PDO::PARAM_STR);
  }
  
  $stmt->execute();
  echo json_encode($stmt->fetchAll());
?>