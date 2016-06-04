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
  $idAutor = safe_getId($queryPergunta, 'idutilizador');
  $isAdministrator = utilizador_isAdministrator($idUtilizador);
  $isModerator = utilizador_isModerator($idUtilizador);

  if ($idUtilizador == $idAutor || $isModerator || $isAdministrator) {
    $smarty->assign('titulo', 'Editar Resposta');
    $smarty->display('resposta/edit.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>