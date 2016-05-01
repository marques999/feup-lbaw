<?
function conversa_criarThread($idRemetente, $idDestinatario, $titulo) {
  global $db;
  $stmt = $db->prepare("INSERT INTO Conversa(idConversa, idUtilizador1, idUtilizador2, titulo)
    VALUES(DEFAULT, :idRemetente, :idDestinatario, :titulo)");
  $stmt->bindParam(":idRemetente", $idRemetente, PDO::PARAM_INT);
  $stmt->bindParam(":idDestinatario", $idDestinatario, PDO::PARAM_INT);
  $stmt->bindParam(":titulo", $safeTitulo, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function conversa_apagarThread($idConversa, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("DELETE FROM Conversa
    WHERE idConversa = :idConversa
    AND idUtilizador1 = :idUtilizador");
  $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function conversa_verificarAutor($idConversa, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT FROM Conversa
    WHERE idConversa = :idConversa
    AND idUtilizador1 = :idUtilizador");
  $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $result = $stmt->execute();
  return $result && is_array($result);
}
function conversa_obterConversas($idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT
      Conversa.idConversa,
      Conversa.titulo,
      (CASE WHEN :idUtilizador = idUtilizador1 THEN ultimoAcesso1 ELSE ultimoAcesso2 END) AS ultimoacesso,
      Utilizador.idUtilizador AS iddestinatario,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomedestinatario,
      Instituicao.sigla,
      (SELECT COUNT(*) FROM Mensagem WHERE Mensagem.idConversa = Conversa.idConversa) AS numeromensagens,
      Mensagem1.idAutor AS idautor,
      AutorMensagem.username AS nomeautor,
      AutorMensagem.removido,
      Mensagem1.descricao,
      Mensagem1.dataHora
    FROM Conversa
    JOIN Utilizador ON Utilizador.idUtilizador = (CASE WHEN :idUtilizador = idUtilizador1
    THEN idUtilizador2 ELSE idUtilizador1 END)
    JOIN Mensagem Mensagem1 ON Mensagem1.idConversa = Conversa.idConversa
    LEFT OUTER JOIN Mensagem Mensagem2 ON (Mensagem2.idConversa = Conversa.idConversa
    AND Mensagem1.dataHora < Mensagem2.dataHora OR Mensagem1.dataHora = Mensagem2.dataHora
    AND Mensagem1.idMensagem < Mensagem2.idMensagem)
    JOIN Utilizador AutorMensagem ON AutorMensagem.idUtilizador = Mensagem1.idAutor
    JOIN Instituicao ON Instituicao.idInstituicao = Utilizador.idInstituicao
    WHERE (idUtilizador1 = :idUtilizador OR idUtilizador2 = :idUtilizador)
    AND Mensagem2.idMensagem IS NULL");
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function conversa_obterMensagens($idConversa) {
  global $db;
  $stmt = $db->prepare("SELECT
      Mensagem.idMensagem,
      Mensagem.descricao,
      Mensagem.dataHora,
      Instituicao.sigla,
      Utilizador.idUtilizador,
      Utilizador.removido,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador
    FROM Mensagem
    INNER JOIN Utilizador ON Utilizador.idUtilizador = Mensagem.idAutor
    LEFT JOIN Instituicao USING (idInstituicao)
    WHERE idConversa = :idConversa");
  $stmt->bindParam(':idConversa', $idConversa, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function conversa_enviarMensagem($idConversa, $idRemetente, $descricao) {
  global $db;
  $stmt = $db->prepare('INSERT INTO Mensagem(idMensagem, idConversa, idAutor, descricao)
    VALUES(DEFAULT, :idConversa, :idRemetente, :descricao');
  $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
  $stmt->bindParam(":idRemetente", $idRemetente, PDO::PARAM_INT);
  $stmt->bindParam(":descricao", $descricao, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function conversa_listAll($idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT * FROM Conversa WHERE idUtilizador1 = :idUtilizador OR idUtilizador2 = :idUtilizador");
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function conversa_listById($idConversa) {
  global $db;
  $stmt = $db->prepare("SELECT * FROM Conversa WHERE idConversa = :idConversa");
  $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
}
?>