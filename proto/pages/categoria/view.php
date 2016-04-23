<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/categoria.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/pergunta.php');

  $idCategoria = safe_getId($_GET, 'id');
  $queryCategoria = categoria_listById($idCategoria);

  if ($queryCategoria && is_array($queryCategoria)) {

    $queryPerguntas = categoria_fetchPerguntas($idCategoria);
    $queryInstituicoes = instituicao_listByCategoria($idCategoria);
    $queryRelacionadas = categoria_listRelacionadas($idCategoria, false);
    $isAdministrator = utilizador_isAdministrator($_SESSION['idUtilizador']);

    $smarty->assign('categoria', $queryCategoria);
    $smarty->assign('perguntas', $queryPerguntas);
    $smarty->assign('relacionadas', $queryRelacionadas);
    $smarty->assign('instituicoes', $queryInstituicoes);
    $smarty->assign('administrador', $isAdministrator);
    $smarty->assign('perguntas_count', count($queryPerguntas));
    $smarty->assign('instituicoes_count', count($queryInstituicoes));
    $smarty->display('categoria/view.tpl');
  }
  else {
    safe_redirect('404.php');
  }
?>