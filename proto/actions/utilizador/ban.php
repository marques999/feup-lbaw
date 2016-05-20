<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('Deve estar autenticado para aceder a esta página!', 'utilizador/login.php');
  }

  if (!utilizador_isAdministrator($idAdministrador) {
    safe_redirect('403.php');
  }

  if (safe_check($_GET, 'id')) {
    $idUtilizador = safe_getId($_GET, 'id');
  }
  else {
    safe_error('Deve especificar um utilizador primeiro!');
  }

  try {

    if (utilizador_banirUtilizador($idUtilizador) > 0) {
      safe_redirect('admin/utilizadores.php');
    }
    else {
      safe_error('Erro desconhecido: tentou banir um utilizador inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error($e->getMessage());
  }
?>