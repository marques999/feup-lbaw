<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_login();
  }

  if (!safe_checkAdministrador()) {
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