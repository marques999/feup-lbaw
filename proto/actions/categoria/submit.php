<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('Deve estar autenticado para aceder a esta página!', 'utilizador/login.php');
  }

  if (!utilizador_isAdministrator($idUtilizador)) {
    safe_redirect('403.php');
  }

  if (safe_strcheck($_POST, 'nome')) {
    $nome = safe_trim($_POST, 'nome');
  }
  else {
    safe_formerror('O nome da categoria não pode estar em branco!');
  }

  try {

    if (categoria_adicionarCategoria($nome) > 0) {
      safe_redirect("categoria/view.php?=$idCategoria");
    }
    else {
      safe_formerror('Erro desconhecido: tentou adicionar uma categoria que já existe?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>