<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_login();
  }

  if (safe_checkAdministrador()) {
    $queryActivos = utilizador_listarActivos();
    $queryBanidos = utilizador_listarBanidos();
    $queryInativos = utilizador_listarRemovidos();
    $smarty->assign('ativos', $queryActivos);
    $smarty->assign('banidos', $queryBanidos);
    $smarty->assign('inativos', $queryInativos);
    $smarty->assign('ativos_count', count($queryActivos));
    $smarty->assign('banidos_count', count($queryBanidos));
    $smarty->assign('inativos_count', count($queryInativos));
    $smarty->assign('titulo', 'Gerir Utilizadores');
    $smarty->display('admin/utilizadores.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>