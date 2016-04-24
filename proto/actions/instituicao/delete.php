<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/instituicao.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {
    http_response_code(403);
  }

  if (!safe_check($_GET, 'id')) {
    safe_error(null, 'Deve especificar uma instituição primeiro!');
  }

  try {

    if (instituicao_delete(safe_getId($_GET, 'id')) > 0) {
      safe_redirect('admin/instituicoes.php');
    }
    else {
      safe_error(null, 'Erro desconhecido, tentou apagar uma instituição inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>