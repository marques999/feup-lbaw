<?
  include_once('../../config/init.php');
  include_once('../../database/resposta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idResposta') && safe_strcheck($_POST, 'descricao')) {

      $idResposta = safe_getId($_POST, 'idResposta');
      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
      $descricao = safe_trim($_POST, 'descricao');

      try {
        echo resposta_inserirComentario($idResposta, $idUtilizador, $descricao);
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