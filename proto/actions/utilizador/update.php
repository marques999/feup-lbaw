<?
  include_once('../../config/init.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    $isAdministrator = false;
    $ownAccount = !safe_check($_GET, 'id');

    if ($ownAccount) {
      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    }
    else {
      $idUtilizador = safe_getId($_GET, 'id');
      $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
      $isAdministrator = utilizador_isAdministrator($idUtilizador);
    }

    if ($ownAccount || $isAdministrator) {

      $stmt = $db->prepare('UPDATE Utilizador SET ');
      $hasEmail = safe_check($_POST, 'email');
      $numberColumns = 0;

      if ($hasEmail) {
        $queryString .= 'email = :email';
        $numberColumns++;
      }

      $hasFirstName = safe_check($_POST, 'primeiroNome');

      if ($hasFirstName) {
        $queryString .= ($numberColumns > 0 ? ', primeironome = :primeiroNome' : 'primeironome = :primeiroNome');
        $numberColumns++;
      }

      $hasLastName = safe_check($_POST, 'ultimoNome');

      if ($hasLastName) {
        $queryString .= ($numberColumns > 0 ? ', ultimonome = :ultimoNome' : 'ultimonome = :ultimoNome');
        $numberColumns++;
      }

      $hasLocalidade = safe_check($_POST, 'localidade');

      if ($hasLocalidade) {
        $queryString .= ($numberColumns > 0 ? ', localidade = :localidade' : 'localidade = :localidade');
        $numberColumns++;
      }

      $hasCodigoPais = safe_check($_POST, 'codigoPais');

      if ($hasCodigoPais) {
        $queryString .= ($numberColumns > 0 ? ', codigoPais = :codigoPais' : 'codigoPais = :codigoPais');
        $numberColumns++;
      }

      if ($numberColumns > 0) {

          $stmt = $db->prepare($queryString);
          $stmt->bindParam(":idUtilizador", $idUtilizador, PDO::PARAM_INT);

          if ($hasEmail) {
            $safeEmail = safe_trim($_POST, 'email');
            $stmt->bindParam(':email', $safeEmail, PDO::PARAM_STR);
          }

          if ($hasFirstName) {
            $safeFirstName = safe_trim($_POST, 'primeiroNome');
            $stmt->bindParam(':primeiroNome', $safeFirstName, PDO::PARAM_STR);
          }

          if ($hasLastName) {
            $safeUltimoNome = safe_trim($_POST, 'ultimoNome');
            $stmt->bindParam(':ultimoNome', $safeUltimoNome, PDO::PARAM_STR);
          }

          if ($hasLocalidade) {
            $safeLocalidade = safe_trim($_POST, 'localidade');
            $stmt->bindParam(':localidade', $safeLocalidade, PDO::PARAM_STR);
          }

          if ($hasCodigoPais) {
            $safeCodigoPais = safe_trim($_POST, 'codigoPais');
            $stmt->bindParam(':codigoPais', $safeCodigoPais, PDO::PARAM_STR);
          }

          try {
            $stmt->execute();
          }
          catch (PDOException $e) {
            safe_error(null, $e->getMessage());
          }

          if ($stmt->rowCount() > 0) {

            if ($isAdministrator) {
              safe_redirect('admin/utilizadores.php');
            }
            else {
              safe_redirect(null);
            }
          }
          else {
            safe_error(null, 'Erro na operação, utilizador inexistente?');
          }
      }
      else {
        safe_error('admin/utilizadores.php', 'Operação sem efeito, nenhum campo foi alterado...');
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