<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('Deve estar autenticado para aceder a esta página!', 'utilizador/login.php');
  }

  if (safe_check($_POST, 'idCategoria')) {
    $idCategoria = safe_getId($_POST, 'idCategoria');
  }
  else {
    safe_formerror('A categoria da pergunta não pode estar em branco!');
  }

  if (safe_strcheck($_POST, 'titulo')) {
    $titulo = safe_trim($_POST, 'titulo');
  }
  else {
    safe_formerror('O título da pergunta não pode estar em branco!');
  }

  if (safe_strcheck($_POST, 'descricao')) {
    $descricao = safe_trim($_POST, 'descricao');
  }
  else {
    $descricao = null;
  }

  try {

    $idPergunta = pergunta_inserirPergunta($idUtilizador, $idCategoria, $titulo, $descricao);

    if ($idPergunta > 0) {
      safe_redirect("pergunta/view.php?=$idPergunta");
    }
    else {
      safe_formerror('Erro desconhecido: outra pergunta com este identificador já existe?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>