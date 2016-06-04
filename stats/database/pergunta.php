<?
function pergunta_estatisticas($filterBy) {
  global $db;
  $queryString = "SELECT
      Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      MAX(idPergunta) AS ultimaPergunta,
      MAX(dataHora) AS dataHora,
      COALESCE(COUNT(idPergunta), 0) AS count
    FROM Pergunta
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