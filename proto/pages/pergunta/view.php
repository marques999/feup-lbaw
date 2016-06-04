<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_GET, 'id')) {
    $idPergunta = safe_getId($_GET, 'id');
  }
  else {
    safe_login();
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
    $isAdministrator = utilizador_isAdministrator($idUtilizador);
    $isModerator = utilizador_isModerator($idUtilizador);
    $queryUtilizador = pergunta_informacoesUtilizador($idUtilizador, $idPergunta);
    $userPrivileges = 'User';

    if ($idAutor == $idUtilizador) {
      $userPrivileges = 'OP';
    }
    else if ($isAdministrator) {
      $userPrivileges = 'Admin';
    }
    else if ($isModerator) {
      $userPrivileges = 'MOD';
    }

    $smarty->assign('pergunta', $queryPergunta);
    $smarty->assign('categorias', $queryCategorias);
    $smarty->assign('respostas', $queryRespostas);
    $smarty->assign('comentarios', $queryComentarios);
    $smarty->assign('relacionadas', $queryRelacionadas);
    $smarty->assign('administrador', $isAdministrator);
    $smarty->assign('moderador', $isModerator);
    $smarty->assign('privileges', $userPrivileges);
    $smarty->assign('utilizador', $queryUtilizador);
    $smarty->assign('titulo', $queryPergunta['titulo']);
    $smarty->display('pergunta/view.tpl');
  }
  else {
    safe_redirect('404.php');
  }
?>