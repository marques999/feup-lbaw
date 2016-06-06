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

  if (safe_check($_GET, 'id')) {
    $idPergunta = safe_getId($_GET, 'id');
  }
  else {
    safe_redirect('404.php');
  }

  $queryPergunta = pergunta_listarInformacoes($idPergunta);
  $idAutor = safe_getId($queryPergunta, 'idutilizador');

  if ($idUtilizador == $idAutor || safe_checkModerador() || safe_checkAdministrador()) {
    $smarty->assign('pergunta', $queryPergunta);
    $smarty->assign('titulo', 'Apagar Pergunta');
    $smarty->display('pergunta/delete.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>