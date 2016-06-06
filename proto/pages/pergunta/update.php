<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
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

    $idCategoria = safe_getId($queryPergunta, 'idcategoria');
    $queryCategorias = categoria_listarCategoriasJson();
    $queryCategoriasRelacionadas = pergunta_listarCategorias($idCategoria);
    $queryRespostas = pergunta_obterRespostas($idPergunta);
    $queryRelacionadas = pergunta_listarRelacionadas($idCategoria, $idPergunta);

    uasort($queryRespostas, function($a, $b) {

      if ($a['melhorresposta'] === true) {
        return false;
      }

      if ($b['melhorresposta'] === true) {
        return true;
      }

      return $a['datahora'] > $b['datahora'];
    });

    for ($i = 0; $i < count($queryCategorias); $i++) {
      $queryCategorias[$i]['json'] = json_decode($queryCategorias[$i]['json'], true);
    }

    $smarty->assign('pergunta', $queryPergunta);
    $smarty->assign('select', $queryCategorias);
    $smarty->assign('categorias', $queryCategoriasRelacionadas);
    $smarty->assign('respostas', $queryRespostas);
    $smarty->assign('relacionadas', $queryRelacionadas);
    $smarty->assign('titulo', 'Editar Pergunta');
    $smarty->display('pergunta/update.tpl');
  }
  else {
    safe_redirect('403.php');
  }
?>