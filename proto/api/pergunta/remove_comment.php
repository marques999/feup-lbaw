<?
  include_once('../../config/init.php');
  include_once('../../database/comentario.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_POST, 'idPergunta') && safe_check($_POST, 'idComentario')) {

      $idComentario = safe_getId($_POST, 'idComentario');
      $idPergunta = safe_getId($_POST, 'idPergunta');
      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
      $isOriginalPoster = comentario_verificarAutor($idComentario, $idUtilizador);
      $isAdministrator = utilizador_isAdministrator($idUtilizador);
      $isModerator = utilizador_isModerator($idUtilizador);

      if ($isOriginalPoster || $isModerator || $isAdministrator) {

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