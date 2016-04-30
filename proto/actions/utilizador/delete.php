<?
  include_once('../../config/init.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  $isAdministrator = false;
  $ownAccount = !safe_check($_POST, 'idUtilizador');

  if ($ownAccount) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    $idUtilizador = safe_getId($_POST, 'idUtilizador');
    $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
    $isAdministrator = utilizador_isAdministrator($idUtilizador);
  }

  if (!$ownAccount && !$isAdministrator) {
    safe_redirect('403.php');
  }

  try {

    if (utilizador_delete($idUtilizador) < 1) {
      safe_error(null, 'Erro na operação, tentou apagar uma conta de outro utilizador?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }

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
?>