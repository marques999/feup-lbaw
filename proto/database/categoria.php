<?
  function categoria_listAll() {
    global $db;
    return $db->query("SELECT * FROM Categoria ORDER BY nome")->fetchAll();
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
    $stmt = $db->prepare("SELECT Categoria.idCategoria, Categoria.nome
      FROM Instituicao
      JOIN CategoriaInstituicao USING(idInstituicao)
      JOIN Categoria USING(idCategoria)
      WHERE idInstituicao = :idInstituicao
      ORDER BY Categoria.nome");
    $stmt->bindParam(':idInstituicao', $idInstituicao, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
  }
  function categoria_listRelacionadas($idCategoria, $includeSelf) {
    global $db;
    if ($includeSelf) {
      $stmt = $db->prepare("(SELECT Categoria.idCategoria, Categoria.nome
        FROM Categoria
        WHERE Categoria.idCategoria = :idCategoria)
        UNION (SELECT Categorias.idCategoria, Categorias.nome
        FROM Categoria
        JOIN CategoriaInstituicao CI1 USING(idCategoria)
        JOIN CategoriaInstituicao CI2 USING(idInstituicao)
        JOIN Categoria Categorias ON Categorias.idCategoria = CI2.idCategoria
        WHERE Categoria.idCategoria = :idCategoria
        AND Categorias.idCategoria <> Categoria.idCategoria
        GROUP BY Categorias.idCategoria
        ORDER BY random()
        LIMIT 4)");   
    }
    else {
      $stmt = $db->prepare("SELECT Categorias.idCategoria, Categorias.nome
        FROM Categoria
        JOIN CategoriaInstituicao CI1 USING(idCategoria)
        JOIN CategoriaInstituicao CI2 USING(idInstituicao)
        JOIN Categoria Categorias ON Categorias.idCategoria = CI2.idCategoria
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
    $stmt = $db->prepare("SELECT Pergunta.idPergunta,
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
      JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
      WHERE Pergunta.idCategoria = :idCategoria
      GROUP BY Pergunta.idPergunta, TabelaRespostas.count, Utilizador.idUtilizador
      ORDER BY Pergunta.dataHora DESC");
    $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
  }
  function categoria_getStats($filterBy) {
    global $db;
    $queryString = "SELECT Categoria.idCategoria,
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
    return $stmt->fetchAll();
  }
?>