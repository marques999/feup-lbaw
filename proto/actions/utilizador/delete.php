<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  $isAdministrator = safe_checkAdministrador();

  if (safe_check($_POST, 'idUtilizador')) {
    $idUtilizador = safe_getId($_POST, 'idUtilizador');
  }
  else {
    safe_error('Deve especificar um utilizador primeiro!');
  }

  if (!$isAdministrator && ($idUtilizador != $idAdministrador)) {
    safe_redirect('403.php');
  }

  try {

    if (utilizador_apagarUtilizador($idUtilizador) < 1) {

      if ($isAdministrator) {
        safe_redirect('admin/utilizadores.php');
      }
      else {

        if (isset($_SESSION['username'])) {
          unset($_SESSION['username']);
        }

        if (isset($_SESSION['idUtilizador'])) {
          unset($_SESSION['idUtilizador']);
        }

        session_destroy();
        safe_redirect('homepage.php');
      }
    }
    else {
      safe_error('Erro desconhecido: tentou apagar uma conta de outro utilizador?');
    }
  }
  catch (PDOException $e) {
    safe_error($e->getMessage());
  }
?>