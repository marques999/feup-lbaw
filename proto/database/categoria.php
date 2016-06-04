<?
function categoria_adicionarCategoria($nome) {
  global $db;
  $stmt = $db->prepare("INSERT INTO Categoria(idCategoria, nome) VALUES(DEFAULT, :nome)");
  $stmt->bindParam(":nome", $nome, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function categoria_editarCategoria($idCategoria, $nome) {
  global $db;
  $stmt = $db->prepare("UPDATE Categoria SET nome = :nome WHERE idCategoria = :idCategoria");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->bindParam(':nome', $nome, PDO::PARAM_STR);
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
function categoria_listById($idCategoria) {
  global $db;
  $stmt = $db->prepare("SELECT * FROM Categoria WHERE idCategoria = :idCategoria");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
function categoria_listarCategorias() {
  global $db;
  $stmt = $db->query("SELECT Categoria.*,
    COUNT(DISTINCT idPergunta) AS numeroPerguntas
    FROM Categoria
    NATURAL LEFT JOIN Pergunta
    GROUP BY idCategoria
    ORDER BY nome");
  return $stmt->fetchAll();
}
function categoria_listarCategoriasJson() {
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
function categoria_listarPopulares() {
  global $db;
  $stmt = $db->query("SELECT Categoria.*,
    COUNT(DISTINCT idPergunta) AS numeroPerguntas
    FROM Categoria
    INNER JOIN Pergunta USING(idCategoria)
    GROUP BY idCategoria, idPergunta
    ORDER BY numeroPerguntas DESC
    LIMIT 5");
  return $stmt->fetchAll();
}
function categoria_listarRelacionadas($idCategoria) {
  global $db;
  $stmt = $db->prepare("SELECT Categorias.*
    FROM Categoria
    INNER JOIN CategoriaInstituicao CI1 USING(idCategoria)
    INNER JOIN CategoriaInstituicao CI2 USING(idInstituicao)
    INNER JOIN Categoria Categorias ON Categorias.idCategoria = CI2.idCategoria
    WHERE Categoria.idCategoria = :idCategoria
    AND Categorias.idCategoria <> Categoria.idCategoria
    GROUP BY Categorias.idCategoria
    ORDER BY random() LIMIT 5");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function categoria_listarInstituicoes($idCategoria) {
  global $db;
  $stmt = $db->prepare("SELECT idInstituicao, sigla
    FROM Instituicao
    NATURAL JOIN CategoriaInstituicao
    WHERE idCategoria = :idCategoria");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function categoria_listarPerguntas($idCategoria) {
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
    FROM Pergunta
    INNER JOIN Utilizador USING(idUtilizador)
    LEFT JOIN VotoPergunta USING(idPergunta)
    WHERE idCategoria = :idCategoria
    GROUP BY idPergunta, Utilizador.idUtilizador
    ORDER BY dataHora DESC");
  $stmt->bindParam(':idCategoria', $idCategoria, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
?>