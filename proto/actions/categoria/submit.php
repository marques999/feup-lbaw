<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/utilizador.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {
    safe_redirect('403.php');
  }

  if (!safe_strcheck($_POST, 'nome')) {
    safe_error(null, 'O nome da categoria não pode estar em branco!');
  }

  try {

    if (categoria_adicionarCategoria(safe_trim($_POST, 'nome')) > 0) {
      safe_redirect("categoria/view.php?=$idCategoria");
    }
    else {
      safe_error(null, 'Erro na operação, nenhum tuplo foi alterado!');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>