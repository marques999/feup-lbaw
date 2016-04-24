<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/categoria.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {
    http_response_code(403);
  }

  if (!safe_check($_GET, 'id')) {
    safe_error(null, 'Deve especificar uma categoria primeiro!');
  }

  try {

    if (categoria_delete(safe_getId($_GET, 'id')) > 0) {
      safe_redirect('admin/categorias.php');
    }
    else {
      safe_error(null, 'Erro desconhecido, tentou apagar uma categoria inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>