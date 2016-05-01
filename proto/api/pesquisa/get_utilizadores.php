<?
  include_once('../../config/init.php');
  include_once('../../database/pesquisa.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    try {
      echo utilizador_pesquisar(
        safe_trim($_GET, 'query'),
        safe_trim($_GET, 'filter'),
        safe_trim($_GET, 'sort'),
        safe_trim($_GET, 'order')
      );
    }
    catch (PDOException $e) {
      http_response_code(400);
    }
  }
  else {
    http_response_code(403);
  }
?>