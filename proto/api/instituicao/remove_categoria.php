<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_checkAdministrador()) {

      if (safe_check($_POST, 'idCategoria') && safe_check($_POST, 'idInstituicao')) {

        try {
          echo instituicao_removerCategoria(
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