<?
function report_adicionarReport($idModerador, $idUtilizador, $descricao) {
  global $db;
  $stmt = $db->prepare('INSERT INTO Report(idReport, idModerador, idUtilizador, descricao)
    VALUES(DEFAULT, :idModerador, :idUtilizador, :descricao)');
  $stmt->bindParam(':idModerador', $idModerador, PDO::PARAM_INT);
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(':descricao', $descricao, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function report_apagarReport($idReport) {
  global $db;
  $stmt = $db->prepare('DELETE FROM Report WHERE idReport = :idReport');
  $stmt->bindParam(':idReport', $idReport, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function report_listarReports() {
  global $db;
  $stmt = $db->query("SELECT
      Report.idReport,
      Report.idModerador,
      Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.ativo,
      Utilizador.removido,
      Instituicao.sigla,
      Report.descricao,
      Report.dataHora
    FROM Report
    NATURAL JOIN Utilizador
    NATURAL JOIN Instituicao
    WHERE NOT removido");
  return $stmt->fetchAll();
}
function report_listarModerador($idModerador) {
  global $db;
  $stmt = $db->prepare("SELECT
      Report.idReport,
      Report.idModerador,
      Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.ativo,
      Utilizador.removido,
      Instituicao.sigla,
      Report.descricao,
      Report.dataHora
    FROM Report
    NATURAL JOIN Utilizador
    NATURAL JOIN Instituicao
    WHERE idModerador = :idModerador AND NOT removido");
  $stmt->bindParam(':idModerador', $idModerador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
?>