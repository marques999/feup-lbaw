<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {

      if (safe_strcheck($_POST, 'nome')) {

        try {
          echo categoria_adicionarCategoria(safe_trimAll($_POST, 'nome'));
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