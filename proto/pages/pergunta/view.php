<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_GET, 'id')) {
    $idPergunta = safe_getId($_GET, 'id');
  }
  else {
    safe_redirect('404.php');
  }

  $queryPergunta = pergunta_listarInformacoes($idPergunta);

  if ($queryPergunta && is_array($queryPergunta)) {

    $idCategoria = safe_getId($queryPergunta, 'idcategoria');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $idAutor = safe_getId($queryPergunta, 'idutilizador');
    $queryRespostas = pergunta_obterRespostas($idPergunta);
    $queryComentarios = pergunta_obterComentarios($idPergunta);
    $queryCategorias = pergunta_listarCategorias($idCategoria);
    $queryRelacionadas = pergunta_listarRelacionadas($idCategoria, $idPergunta);
    $queryVotos = pergunta_obterVotosRespostas($idPergunta, $idUtilizador);
    $queryUtilizador = pergunta_informacoesUtilizador($idUtilizador, $idPergunta);
    $userPrivileges = 'User';

    if ($idAutor == $idUtilizador) {
      $userPrivileges = 'OP';
    }
    else if (safe_checkAdministrador()) {
      $userPrivileges = 'Admin';
    }
    else if (safe_checkModerador()) {
      $userPrivileges = 'MOD';
    }

    uasort($queryRespostas, function($a, $b) {

      if ($a['melhorresposta'] === true) {
        return false;
      }

      if ($b['melhorresposta'] === true) {
        return true;
      }

      return $a['datahora'] > $b['datahora'];
    });

    for ($i = 0; $i < count($queryVotos); $i++) {
      $idResposta = $queryVotos[$i]['idresposta'];
      $queryRespostas[$idResposta]['valor'] = $queryVotos[$i]['valor'];
    }

    if ($queryUtilizador['idseguidor'] > 0) {
      pergunta_visitarPergunta($idPergunta, $idUtilizador);
    }

    $smarty->assign('pergunta', $queryPergunta);
    $smarty->assign('categorias', $queryCategorias);
    $smarty->assign('respostas', $queryRespostas);
    $smarty->assign('comentarios', $queryComentarios);
    $smarty->assign('relacionadas', $queryRelacionadas);
    $smarty->assign('privileges', $userPrivileges);
    $smarty->assign('utilizador', $queryUtilizador);
    $smarty->assign('titulo', $queryPergunta['titulo']);
    $smarty->display('pergunta/view.tpl');
  }
  else {
    safe_redirect('404.php');
  }
?>