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

  if (!safe_check($_POST, 'idCategoria')) {
    safe_error(null, 'Deve especificar uma categoria primeiro!');
  }

  if (!safe_strcheck($_POST, 'nome')) {
    safe_error(null, 'O nome da categoria não pode estar em branco!');
  }

  try {

    $idCategoria = safe_getId($_POST, 'idCategoria');
    $nomeCategoria = safe_trim($_POST, 'nome');

    if (categoria_update($idCategoria, $nomeCategoria) > 0) {
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