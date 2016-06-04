<?
function categoria_estatisticas($filterBy) {
  global $db;
  $queryString = "SELECT Categoria.*,
      MAX(idPergunta) as ultimaPergunta,
      to_char(MAX(dataHora), 'FMDay, DD FMMonth YYYY HH24:MI') AS dataHora,
      COALESCE(COUNT(idPergunta), 0) AS count
    FROM Categoria
    NATURAL JOIN Pergunta
    GROUP BY idCategoria, idPergunta";
  if ($filterBy == 'day') {
    $queryString .= " HAVING dataHora > current_date - interval '1 day' ";
  }
  else if ($filterBy == 'week') {
    $queryString .= " HAVING dataHora > current_date - interval '1 week' ";
  }
  else if ($filterBy == 'month') {
    $queryString .= " HAVING dataHora > current_date - interval '1 month' ";
  }
  else if ($filterBy == 'year') {
    $queryString .= " HAVING dataHora > current_date - interval '1 year' ";
  }
  $queryString .= "ORDER BY numeroPerguntas DESC, dataHora DESC LIMIT 5";
  $stmt = $db->query($queryString);
  return json_encode($stmt->fetchAll());
}
?>