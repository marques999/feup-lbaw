<?
function instituicao_adicionarInstituicao($nome, $sigla, $morada, $contacto, $website) {
  global $db;
  $stmt = $db->prepare("INSERT INTO Instituicao(idInstituicao, nome, sigla, morada, contacto, website)
    VALUES(DEFAULT, :nome, :sigla, :morada, :contacto, :website)");
  $stmt->bindParam(':nome', $nome, PDO::PARAM_STR);
  $stmt->bindParam(':sigla', $sigla, PDO::PARAM_STR);
  if ($morada==null) {
    $stmt->bindParam(':morada', $morada, PDO::PARAM_NULL);
  }
  else {
    $stmt->bindParam(':morada', $morada, PDO::PARAM_STR);
  }
  if ($contacto==null) {
    $stmt->bindParam(':contacto', $contacto, PDO::PARAM_NULL);
  }
  else {
    $stmt->bindParam(':contacto', $contacto, PDO::PARAM_STR);
  }
  if ($website==null) {
    $stmt->bindParam(':website', $website, PDO::PARAM_NULL);
  }
  else {
    $stmt->bindParam(':website', $website, PDO::PARAM_STR);
  }
  $stmt->execute();
  return $stmt->rowCount();
}
function instituicao_editarInstituicao($idInstituicao, $nome, $sigla, $morada, $contacto, $website) {
  global $db;
  $queryString = "UPDATE Instituicao SET ";
  if ($nome!=null) {
    $queryString .= "nome = :nome";
  }
  if ($sigla!=null) {
    $queryString .= ($numberColumns > 0 ? ', sigla = :sigla' : 'sigla = :sigla');
  }
  if ($morada!=null) {
    $queryString .= ($numberColumns > 0 ? ', morada = :morada' : 'morada = :morada');
  }
  if ($contacto!=null) {
    $queryString .= ($numberColumns > 0 ? ', contacto = :contacto' : 'contacto = :contacto');
  }
  if ($website!=null) {
    $queryString .= ($numberColumns > 0 ? ', website = :website' : 'website = :website');
  }
  $queryString .= ' WHERE idInstituicao = :idInstituicao';
  $stmt = $db->prepare($queryString);
  $stmt->bindParam(":idInstituicao", $idInstituicao, PDO::PARAM_INT);
  if ($nome!=null) {
    $stmt->bindParam(':nome', $nome, PDO::PARAM_STR);
  }
  if ($sigla!=null) {
    $stmt->bindParam(':sigla', $sigla, PDO::PARAM_STR);
  }
  if ($morada!=null) {
    $stmt->bindParam(':morada', $morada, PDO::PARAM_STR);
  }
  if ($contacto!=null) {
    $stmt->bindParam(':contacto', $contacto, PDO::PARAM_STR);
  }
  if ($website!=null) {
    $stmt->bindParam(':website', $website, PDO::PARAM_STR);
  }
  $stmt->execute();
  return $stmt->rowCount();
}
function instituicao_apagarInstituicao($idInstituicao) {
  global $db;
  $stmt = $db->prepare("DELETE FROM Instituicao WHERE sigla = :sigla");
  $stmt->bindParam(":sigla", $idInstituicao, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function instituicao_associarCategoria($idInstituicao, $idCategoria) {
  global $db;
  $stmt = $db->prepare("INSERT INTO CategoriaInstituicao(idInstituicao, idCategoria)
    VALUES(:idInstituicao, :idCategoria)");
  $stmt->bindParam(":idCategoria", $idCategoria, PDO::PARAM_INT);
  $stmt->bindParam(":idInstituicao", $idInstituicao, PDO::PARAM_INT);
  $stmt->execute();
  return json_encode($stmt->rowCount());
}
function instituicao_removerCategoria($idInstituicao, $idCategoria) {
  global $db;
  $stmt = $db->prepare("DELETE FROM CategoriaInstituicao
    WHERE idInstituicao = :idInstituicao
    AND idCategoria = :idCategoria");
  $stmt->bindParam(":idCategoria", $idCategoria, PDO::PARAM_INT);
  $stmt->bindParam(":idInstituicao", $idInstituicao, PDO::PARAM_INT);
  $stmt->execute();
  return json_encode($stmt->rowCount());
}
function instituicao_listAll() {
  global $db;
  $stmt = $db->query("SELECT
      Instituicao.idInstituicao,
      Instituicao.nome,
      Instituicao.sigla,
      COUNT(DISTINCT CategoriaInstituicao.idCategoria) AS numeroCategorias,
      COUNT(DISTINCT Pergunta.idPergunta) AS numeroPerguntas,
      COUNT(DISTINCT Utilizador.idUtilizador) AS numeroUtilizadores
    FROM Instituicao
    NATURAL LEFT JOIN CategoriaInstituicao
    NATURAL LEFT JOIN Pergunta
    NATURAL LEFT JOIN Utilizador
    GROUP BY idInstituicao
    ORDER BY sigla");
  return $stmt->fetchAll();
}
function instituicao_listById($idInstituicao) {
  global $db;
  $stmt = $db->prepare("SELECT * FROM Instituicao WHERE idInstituicao = :idInstituicao");
  $stmt->bindParam(':idInstituicao', $idInstituicao, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function instituicao_listByCategoria($idCategoria) {
  global $db;
  $stmt = $db->prepare("SELECT
    Instituicao.idInstituicao,
    Instituicao.sigla
    FROM Categoria
    NATURAL JOIN CategoriaInstituicao
    INNER JOIN Instituicao USING(idInstituicao)
    WHERE idCategoria = :idCategoria");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function instituicao_listBySigla($siglaInstituicao) {
  global $db;
  $stmt = $db->prepare("SELECT * FROM Instituicao WHERE sigla = :sigla");
  $stmt->bindParam(':sigla', $siglaInstituicao, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->fetch();
}
function instituicao_fetchPerguntas($idInstituicao) {
  global $db;
  $stmt = $db->prepare("SELECT
      Pergunta.idPergunta,
      Utilizador.idUtilizador,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.username,
      Utilizador.removido,
      Pergunta.titulo,
      Pergunta.descricao,
      Pergunta.dataHora,
      Pergunta.ativa,
      COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
      COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
      COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
      COALESCE(SUM(valor), 0) AS pontuacao
    FROM CategoriaInstituicao
    NATURAL JOIN Pergunta
    INNER JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    LEFT JOIN VotoPergunta USING(idPergunta)
    LEFT JOIN (SELECT idPergunta, COUNT(*)
      FROM Resposta
      GROUP BY idPergunta)
      AS TabelaRespostas
      USING (idPergunta)
    WHERE CategoriaInstituicao.idInstituicao = :idInstituicao
    GROUP BY Pergunta.idPergunta, TabelaRespostas.count, Utilizador.idUtilizador
    ORDER BY Pergunta.dataHora DESC;");
  $stmt->bindParam(':idInstituicao', $idInstituicao, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function instituicao_getStats($filterBy) {
  global $db;
  $queryString = "SELECT
      Instituicao.idInstituicao,
      Instituicao.sigla,
      MAX(Pergunta.idPergunta) AS ultimaPergunta,
      MAX(Pergunta.dataHora) AS dataHora,
      COALESCE(COUNT(Pergunta.idPergunta), 0) AS numeroPerguntas
    FROM CategoriaInstituicao
    NATURAL JOIN Pergunta
    NATURAL JOIN Instituicao
    GROUP BY Instituicao.idInstituicao;\n";
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
?>