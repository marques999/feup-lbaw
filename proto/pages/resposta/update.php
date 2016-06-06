<?
  include_once('../../config/init.php');
  include_once('../../database/resposta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_GET, 'id')) {
    $idResposta = safe_getId($_GET, 'id');
  }
  else {
    safe_redirect('404.php');
  }

  $queryResposta = resposta_listById($idResposta);
  $idAutor = safe_getId($queryResposta, 'idutilizador');

  if ($idUtilizador == $idAutor || safe_checkModerador() || safe_checkAdministrador()) {
    $smarty->assign('titulo', 'Editar Resposta');
    $smarty->display('resposta/update.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>