<?
function categoria_adicionarCategoria($nomeCategoria) {
  global $db;
  $stmt = $db->prepare("INSERT INTO Categoria(idCategoria, nome) VALUES(DEFAULT, :nome)");
  $stmt->bindParam(":nome", $nomeCategoria, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function categoria_editarCategoria($idCategoria, $nomeCategoria) {
  global $db;
  $stmt = $db->prepare("UPDATE Categoria SET nome = :nome WHERE idCategoria = :idCategoria");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->bindParam(':nome', $nomeCategoria, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function categoria_apagarCategoria($idCategoria) {
  global $db;
  $stmt = $db->prepare("DELETE FROM Categoria WHERE idCategoria = :idCategoria");
  $stmt->bindParam(":idCategoria", $idCategoria, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function categoria_listAll() {
  global $db;
  $stmt = $db->query("SELECT Categoria.*,
    COUNT(DISTINCT Pergunta.idPergunta) AS numeroPerguntas
    FROM Categoria
    NATURAL LEFT JOIN Pergunta
    GROUP BY idCategoria
    ORDER BY nome");
  return $stmt->fetchAll();
}
function categoria_listAllGrouped() {
  global $db;
  $stmt = $db->query("SELECT
      Instituicao.sigla,
      json_agg(Categoria.*) AS json
    FROM CategoriaInstituicao
    INNER JOIN Categoria USING(idCategoria)
    INNER JOIN Instituicao USING(idInstituicao)
    GROUP BY Instituicao.idInstituicao
    ORDER BY Instituicao.idInstituicao");
  return $stmt->fetchAll();
}
function categoria_listById($idCategoria) {
  global $db;
  $stmt = $db->prepare("SELECT * FROM Categoria WHERE idCategoria = :idCategoria");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function categoria_listByInstituicao($idInstituicao) {
  global $db;
  $stmt = $db->prepare("SELECT
    Categoria.idCategoria,
    Categoria.nome
    FROM Instituicao
    INNER JOIN CategoriaInstituicao USING(idInstituicao)
    INNER JOIN Categoria USING(idCategoria)
    WHERE idInstituicao = :idInstituicao
    ORDER BY Categoria.nome");
  $stmt->bindParam(':idInstituicao', $idInstituicao, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function categoria_listRelacionadas($idCategoria, $includeSelf) {
  global $db;
  if ($includeSelf) {
    $stmt = $db->prepare("(SELECT
      Categoria.idCategoria,
      Categoria.nome
      FROM Categoria
      WHERE Categoria.idCategoria = :idCategoria)
      UNION (SELECT Categorias.idCategoria, Categorias.nome
      FROM Categoria
      INNER JOIN CategoriaInstituicao CI1 USING(idCategoria)
      INNER JOIN CategoriaInstituicao CI2 USING(idInstituicao)
      INNER JOIN Categoria Categorias ON Categorias.idCategoria = CI2.idCategoria
      WHERE Categoria.idCategoria = :idCategoria
      AND Categorias.idCategoria <> Categoria.idCategoria
      GROUP BY Categorias.idCategoria
      ORDER BY random()
      LIMIT 4)");
  }
  else {
    $stmt = $db->prepare("SELECT
      Categorias.idCategoria,
      Categorias.nome
      FROM Categoria
      INNER JOIN CategoriaInstituicao CI1 USING(idCategoria)
      INNER JOIN CategoriaInstituicao CI2 USING(idInstituicao)
      INNER JOIN Categoria Categorias ON Categorias.idCategoria = CI2.idCategoria
      WHERE Categoria.idCategoria = :idCategoria
      AND Categorias.idCategoria <> Categoria.idCategoria
      GROUP BY Categorias.idCategoria
      ORDER BY random()
      LIMIT 5");
  }
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function categoria_fetchPerguntas($idCategoria) {
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
    FROM Pergunta
    LEFT JOIN VotoPergunta USING(idPergunta)
    LEFT JOIN (SELECT idPergunta, COUNT(*)
      FROM Resposta
      GROUP BY idPergunta)
      AS TabelaRespostas
      USING (idPergunta)
    INNER JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    WHERE Pergunta.idCategoria = :idCategoria
    GROUP BY Pergunta.idPergunta, TabelaRespostas.count, Utilizador.idUtilizador
    ORDER BY Pergunta.dataHora DESC");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function categoria_getStats($filterBy) {
  global $db;
  $queryString = "SELECT
      Categoria.idCategoria,
      Categoria.nome,
      MAX(Pergunta.idPergunta) as ultimaPergunta,
      MAX(Pergunta.dataHora) AS dataHora,
      COALESCE(COUNT(Pergunta.idPergunta), 0) AS numeroPerguntas
    FROM Categoria
    JOIN Pergunta USING(idCategoria)
    GROUP BY Categoria.idCategoria, Pergunta.idPergunta\n";
  if ($filterBy == 'day') {
    $queryString .= "HAVING dataHora > current_date - interval '1 day'\n";
  }
  else if ($filterBy == 'week') {
    $queryString .= "HAVING dataHora > current_date - interval '1 week'\n";
  }
  else if ($filterBy == 'month') {
    $queryString .= "HAVING dataHora > current_date - interval '1 month'\n";
  }
  else if ($filterBy == 'year') {
    $queryString .= "HAVING dataHora > current_date - interval '1 year'\n";
  }
  $queryString .= "ORDER BY numeroPerguntas DESC, Pergunta.dataHora DESC LIMIT 5";
  $stmt = $db->query($queryString);
  return json_encode($stmt->fetchAll());
}
?>