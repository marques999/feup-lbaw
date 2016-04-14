<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $returnValue = array();

  if (safe_check($_POST, 'idResposta') && safe_check($_POST, 'ultimoComentario')) {
    $idResposta = safe_getId($_POST, 'idResposta');
    $ultimoComentario = safe_getId($_POST, 'ultimoComentario');
    $stmt = $db->prepare("SELECT
        Utilizador.idUtilizador,
        Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
        Contribuicao.descricao,
        Contribuicao.dataHora
      FROM ComentarioResposta
      JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
      JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
      WHERE ComentarioResposta.idResposta = :idResposta
      AND ComentarioResposta.idComentario > :ultimoComentario
      LIMIT 5");
    $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
    $stmt->bindParam(":ultimoComentario", $ultimoComentario, PDO::PARAM_INT);
    $stmt->execute();
    $returnValue = $stmt->fetchAll();
  }

  echo json_encode($returnValue);
?>