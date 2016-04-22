  <?
  function conversa_fetchMessages($idConversa) {
    global $db;
    $stmt = $db->prepare("SELECT Conversa.titulo,
      Mensagem.idMensagem,
      Mensagem.descricao,
      Instituicao.sigla,
      to_char(Mensagem.dataHora, 'Day DD/MM/YYYY HH:MM') as datahora,
      AutorMensagem.idUtilizador,
      AutorMensagem.username,
      AutorMensagem.primeiroNome || ' ' || AutorMensagem.ultimoNome AS nomeautor
    FROM Mensagem
    JOIN Conversa USING(idConversa)
    JOIN Utilizador AutorMensagem ON AutorMensagem.idUtilizador = Mensagem.idAutor
    JOIN Instituicao ON Instituicao.idInstituicao = AutorMensagem.idUtilizador
    WHERE Mensagem.idConversa = :idConversa");
    $stmt->bindParam(':idConversa', $idConversa, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
  }
  function conversa_criarThread($idUtilizador1, $idUtilizador2, $titulo) {
  	global $db;
  	$stmt = $db->prepare("INSERT INTO Conversa(idUtilizador1, idUtilizador2, titulo) VALUES(:idRemetente, :idDestinatario, :titulo)");
	$stmt->bindParam(":idRemetente", $idUtilizador1, PDO::PARAM_INT);
	$stmt->bindParam(":idDestinatario", $idUtilizador2, PDO::PARAM_INT);
	$stmt->bindParam(":titutlo", $titulo, PDO::PARAM_STR);
	return $stmt->execute();
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