<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {
    safe_redirect('403.php');
  }

  if (!safe_check($_POST, 'idInstituicao')) {
    safe_error(null, 'Deve especificar uma instituição primeiro!');
  }

  try {

    if (instituicao_apagarInstituicao(safe_trim($_POST, 'idInstituicao')) > 0) {
      safe_redirect('admin/instituicoes.php');
    }
    else {
      safe_error(null, 'Erro desconhecido: tentou apagar uma instituição inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>