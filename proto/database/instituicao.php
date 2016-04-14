<?
  function instituicao_listBySigla($siglaInstituicao) {
    global $db;
    $stmt = $db->prepare("SELECT * FROM KnowUP.Instituicao WHERE sigla = :sigla");
    $stmt->bindParam(':sigla', $siglaInstituicao, PDO::PARAM_STR);
    $stmt->execute();
    return $stmt->fetch();
  }
  function instituicao_listById($idInstituicao) {
    global $db;
    $stmt = $db->prepare("SELECT * FROM KnowUP.Instituicao WHERE idInstituicao = :idInstituicao");
    $stmt->bindParam(':idInstituicao', $idInstituicao, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetch();
  }
  function instituicao_listAll() {
    global $db;
    $stmt = $db->prepare("SELECT * FROM KnowUP.MembrosInstituicao ORDER BY sigla");
    return $stmt->fetchAll();
  }
?>