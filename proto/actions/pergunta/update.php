<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_POST, 'idPergunta')) {
    $idPergunta = safe_getId($_POST, 'idPergunta');
  }
  else {
    safe_formerror('Deve especificar uma pergunta primeiro!');
  }

  $isOriginalPoster = pergunta_verificarAutor($idPergunta, $idUtilizador);
  $isAdministrator = utilizador_isAdministrator($idUtilizador);
  $isModerator = utilizador_isModerator($idUtilizador);

  if (!$isOriginalPoster && !$isModerator && !$isAdministrator) {
    safe_redirect('403.php');
  }

  $numberColumns = 0;

  if (safe_check($_POST, 'categoria')) {
    $idCategoria = safe_getId($_POST, 'categoria');
    $numberColumns++;
  }
  else {
    $idCategoria = null;
  }

  if (safe_strcheck($_POST, 'titulo')) {
    $titulo = safe_trimAll($_POST, 'titulo');
    $numberColumns++;
  }
  else {
    $titulo = null;
  }

  if (safe_strcheck($_POST, 'descricao')) {
    $descricao = safe_trim($_POST, 'descricao');
    $numberColumns++;
  }
  else {
    $descricao = null;
  }

  if ($numberColumns < 1) {
    safe_formerror('Erro na operação: não foi enviada informação suficiente!');
  }

  try {

    if (pergunta_editarPergunta($idPergunta, $idCategoria, $titulo, $descricao) > 0) {
      safe_redirect("pergunta/view.php?id=$idPergunta");
    }
    else {
      safe_formerror('Erro desconhecido: tentou editar as informações de uma pergunta inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>