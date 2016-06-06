<?
function utilizador_isAdministrator($idUtilizador) {
  global $db;
  $stmt = $db->prepare('SELECT * FROM Administrador WHERE idAdministrador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  $result = $stmt->fetch();
  return $result && is_array($result);
}
function utilizador_isModerator($idUtilizador) {
  global $db;
  $stmt = $db->prepare('SELECT * FROM Moderador WHERE idModerador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  $result = $stmt->fetch();
  return $result && is_array($result);
}
function utilizador_registarVisita($idUtilizador) {
  global $db;
  $stmt = $db->prepare('SELECT registarVisita(:idUtilizador)');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
}
function utilizador_validateLogin($username, $password) {
  global $db;
  $stmt = $db->prepare('SELECT * FROM Utilizador WHERE username = :username');
  $stmt->bindParam(':username', $username, PDO::PARAM_STR);
  $stmt->execute();
  $result = $stmt->fetch();
  if ($result && is_array($result)) {
    if (validate_password($password, $result['password'])) {
        return $result['idutilizador'];
    }
  }
  return 0;
}
function utilizador_validateId($idUtilizador, $password) {
  global $db;
  $stmt = $db->prepare('SELECT * FROM Utilizador WHERE idUtilizador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  $result = $stmt->fetch();
  return $result && is_array($result) && validate_password($password, $result['password']);
}
function utilizador_inserirUtilizador($username, $password, $email, $primeiroNome, $ultimoNome) {
  global $db;
  $stmt = $db->prepare('INSERT INTO Utilizador(idUtilizador, username, password, email, primeiroNome, ultimoNome)
    VALUES(DEFAULT, :username, :password, :email, :primeiroNome, :ultimoNome)');
  $stmt->bindParam(':username', $username, PDO::PARAM_STR);
  $stmt->bindParam(':password', create_hash($password), PDO::PARAM_STR);
  $stmt->bindParam(':email', $email, PDO::PARAM_STR);
  $stmt->bindParam(':primeiroNome', $primeiroNome, PDO::PARAM_STR);
  $stmt->bindParam(':ultimoNome', $ultimoNome, PDO::PARAM_STR);
  $stmt->execute();
  if($stmt->rowCount()){
    return $db->lastInsertId('utilizador_idutilizador_seq');
  }
  return 0;
}
function utilizador_editarUtilizador($idUtilizador, $primeiroNome, $ultimoNome, $email, $idInstituicao, $localidade, $codigoPais) {
  global $db;
  $queryString = "UPDATE Utilizador SET ";
  $numberColumns = 0;
  if ($primeiroNome!=null) {
    $queryString .= ($numberColumns > 0 ? ', primeiroNome = :primeiroNome' : 'primeiroNome = :primeiroNome');
    $numberColumns++;
  }
  if ($ultimoNome!=null) {
    $queryString .= ($numberColumns > 0 ? ', ultimoNome = :ultimoNome' : 'ultimoNome = :ultimoNome');
    $numberColumns++;
  }
  if ($email!=null) {
    $queryString .= ($numberColumns > 0 ? ', email = :email' : 'email = :email');
    $numberColumns++;
  }
  if ($idInstituicao != null) {
    $queryString .= ($numberColumns > 0 ? ', idInstituicao = :idInstituicao' : 'idInstituicao = :idInstituicao');
    $numberColumns++;
  }
  if ($localidade != null) {
    $queryString .= ($numberColumns > 0 ? ', localidade = :localidade' : 'localidade = :localidade');
    $numberColumns++;
  }
  if ($codigoPais != null) {
    $queryString .= ($numberColumns > 0 ? ', codigoPais = :codigoPais' : 'codigoPais = :codigoPais');
    $numberColumns++;
  }
  $queryString .= ' WHERE idUtilizador = :idUtilizador';
  $stmt = $db->prepare($queryString);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  if ($primeiroNome != null) {
    $stmt->bindParam(':primeiroNome', $primeiroNome, PDO::PARAM_STR);
  }
  if ($ultimoNome != null) {
    $stmt->bindParam(':ultimoNome', $ultimoNome, PDO::PARAM_STR);
  }
  if ($email != null) {
    $stmt->bindParam(':email', $email, PDO::PARAM_STR);
  }
  if ($idInstituicao != null) {
    if ($idInstituicao > 0) {
      $stmt->bindParam(':idInstituicao', $idInstituicao, PDO::PARAM_INT);
    }
    else {
      $idInstituicao = null;
      $stmt->bindParam(':idInstituicao', $idInstituicao, PDO::PARAM_NULL);
    }
  }
  if ($localidade != null) {
    $stmt->bindParam(':localidade', $localidade, PDO::PARAM_STR);
  }
  if ($codigoPais != null) {
    if ($codigoPais == 'null') {
      $codigoPais = null;
      $stmt->bindParam(':codigoPais', $codigoPais, PDO::PARAM_NULL);
    }
    else {
      $stmt->bindParam(':codigoPais', $codigoPais, PDO::PARAM_STR);
    }
  }
  $stmt->execute();
  return $stmt->rowCount();
}
function utilizador_alterarPassword($idUtilizador, $password) {
  global $db;
  $stmt = $db->prepare('UPDATE Utilizador SET password = :password WHERE idUtilizador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->bindParam(':password', create_hash($password), PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function utilizador_apagarUtilizador($idUtilizador) {
  global $db;
  $stmt = $db->prepare('UPDATE Utilizador SET removido = TRUE WHERE idUtilizador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function utilizador_banirUtilizador($idUtilizador) {
  global $db;
  $stmt = $db->prepare('UPDATE Utilizador SET ativo = FALSE WHERE idUtilizador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function utilizador_obterInstituicao($idUtilizador) {
  global $db;
  $stmt = $db->prepare('SELECT idInstituicao, sigla
    FROM Utilizador
    LEFT JOIN Instituicao USING (idInstituicao)
    WHERE idUtilizador = :idUtilizador');
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function utilizador_getById($idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome,
      Utilizador.ultimoNome,
      Utilizador.primeiroNome || ' '  || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.email,
      Instituicao.idInstituicao,
      Instituicao.sigla,
      Instituicao.website,
      Utilizador.localidade,
      Utilizador.codigoPais,
      Utilizador.dataRegisto,
      Utilizador.ultimaSessao,
      Utilizador.ativo,
      Utilizador.removido
    FROM Utilizador
    LEFT JOIN Instituicao USING(idInstituicao)
    WHERE idUtilizador = :idUtilizador
    GROUP BY idUtilizador, Instituicao.idInstituicao");
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function utilizador_listarActivos() {
  global $db;
  $stmt = $db->query("SELECT Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.email,
      Utilizador.localidade,
      Utilizador.codigoPais,
      Utilizador.ultimaSessao,
      Instituicao.sigla,
      COALESCE(COUNT(DISTINCT Pergunta.idPergunta), 0) AS numeroPerguntas,
      COALESCE(COUNT(DISTINCT Resposta.idResposta), 0) AS numeroRespostas
    FROM Utilizador
    LEFT JOIN Pergunta USING(idUtilizador)
    LEFT JOIN Contribuicao USING(idUtilizador)
    LEFT JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
    LEFT JOIN Instituicao USING(idInstituicao)
    WHERE ativo AND NOT removido
    AND idUtilizador <> 1
    GROUP BY idUtilizador, sigla
    ORDER BY idUtilizador");
  return $stmt->fetchAll();
}
function utilizador_listarBanidos() {
  global $db;
  $stmt = $db->query("SELECT Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.email,
      Utilizador.localidade,
      Utilizador.codigoPais,
      Utilizador.ultimaSessao,
      Instituicao.sigla,
      COALESCE(COUNT(DISTINCT Pergunta.idPergunta), 0) AS numeroPerguntas,
      COALESCE(COUNT(DISTINCT Resposta.idResposta), 0) AS numeroRespostas
    FROM Utilizador
    LEFT JOIN Pergunta USING(idUtilizador)
    LEFT JOIN Contribuicao USING(idUtilizador)
    LEFT JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
    LEFT JOIN Instituicao USING(idInstituicao)
    WHERE NOT ativo AND NOT removido
    AND idUtilizador <> 1
    GROUP BY idUtilizador, sigla
    ORDER BY idUtilizador");
  return $stmt->fetchAll();
}
function utilizador_listarRemovidos() {
  global $db;
  $stmt = $db->query("SELECT Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.email,
      Utilizador.localidade,
      Utilizador.codigoPais,
      Utilizador.ultimaSessao,
      Instituicao.sigla,
      COALESCE(COUNT(DISTINCT Pergunta.idPergunta), 0) AS numeroPerguntas,
      COALESCE(COUNT(DISTINCT Resposta.idResposta), 0) AS numeroRespostas
    FROM Utilizador
    LEFT JOIN Pergunta USING(idUtilizador)
    LEFT JOIN Contribuicao USING(idUtilizador)
    LEFT JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
    LEFT JOIN Instituicao USING(idInstituicao)
    WHERE removido
    AND idUtilizador <> 1
    GROUP BY idUtilizador, sigla
    ORDER BY idUtilizador");
  return $stmt->fetchAll();
}
function utilizador_pesquisar($query, $filter, $sort, $order) {
  global $db;
  $emptyQuery = empty($query);
  if ($emptyQuery) {
    $queryString = "SELECT
      Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.email,
      to_char(Utilizador.ultimaSessao, 'FMDay, DD FMMonth YYYY HH24:MI') as dataHora
    FROM Utilizador";
  }
  else {
    $queryString = "SELECT
      UtilizadoresPesquisa.idUtilizador,
      UtilizadoresPesquisa.username,
      UtilizadoresPesquisa.nomeUtilizador,
      UtilizadoresPesquisa.email,
      to_char(UtilizadoresPesquisa.ultimaSessao, 'FMDay, DD FMMonth YYYY HH24:MI') AS dataHora,
      ts_rank_cd(UtilizadoresPesquisa.pesquisa, query) AS rank
    FROM UtilizadoresPesquisa, plainto_tsquery('english', :stringPesquisa) AS query
    WHERE query @@ pesquisa";
  }
  if ($filter == 'active') {
    if ($emptyQuery) {
      $queryString .= ' WHERE ativo AND NOT removido';
    }
    else {
      $queryString .= ' AND ativo AND NOT removido';
    }
  }
  else if ($filter == 'removed') {
    if ($emptyQuery) {
      $queryString .= ' WHERE removido';
    }
    else {
      $queryString .= ' AND removido';
    }
  }
  else if ($filter == 'banned') {
    if ($emptyQuery) {
      $queryString .= ' WHERE NOT ativo AND NOT removido';
    }
    else {
      $queryString .= ' AND NOT ativo AND NOT removido';
    }
  }
  if ($sort == 'username') {
    $queryString .= ' ORDER BY username';
  }
  else if ($sort == 'email') {
    $queryString .= ' ORDER BY email';
  }
  else if ($sort == 'name') {
    $queryString .= ' ORDER BY nomeUtilizador';
  }
  else if ($sort == 'session') {
    $queryString .= ' ORDER BY ultimaSessao';
  }
  else {
    if ($emptyQuery) {
      $queryString .= ' ORDER BY idUtilizador';
    }
    else {
      $queryString .= ' ORDER BY rank';
    }
  }
  if ($order == 'descending') {
    $queryString .= ' DESC';
  }
  else if ($order == 'ascending') {
    $queryString .= ' ASC';
  }
  else {
    if ($sort == 'rank') {
      $queryString .= ' DESC';
    }
    else {
      $queryString .= ' ASC';
    }
  }
  $stmt = $db->prepare($queryString);
  if (!$emptyQuery)  {
    $stmt->bindParam(':stringPesquisa', $query, PDO::PARAM_STR);
  }
  try {
    $stmt->execute();
  }
  catch (PDOException $e) {
    return false;
  }
  return json_encode($stmt->fetchAll());
}
function utilizador_getAvatar($idUtilizador) {
  $avatarLocation = glob("../../images/avatars/{$idUtilizador}.{jpg,jpeg,gif,png}", GLOB_BRACE);
  return $avatarLocation != false ? $avatarLocation[0] : "holder.js/200x200/auto/ink";
}
?>