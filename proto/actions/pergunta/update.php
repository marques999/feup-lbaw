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

  if (safe_check($_POST, 'idPergunta')) {
    $idPergunta = safe_getId($_POST, 'idPergunta');
  }
  else {
    safe_error(null, 'Deve especificar uma pergunta primeiro!');
  }

  $isOriginalPoster = pergunta_verificarAutor($idPergunta, $idUtilizador);
  $isAdministrator = utilizador_isAdministrator($idUtilizador);
  $isModerator = utilizador_isModerator($idUtilizador);

  if (!$isOriginalPoster && !$isModerator && !$isAdministrator) {
    safe_redirect('403.php');
  }

  $numberColumns = 0;

  if (safe_check($_POST, 'idCategoria')) {
    $myCategoria = safe_getId($_POST, 'idCategoria');
    $numberColumns++;
  }
  else {
    $myCategoria = null;
  }

  if (safe_strcheck($_POST, 'titulo')) {
    $myTitulo = safe_trim($_POST, 'titulo');
    $numberColumns++;
  }
  else {
    $myTitulo = null;
  }

  if (safe_strcheck($_POST, 'descricao')) {
    $myDescricao = safe_trim($_POST, 'descricao');
    $numberColumns++;
  }
  else {
    $myDescricao = null;
  }

  if ($numberColumns < 1) {
    safe_error(null, 'Operação sem efeito, não foi enviada informação suficiente...');
  }

  try {
    
    $idPergunta = safe_getId($_POST, 'idPergunta');

    if (pergunta_editarPergunta($idPergunta, $myCategoria, $myTitulo, $myDescricao) > 0) {
      safe_redirect("pergunta/view.php?id=$idPergunta");
    }
    else {
      safe_error(null, 'Erro desconhecido: tentou editar as informações de uma pergunta inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>