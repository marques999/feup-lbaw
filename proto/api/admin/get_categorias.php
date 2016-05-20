<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {
      echo categoria_estatisticas(safe_trim($_GET, 'filter'));
    }
    else {
      http_response_code(403);
    }
  }
  else {
    http_response_code(400);
  }
?>