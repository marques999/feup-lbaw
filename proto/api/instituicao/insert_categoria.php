<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {

      if (safe_check($_POST, 'idCategoria') && safe_check($_POST, 'idInstituicao')) {

        try {
          echo instituicao_associarCategoria(
            safe_getId($_POST, 'idInstituicao'),
            safe_getId($_POST, 'idCategoria')
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