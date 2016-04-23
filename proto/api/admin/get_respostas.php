<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/pergunta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

    if (utilizador_isAdministrator($idUtilizador)) {
      echo json_encode(resposta_getStats(safe_trim($_GET['filter'])));
    }
    else {
      http_response_code(403);
    }
  }
  else {
    http_response_code(400);
  }
?>