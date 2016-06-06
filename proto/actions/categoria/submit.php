<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_login();
  }

  if (!safe_checkAdministrador()) {
    safe_redirect('403.php');
  }

  if (safe_strcheck($_POST, 'nome')) {
    $nome = safe_trimAll($_POST, 'nome');
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