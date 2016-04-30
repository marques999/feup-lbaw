<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!safe_check($_POST, 'idCategoria')) {
    safe_error(null, 'Deve especificar uma categoria primeiro!');
  }

  if (!safe_strcheck($_POST, 'titulo')) {
    safe_error(null, 'O título da pergunta não pode estar em branco!');
  }

  $idCategoria = safe_getId($_POST, 'idCategoria');
  $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  $safeTitle = safe_trim($_POST, 'titulo');

  if (safe_strcheck($_POST, 'descricao') {
    $safeMessage = safe_trim($_POST, 'descricao');
  }

  try {

    if (pergunta_inserirPergunta($idUtilizador, $idCategoria, $safeTitle, $safeMessage) > 0) {
      $idPergunta = $db->lastInsertId('pergunta_idpergunta_seq');
      safe_redirect("pergunta/view.php?=$idPergunta");
    }
    else {
      safe_error(null, 'Erro na operação, outra pergunta com este identificador já existe?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>