<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  $returnValue = 0;

  if (safe_check($_POST, 'idConversa') && safe_check($_SESSION, 'idUtilizador')) {
    $idConversa = safe_getId($_POST, 'idConversa');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $safeDescricao = safe_trim($_POST, 'descricao');
    $stmt = $db->prepare("INSERT INTO Mensagem(idConversa, idAutor, descricao)
      VALUES(:idConversa, :idUtilizador, :descricao");
    $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
    $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);
    $stmt->bindParam(":descricao", $safeDescricao, PDO::PARAM_STR);
    $stmt->execute();
    $returnValue = $stmt->execute();
  }

  echo json_encode($returnValue);
?>