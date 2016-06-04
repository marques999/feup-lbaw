<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (!utilizador_isAdministrator($idUtilizador)) {
    safe_redirect('403.php');
  }

  if (safe_check($_POST, 'idCategoria')) {
    $idCategoria = safe_getId($_POST, 'idCategoria');
  }
  else {
    safe_formerror('Deve especificar uma categoria primeiro!');
  }

  if (safe_strcheck($_POST, 'nome')) {
    $nome = safe_trimAll($_POST, 'nome');
  }
  else {
    safe_formerror('O nome da categoria não pode estar em branco!');
  }

  try {

    if (categoria_editarCategoria($idCategoria, $nome) > 0) {
      safe_redirect("categoria/view.php?=$idCategoria");
    }
    else {
      safe_formerror('Erro desconhecido: tentou editar uma categoria inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>