<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (!safe_checkAdministrador()) {
    safe_redirect('403.php');
  }

  if (safe_strcheck($_GET, 'id')) {
    $idInstituicao = safe_trimAll($_GET, 'id');
    $queryInstituicao = instituicao_listBySigla($idInstituicao);
  }
  else {
    safe_redirect('404.php');
  }

  if ($queryInstituicao && is_array($queryInstituicao)) {

    $idInstituicao = $queryInstituicao['idinstituicao'];
    $queryCategorias = categoria_listarCategoriasJson();

    for ($i = 0; $i < count($queryCategorias); $i++) {
      $queryCategorias[$i]['json'] = json_decode($queryCategorias[$i]['json'], true);
    }

    $smarty->assign('instituicao', $queryInstituicao);
    $smarty->assign('categorias', $queryCategorias);
    $smarty->assign('titulo', 'Editar Instituição');
    $smarty->display('instituicao/update.tpl');
  }
  else {
    safe_redirect('404.php');
  }
?>