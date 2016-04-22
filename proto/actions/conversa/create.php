<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $idRemetente = safe_getId($_SESSION, 'idUtilizador');

    if (safe_check($_POST, 'idDestinatario') && safe_check($_POST, 'titulo')) {

      $idDestinatario = safe_getId($_POST, 'idDestinatario');
      $safeTitulo = safe_trim($_POST, 'titulo');

      if (safe_check($_POST, 'descricao')) {

        $stmt = $db->prepare("INSERT INTO Conversa(idUtilizador1, idUtilizador2, titulo)
          VALUES(DEFAULT, :idRemetente, :idDestinatario, :titulo)");
        $stmt->bindParam(":idRemetente", $idRemetente, PDO::PARAM_INT);
        $stmt->bindParam(":idDestinatario", $idDestinatario, PDO::PARAM_INT);
        $stmt->bindParam(":titulo", $safeTitulo, PDO::PARAM_STR);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {

          $safeDescricao = safe_trim($_POST, 'descricao');
          $idConversa = $db->lastInsertId();
          $stmt = $db->prepare('INSERT INTO Mensagem(idConversa, idAutor, descricao)
            VALUES(:idConversa, :idRemetente, :descricao');
          $stmt->bindParam(":idConversa", $idConversa, PDO::PARAM_INT);
          $stmt->bindParam(":idRemetente", $idRemetente, PDO::PARAM_INT);
          $stmt->bindParam(":descricao", $safeDescricao, PDO::PARAM_STR);

          try {
            $stmt->execute();
          }
          catch (PDOException $e) {
            safe_error(null, $e->getMessage());
          }

          if ($stmt->rowCount() > 0) {
            safe_redirect(null);
          }
          else {
            safe_error(null, 'Erro na operaçao, outra mensagem com este identificador já existe.');
          }
        }
        else {
          safe_error(null, 'Erro na operação, outra conversa com este identificador já existe.');
        }
      }
      else {
        safe_error(null, 'O corpo da mensagem não pode estar vazio!');
      }
    }
    else {
      safe_error(null, 'Deve especificar uma conversa primeiro!');
    }
  }
  else {
    http_response_code(403);
  }
?>