<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/categoria.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {

      if (safe_check($_POST, 'nome')) {

        try {
          echo categoria_adicionarCategoria(safe_getId($_POST, 'nome'));
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