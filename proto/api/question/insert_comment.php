<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $returnValue = 0;

  if (safe_check($_POST, 'idPergunta') && safe_check($_SESSION, 'idUtilizador')) {
    $idPergunta = safe_getId($_POST, 'idPergunta');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $safeDescricao = safe_trim($_POST, 'descricao');
    $stmt = $db->prepare("INSERT INTO Contribuicao(idAutor, descricao)
      VALUES(:idUtilizador, :descricao);
      SELECT currval(pg_get_serial_sequence('contribuicao', 'idContribuicao'))
      AS novoComentario;
      INSERT INTO ComentarioPergunta(idComentario, idPergunta)
      VALUES(novoComentario, :idPergunta)");
    $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->bindParam(":descricao", $safeDescricao, PDO::PARAM_STR);
    $stmt->execute();
    $returnValue = $stmt->execute();
  }

  echo json_encode($returnValue);
?>