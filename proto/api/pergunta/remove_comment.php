<?
  include_once('../../config/init.php');
  include_once('../../database/comentario.php');
  include_once('../../database/pergunta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta') && safe_check($_POST, 'idComentario')) {

      $idComentario = safe_getId($_POST, 'idComentario');
      $idPergunta = safe_getId($_POST, 'idPergunta');
      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
      $isOriginalPoster = comentario_verificarAutor($idComentario, $idUtilizador);

      if ($isOriginalPoster || safe_checkModerador() || safe_checkAdministrador()) {

        try {
          echo pergunta_removerComentario($idPergunta, $idComentario, $idUtilizador);
        }
        catch (PDOException $e) {
          http_response_code(400);
        }
      }
      else {
        http_response_code(403);
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