<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta') && safe_strcheck($_POST, 'descricao')) {

      try {
        echo pergunta_inserirComentario(
          safe_getId($_POST, 'idPergunta'),
          safe_getId($_SESSION, 'idUtilizador'),
          safe_trimAll($_POST, 'descricao')
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
?>