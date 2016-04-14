<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $returnValue = array();

  if (safe_check($_POST, 'idPergunta') && safe_check($_POST, 'ultimoComentario')) {
    $idPergunta = safe_getId($_POST, 'idPergunta');
    $ultimoComentario = safe_getId($_POST, 'ultimoComentario');
    $stmt = $db->prepare("SELECT
        Utilizador.idUtilizador,
        Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
        Contribuicao.descricao,
        Contribuicao.dataHora
      FROM ComentarioPergunta
      JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
      JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
      WHERE ComentarioPergunta.idPergunta = :idPergunta
      AND ComentarioPergunta.idComentario > :ultimoComentario
      LIMIT 5");
    $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
    $stmt->bindParam(":ultimoComentario", $ultimoComentario, PDO::PARAM_INT);
    $stmt->execute();
    $returnValue = $stmt->fetchAll();
  }

  echo json_encode($returnValue);
?>