<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');

  if (safe_strcheck($_GET, 'id')) {
    $idInstituicao = safe_trimAll($_GET, 'id');
    $queryInstituicao = instituicao_listBySigla($idInstituicao);
  }
  else {
    safe_redirect('instituicao/list.php');
  }

  if ($queryInstituicao && is_array($queryInstituicao)) {
    $idInstituicao = $queryInstituicao['idinstituicao'];
    $queryCategorias = instituicao_listarCategorias($idInstituicao);
    $queryPerguntas = instituicao_listarPerguntas($idInstituicao);
    $isAdministrator = utilizador_isAdministrator($_SESSION['idUtilizador']);
    $smarty->assign('instituicao', $queryInstituicao);
    $smarty->assign('categorias', $queryCategorias);
    $smarty->assign('perguntas', $queryPerguntas);
    $smarty->assign('administrador', $isAdministrator);
    $smarty->assign('titulo', strtoupper($queryInstituicao['sigla']));
    $smarty->assign('categorias_count', count($queryCategorias));
    $smarty->assign('perguntas_count', count($queryPerguntas));
    $smarty->display('instituicao/view.tpl');
  }
  else {
    safe_redirect('404.php');
  }
?>