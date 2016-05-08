<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_GET, 'id')) {
    $idCategoria = safe_getId($_GET, 'id');
  }
  else {
    safe_redirect('404.php');
  }

  $queryCategoria = categoria_listById($idCategoria);

  if ($queryCategoria && is_array($queryCategoria)) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $queryPerguntas = categoria_fetchPerguntas($idCategoria);
    $queryInstituicoes = instituicao_listByCategoria($idCategoria);
    $queryRelacionadas = categoria_listRelacionadas($idCategoria, false);
    $isAdministrator = utilizador_isAdministrator($idUtilizador);
    $smarty->assign('categoria', $queryCategoria);
    $smarty->assign('perguntas', $queryPerguntas);
    $smarty->assign('relacionadas', $queryRelacionadas);
    $smarty->assign('instituicoes', $queryInstituicoes);
    $smarty->assign('administrador', $isAdministrator);
    $smarty->assign('titulo', $queryCategoria['nome']);
    $smarty->assign('perguntas_count', count($queryPerguntas));
    $smarty->assign('instituicoes_count', count($queryInstituicoes));
    $smarty->display('categoria/view.tpl');
  }
  else {
    safe_redirect('404.php');
  }
?>