<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');
  include_once('../../lib/SimpleCache.php');

  if (safe_check($_GET, 'id')) {
    $idCategoria = safe_getId($_GET, 'id');
  }
  else {
    safe_redirect('categoria/list.php');
  }

  $queryCategoria = categoria_listById($idCategoria);

  if ($queryCategoria && is_array($queryCategoria)) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $queryPerguntas = categoria_listarPerguntas($idCategoria);
    $queryInstituicoes = categoria_listarInstituicoes($idCategoria);
    $queryRelacionadas = categoria_listarRelacionadas($idCategoria, false);
    $isAdministrator = utilizador_isAdministrator($idUtilizador);
    $nomeCategoria = $queryCategoria['nome'];
    $queryDescricao = (new SimpleCache())->get_data($nomeCategoria);
    $queryDescricao = json_decode($queryDescricao, true);
    if (isset($queryDescricao['query']) && isset($queryDescricao['query']['pages'])) {
      $pagesIndex = $queryDescricao['query']['pages'];
      if (count($pagesIndex) > 0) {
        $queryDescricao = null;
        foreach($pagesIndex as $currentPage) {
          if (isset($currentPage['extract'])) {
            $queryDescricao = $currentPage['extract'];
            break;
          }
        }
      }
      else {
        $queryDescricao = null;
      }
    }
    else {
      $queryDescricao = null;
    }
    $smarty->assign('categoria', $queryCategoria);
    $smarty->assign('perguntas', $queryPerguntas);
    $smarty->assign('relacionadas', $queryRelacionadas);
    $smarty->assign('instituicoes', $queryInstituicoes);
    $smarty->assign('administrador', $isAdministrator);
    $smarty->assign('descricao', $queryDescricao);
    $smarty->assign('titulo', $nomeCategoria);
    $smarty->assign('perguntas_count', count($queryPerguntas));
    $smarty->assign('instituicoes_count', count($queryInstituicoes));
    $smarty->display('categoria/view.tpl');
  }
  else {
    safe_redirect('404.php');
  }
?>