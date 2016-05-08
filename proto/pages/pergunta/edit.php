<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_redirect('utilizador/login.php');
  }

  if (safe_check($_GET, 'id')) {
    $idPergunta = safe_getId($_GET, 'id');
  }
  else {
    safe_redirect('404.php');
  }

  $queryPergunta = pergunta_listById($idPergunta);
  $idAutor = safe_getId($queryPergunta, 'idutilizador');
  $isAdministrator = utilizador_isAdministrator($idUtilizador);
  $isOriginalPoster = ($idUtilizador == $idAutor);

  if ($isOriginalPoster || $isAdministrator) {
    $smarty->assign('titulo', 'Editar Pergunta');
    $smarty->display('pergunta/edit.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>