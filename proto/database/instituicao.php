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
  $numberColumns = 0;
  if ($nome!=null) {
    $queryString .= "nome = :nome";
    $numberColumns++;
  }
  if ($sigla!=null) {
    $queryString .= ($numberColumns > 0 ? ', sigla = :sigla' : 'sigla = :sigla');
    $numberColumns++;
  }
  if ($morada!=null) {
    $queryString .= ($numberColumns > 0 ? ', morada = :morada' : 'morada = :morada');
    $numberColumns++;
  }
  if ($contacto!=null) {
    $queryString .= ($numberColumns > 0 ? ', contacto = :contacto' : 'contacto = :contacto');
    $numberColumns++;
  }
  if ($website!=null) {
    $queryString .= ($numberColumns > 0 ? ', website = :website' : 'website = :website');
    $numberColumns++;
  }
  $queryString .= ' WHERE sigla = :idInstituicao';
  $stmt = $db->prepare($queryString);
  $stmt->bindParam(":idInstituicao", $idInstituicao, PDO::PARAM_STR);
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
  $stmt = $db->prepare("INSERT INTO CategoriaInstituicao(idInstituicao, idCategoria) VALUES(:idInstituicao, :idCategoria)");
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
function instituicao_listBySigla($siglaInstituicao) {
  global $db;
  $stmt = $db->prepare("SELECT * FROM Instituicao WHERE sigla = :sigla");
  $stmt->bindParam(':sigla', $siglaInstituicao, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->fetch();
}
function instituicao_listarInstituicoes() {
  global $db;
  $stmt = $db->query("SELECT
      Instituicao.idInstituicao,
      Instituicao.nome,
      Instituicao.sigla,
      COUNT(DISTINCT CategoriaInstituicao.idCategoria) AS numeroCategorias,
      COUNT(DISTINCT Pergunta.idPergunta) AS numeroPerguntas,
      COUNT(DISTINCT Utilizador.idUtilizador) AS numeroUtilizadores
    FROM Instituicao
    LEFT JOIN CategoriaInstituicao USING(idInstituicao)
    LEFT JOIN Utilizador USING(idInstituicao)
    LEFT JOIN Pergunta USING (idCategoria)
    GROUP BY idInstituicao
    ORDER BY sigla");
  return $stmt->fetchAll();
}
function instituicao_listarCategorias($idInstituicao) {
  global $db;
  $stmt = $db->prepare("SELECT Categoria.*
    FROM CategoriaInstituicao
    NATURAL JOIN Categoria
    WHERE idInstituicao = :idInstituicao
    ORDER BY nome");
  $stmt->bindParam(':idInstituicao', $idInstituicao, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function instituicao_listarPerguntas($idInstituicao) {
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
      Pergunta.respostas,
      Pergunta.pontuacao,
      COALESCE(COUNT(valor) FILTER (WHERE valor = 1), 0) AS votosPositivos,
      COALESCE(COUNT(valor) FILTER (WHERE valor = -1), 0) AS votosNegativos
    FROM CategoriaInstituicao
    NATURAL JOIN Pergunta
    INNER JOIN Utilizador USING(idUtilizador)
    LEFT JOIN VotoPergunta USING(idPergunta)
    WHERE CategoriaInstituicao.idInstituicao = :idInstituicao
    GROUP BY idPergunta, Utilizador.idUtilizador
    ORDER BY dataHora DESC");
  $stmt->bindParam(':idInstituicao', $idInstituicao, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function instituicao_getImagem($sigla) {
  $imageLocation = glob("../../images/instituicao/{$sigla}.{jpg,jpeg,gif,png}", GLOB_BRACE);
  return $imageLocation != false ? $imageLocation[0] : "holder.js/550x330/auto/ink";
}
?>