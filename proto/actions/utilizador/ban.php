<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {
    safe_redirect('403.php');
  }

  if (!safe_check($_GET, 'id')) {
    safe_error(null, 'Deve especificar um utilizador primeiro!');
  }

  try {

    if (utilizador_banirUtilizador(safe_getId($_GET, 'id')) > 0) {
      safe_redirect('admin/utilizadores.php');
    }
    else {
      safe_error(null, 'Erro na operação: tentou banir um utilizador inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>