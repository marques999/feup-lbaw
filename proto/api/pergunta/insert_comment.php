<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/pergunta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta') && safe_strcheck($_POST, 'descricao')) {

      $idPergunta = safe_getId($_POST, 'idPergunta');
      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
      $safeDescricao = safe_trim($_POST, 'descricao');

      try {
        echo pergunta_inserirComentario($idPergunta, $idUtilizador, $safeDescricao);
      }
      catch (PDOException $e) {
        http_response_code(400);
      }
    }
    else {
      http_response_code(400);
    }
  }
  else {
    http_response_code(403);
  }
?>