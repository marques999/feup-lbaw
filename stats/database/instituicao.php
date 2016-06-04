<?
function instituicao_estatisticas($filterBy) {
  global $db;
  $queryString = "SELECT
      Instituicao.idInstituicao,
      Instituicao.sigla,
      MAX(idPergunta) AS ultimaPergunta,
      to_char(MAX(dataHora), 'FMDay, DD FMMonth YYYY HH24:MI') AS dataHora,
      COALESCE(COUNT(idPergunta), 0) AS count
    FROM CategoriaInstituicao
    NATURAL JOIN Pergunta
    NATURAL JOIN Instituicao
    GROUP BY Instituicao.idInstituicao";
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