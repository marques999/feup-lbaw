<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  $idUtilizador = safe_getId($_POST, 'idUtilizador');
  $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
  $isAdministrator = utilizador_isAdministrator($idUtilizador);
  $isOwner = $isAdministrator && ($idUtilizador != $idAdministrador);

  if (!$isOwner && !$isAdministrator) {
    safe_redirect('403.php');
  }

  if (!safe_check($_POST, 'idUtilizador')) {
    safe_error(null, 'Deve especificar um utilizador primeiro!');
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
      safe_error(null, 'Erro na operação: tentou apagar uma conta de outro utilizador?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>