<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/resposta.php');

  if (safe_check($_POST, 'idResposta')) {

    $idResposta = safe_getId($_POST, 'idResposta');

    if (safe_check($_POST, 'ultimoComentario')) {

      try {
        echo resposta_fetchCommentsAfter($idResposta, safe_getId($_POST, 'ultimoComentario'));
      }
      catch (PDOException $e) {
        http_response_code(400);
      }
    }
    else {

      try {
        echo resposta_fetchCommentsJson($idResposta);
      }
      catch (PDOException $e) {
        http_response_code(400);
      }
    }
  }
  else {
    http_response_code(400);
  }
?>