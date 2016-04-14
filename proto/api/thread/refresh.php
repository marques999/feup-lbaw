<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $returnValue = array();

  if (safe_check($_POST, 'idConversa') && safe_check($_POST, 'ultimoAcesso')) {
    $idConversa = safe_getId($_POST, 'idConversa');
    $stmt = $db->prepare("SELECT
        Conversa.titulo,
        Mensagem.idMensagem,
        Mensagem.descricao,
        to_char(Mensagem.dataHora, 'Day DD/MM/YYYY HH:MM') as datahora,
        AutorMensagem.idUtilizador,
        AutorMensagem.username,
        AutorMensagem.primeiroNome || ' ' || AutorMensagem.ultimoNome AS nomeautor
      FROM Mensagem
      JOIN Conversa USING(idConversa)
      JOIN Utilizador AutorMensagem ON AutorMensagem.idUtilizador = Mensagem.idAutor
      WHERE Mensagem.idConversa = :idConversa
      AND Mensagem.dataHora > ultimoAcesso");
    $stmt->bindParam(':idConversa', $idConversa, PDO::PARAM_INT);
    $stmt->bindParam(":ultimoAcesso", $_POST['ultimoAcesso'], PDO::PARAM_STR);
    $stmt->execute();
    $returnValue = $stmt->fetchAll();
  }

  echo json_encode($returnValue);
?>