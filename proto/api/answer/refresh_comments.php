<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $returnValue = array();

  if (safe_check($_POST, 'idResposta') && safe_check($_POST, 'ultimoAcesso')) {
    $idResposta = safe_getId($_POST, 'idResposta');
    $stmt = $db->prepare("SELECT
        Utilizador.idUtilizador,
        Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
        Contribuicao.descricao,
        Contribuicao.dataHora
      FROM ComentarioResposta
      JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
      AND Contribuicao.dataHora > :ultimoAcesso
      JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
      WHERE ComentarioResposta.idResposta = :idResposta");
    $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
    $stmt->bindParam(":ultimoAcesso", $_POST['ultimoAcesso'], PDO::PARAM_STR);
    $stmt->execute();
    $returnValue = $stmt->fetchAll();
  }

  echo json_encode($returnValue);
?>