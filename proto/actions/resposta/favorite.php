<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_GET, 'idp')) {

      $idPergunta = safe_getId($_GET, 'idp');

      if (safe_check($_GET, 'idr')) {

        $idResposta = safe_getId($_GET, 'idr');

        $stmt = $db->prepare("UPDATE Resposta SET melhorResposta = TRUE
          WHERE idPergunta = :idPergunta AND idResposta = :idResposta");
        $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
        $stmt->bindParam(":idResposta", $idResposta, PDO::PARAM_INT);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
          safe_redirect(null);
        }
        else {
          safe_error(null, 'Erro na operação, a resposta não existe?');
        }
      }
      else {
        safe_error(null, 'Deve especificar uma resposta primeiro!');
      }
    }
    else {
      safe_error(null, 'Deve especificar uma pergunta primeiro!');
    }
  }
  else {
    http_response_code(403);
  }
?>