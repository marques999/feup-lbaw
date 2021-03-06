<?
function conversa_criarConversa($idRemetente, $idDestinatario, $titulo, $descricao) {
  global $db;
  $stmt = $db->prepare("WITH NovaConversa AS (
    INSERT INTO Conversa(idConversa, idUtilizador1, idUtilizador2, titulo)
    VALUES(DEFAULT, :idRemetente, :idDestinatario, :titulo) RETURNING idConversa
  ) INSERT INTO Mensagem(idConversa, idUtilizador, descricao)
    SELECT idConversa, :idRemetente, :descricao
    FROM NovaConversa");
  $stmt->bindParam(":idRemetente", $idRemetente, PDO::PARAM_INT);
  $stmt->bindParam(":idDestinatario", $idDestinatario, PDO::PARAM_INT);
  $stmt->bindParam(":titulo", $titulo, PDO::PARAM_STR);
  $stmt->bindParam(":descricao", $descricao, PDO::PARAM_STR);
  $stmt->execute();
  if ($stmt->rowCount()) {
    return $db->lastInsertId('conversa_idconversa_seq');
  }
  return 0;
}
function conversa_apagarConversa($idConversa, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("DELETE FROM Conversa
    WHERE idConversa = :idConversa
    AND idUtilizador1 = :idUtilizador");
  $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function conversa_listarConversas($idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT
      Conversa.idConversa,
      Conversa.titulo,
      (CASE WHEN :idUtilizador = idUtilizador1 THEN ultimoAcesso1 ELSE ultimoAcesso2 END) AS ultimoAcesso,
      Utilizador.idUtilizador AS idDestinatario,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeDestinatario,
      Instituicao.sigla,
      (SELECT COUNT(*) FROM Mensagem WHERE Mensagem.idConversa = Conversa.idConversa) AS numeroMensagens,
      Mensagem1.idUtilizador AS idUtilizador,
      AutorMensagem.username AS nomeAutor,
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
    JOIN Utilizador AutorMensagem ON AutorMensagem.idUtilizador = Mensagem1.idUtilizador
    JOIN Instituicao ON Instituicao.idInstituicao = Utilizador.idInstituicao
    WHERE (idUtilizador1 = :idUtilizador OR idUtilizador2 = :idUtilizador)
    AND Mensagem2.idMensagem IS NULL
    ORDER BY Mensagem1.dataHora DESC");
  $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function conversa_listarInformacoes($idConversa) {
  global $db;
  $stmt = $db->prepare("SELECT Conversa.*,
    Utilizador1.removido AS remetenteRemovido,
    Utilizador2.removido AS destinatarioRemovido
    FROM Conversa
    INNER JOIN Utilizador Utilizador1 ON Utilizador1.idUtilizador = Conversa.idUtilizador1
    INNER JOIN Utilizador Utilizador2 ON Utilizador2.idUtilizador = Conversa.idUtilizador2
    WHERE idConversa = :idConversa");
  $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetch();
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
    NATURAL JOIN Utilizador
    NATURAL LEFT JOIN Instituicao
    WHERE idConversa = :idConversa");
  $stmt->bindParam(':idConversa', $idConversa, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->fetchAll();
}
function conversa_enviarMensagem($idConversa, $idRemetente, $descricao) {
  global $db;
  $stmt = $db->prepare('INSERT INTO Mensagem(idMensagem, idConversa, idUtilizador, descricao)
    VALUES(DEFAULT, :idConversa, :idRemetente, :descricao)');
  $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
  $stmt->bindParam(":idRemetente", $idRemetente, PDO::PARAM_INT);
  $stmt->bindParam(":descricao", $descricao, PDO::PARAM_STR);
  $stmt->execute();
  return $stmt->rowCount();
}
function covnersa_apagarMensagem($idConversa, $idMensagem, $idUtilizador) {
  global $db;
  $stmt = $db->prepare('DELETE FROM Mensagem
    WHERE idConversa = :idConversa
    AND idMensagem = :idMensagem
    AND idUtilizador = :idUtilizador');
  $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
  $stmt->bindParam(":idMensagem", $idMensagem, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $stmt->execute();
  return $stmt->rowCount();
}
function conversa_verificarAutor($idConversa, $idUtilizador) {
  global $db;
  $stmt = $db->prepare("SELECT idUtilizador1 FROM Conversa
    WHERE idConversa = :idConversa
    AND idUtilizador1 = :idUtilizador");
  $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
  $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
  $result = $stmt->execute();
  return $result && is_array($result);
}
?>