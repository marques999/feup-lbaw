<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_checkAdministrador()) {

      if (safe_check($_POST, 'idCategoria')) {

        try {
          echo categoria_apagarCategoria(safe_getId($_POST, 'idCategoria'));
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
  }
  else {
    http_response_code(403);
  }
?>