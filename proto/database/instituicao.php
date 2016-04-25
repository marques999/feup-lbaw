<?
  function instituicao_listAll() {
    global $db;
    $stmt = $db->query("SELECT Instituicao.idInstituicao,
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
  function instituicao_delete($idInstituicao) {
    global $db;
    $stmt = $db->prepare("DELETE FROM Instituicao WHERE idInstituicao = :idInstituicao");
    $stmt->bindParam(":idInstituicao", $idInstituicao, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->rowCount();
  }
  function instituicao_editarInstituicao($idInstituicao, $nome, $sigla, $morada, $contacto, $website) {
    global $db;
    $queryString = "UPDATE Instituicao SET ";
    $hasNome = safe_strcheck($nome);
    $hasSigla = safe_strcheck($sigla);
    $hasMorada = safe_strcheck($morada);
    $hasContacto = safe_strcheck($contacto);
    $hasWebsite = safe_strcheck($website);
    $numberColumns = 0;
    if ($hasNome) {
      $queryString += "nome = :nome";
      $numberColumns++;
    }
    if ($hasSigla) {
      if ($numberColumns > 0) {
        $queryString .= ', ';
      }
      $queryString += 'sigla = :sigla';
      $numberColumns++;
    }
    if ($hasMorada) {
      if ($numberColumns > 0) {
        $queryString .= ', ';
      }
      $queryString += 'morada = :morada';
      $numberColumns++;
    }
    if ($hasContacto) {
      if ($numberColumns > 0) {
        $queryString .= ', ';
      }     
      $queryString += 'contacto = :contacto';
      $numberColumns++;
    }
    if ($hasWebsite) {
      if ($numberColumns > 0) {
        $queryString .= ', ';
      }   
      $queryString += 'website = :website';
      $numberColumns++;
    }
    $queryString += ' WHERE idInstituicao = :idInstituicao';
    $stmt = $db->prepare($queryString);
    $stmt->bindParam(":idInstituicao", $idInstituicao, PDO::PARAM_INT);
    if ($hasNome) {
      $stmt->bindParam(':nome', $safeNome, PDO::PARAM_STR);
    }
    if ($hasSigla) {
      $stmt->bindParam(':sigla', $safeSigla, PDO::PARAM_STR);
    }
    if ($hasMorada) {
      $stmt->bindParam(':morada', $safeMorada, PDO::PARAM_STR);
    }
    if ($hasContacto) {
      $stmt->bindParam(':contacto', $safeContacto, PDO::PARAM_STR);
    }
    if ($hasWebsite) {
      $stmt->bindParam(':website', $safeWebsite, PDO::PARAM_STR);
    }
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
  function instituicao_listById($idInstituicao) {
    global $db;
    $stmt = $db->prepare("SELECT * FROM Instituicao WHERE idInstituicao = :idInstituicao");
    $stmt->bindParam(':idInstituicao', $idInstituicao, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetch();
  }
  function instituicao_listByCategoria($idCategoria) {
    global $db;
    $stmt = $db->prepare("SELECT Instituicao.idInstituicao, Instituicao.sigla
      FROM Categoria
      JOIN CategoriaInstituicao USING(idCategoria)
      JOIN Instituicao USING(idInstituicao)
      WHERE Categoria.idCategoria = :idCategoria");
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
      FROM CategoriaInstituicao
      JOIN Pergunta USING(idCategoria)
      JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
      LEFT JOIN VotoPergunta USING(idPergunta)
      LEFT JOIN (SELECT idPergunta, COUNT(*)
        FROM Resposta
        GROUP BY idPergunta)
        AS TabelaRespostas
        USING (idPergunta)
      WHERE CategoriaInstituicao.idInstituicao = :idInstituicao
      GROUP BY Pergunta.idPergunta, TabelaRespostas.count, Utilizador.idUtilizador
      ORDER BY Pergunta.dataHora DESC");
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
      JOIN Pergunta USING(idCategoria)
      JOIN Instituicao USING(idInstituicao)
      GROUP BY Instituicao.idInstituicao\n";
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