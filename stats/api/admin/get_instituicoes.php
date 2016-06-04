<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {
      echo instituicao_estatisticas(safe_trimAll($_GET, 'filter'));
    }
    else {
      http_response_code(403);
    }
  }
  else {
    http_response_code(400);
  }
?>