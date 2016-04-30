  <?
  function conversa_fetchMessages($idConversa) {
    global $db;
    $stmt = $db->prepare("SELECT Conversa.titulo,
      Mensagem.idMensagem,
      Mensagem.descricao,
      Mensagem.dataHora,
      Instituicao.sigla,
      AutorMensagem.idUtilizador,
      AutorMensagem.removido,
      AutorMensagem.username,
      AutorMensagem.primeiroNome || ' ' || AutorMensagem.ultimoNome AS nomeautor
    FROM Mensagem
    JOIN Conversa USING(idConversa)
    JOIN Utilizador AutorMensagem ON AutorMensagem.idUtilizador = Mensagem.idAutor
    JOIN Instituicao ON Instituicao.idInstituicao = AutorMensagem.idInstituicao
    WHERE Mensagem.idConversa = :idConversa");
    $stmt->bindParam(':idConversa', $idConversa, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
  }
  function conversa_delete($idConversa, $idUtilizador) {
    global $db;
    $stmt = $db->prepare("DELETE FROM Conversa
      WHERE idConversa = :idConversa
      AND (idUtilizador1 = :idUtilizador
      OR idUtilizador2 = :idUtilizador)");
    $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->rowCount();
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
  function conversa_apagarThread($idUtilizador1, $idUtilizador2) {
    global $db;
    $stmt = $db->prepare("DELETE FROM Conversa WHERE idUtilizador1 = :idRemetente AND idUtilizador2 = :idDestinatario");
  $stmt->bindParam(":idRemetente", $idUtilizador1, PDO::PARAM_INT);
  $stmt->bindParam(":idDestinatario", $idUtilizador2, PDO::PARAM_INT);
  return $stmt->execute();
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
    $stmt = $db->prepare("SELECT * FROM Conversa WHERE idConversa = :idConversa LIMIT 1");
    $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetch();
  }
  ?>