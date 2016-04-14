<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $returnValue = array();

  if (safe_check($_POST, 'idPergunta') && safe_check($_POST, 'ultimoAcesso')) {
    $idPergunta = safe_getId($_POST, 'idPergunta');
    $stmt = $db->prepare("SELECT
        Utilizador.idUtilizador,
        Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
        Contribuicao.descricao,
        Contribuicao.dataHora
      FROM ComentarioPergunta
      JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
      AND Contribuicao.dataHora > :ultimoAcesso
      JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
      WHERE ComentarioPergunta.idPergunta = :idPergunta");
    $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
    $stmt->bindParam(":ultimoAcesso", $_POST['ultimoAcesso'], PDO::PARAM_STR);
    $stmt->execute();
    $returnValue = $stmt->fetchAll();
  }

  echo json_encode($returnValue);
?>