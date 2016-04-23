<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/categoria.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/pergunta.php');

  $siglaInstituicao = safe_trim($_GET['id']);
  $queryInstituicao = instituicao_listBySigla($siglaInstituicao);

  if ($queryInstituicao && is_array($queryInstituicao)) {

	$idInstituicao = $queryInstituicao['idinstituicao'];
    $queryCategorias = categoria_listByInstituicao($idInstituicao);
    $queryPerguntas = instituicao_fetchPerguntas($idInstituicao);
    $isAdministrator = utilizador_isAdministrator($_SESSION['idUtilizador']);

    $smarty->assign('instituicao', $queryInstituicao);
    $smarty->assign('categorias', $queryCategorias);
    $smarty->assign('perguntas', $queryPerguntas);
    $smarty->assign('administrador', $isAdministrator);
    $smarty->assign('categorias_count', count($queryCategorias));
    $smarty->assign('perguntas_count', count($queryPerguntas));
    $smarty->display('instituicao/view.tpl');
  }
  else {
    safe_redirect('404.php');
  }
?>