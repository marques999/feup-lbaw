<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');
  
  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (safe_check($_POST, 'idCategoria')) {
     $myCategoria = safe_getId($_POST, 'idCategoria');
  }
  else {
    safe_error(null, 'A categoria da pergunta não pode estar em branco!');
  }

  if (safe_strcheck($_POST, 'titulo')) {
    $myTitulo = safe_trim($_POST, 'titulo');
  }
  else {
    safe_error(null, 'O título da pergunta não pode estar em branco!');
  }

  if (safe_strcheck($_POST, 'descricao')) {
    $myDescricao = safe_trim($_POST, 'descricao');
  }
  else {
    $myDescricao = null;
  }

  try {

    if (pergunta_inserirPergunta($idUtilizador, $myCategoria, $myTitulo, $myDescricao) > 0) {
      $idPergunta = $db->lastInsertId('pergunta_idpergunta_seq');
      safe_redirect("pergunta/view.php?=$idPergunta");
    }
    else {
      safe_error(null, 'Erro desconhecido: outra pergunta com este identificador já existe?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>