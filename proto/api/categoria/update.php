<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_checkAdministrador()) {

      if (safe_check($_POST, 'idCategoria') && safe_strcheck($_POST, 'nome')) {

        try {
          echo categoria_editarCategoria(
            safe_getId($_POST, 'idCategoria'),
            safe_trimAll($_POST, 'nome')
          );
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