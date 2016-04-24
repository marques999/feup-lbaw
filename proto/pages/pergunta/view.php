<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/categoria.php');
  include_once('../../database/pergunta.php');

  $idPergunta = safe_getId($_GET, 'id');
  $queryPergunta = pergunta_listById($idPergunta);

  if ($queryPergunta && is_array($queryPergunta)) {

    $idCategoria = safe_getId($queryPergunta, 'idcategoria');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $idAutor = safe_getId($queryPergunta, 'idutilizador');
    $queryRespostas = pergunta_fetchRespostas($idPergunta);
    $queryComentarios = pergunta_fetchComments($idPergunta);
    $queryCategorias = categoria_listRelacionadas($idCategoria, true);
    $queryRelacionadas = pergunta_fetchRelacionadas($idCategoria, $idPergunta);
    $isAdministrator = utilizador_isAdministrator($idUtilizador);
    $isModerator = utilizador_isModerator($idUtilizador);
    $userVote = pergunta_userVote($idUtilizador, $idPergunta);
    $userFollows = pergunta_userFollows($idUtilizador, $idPergunta);
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
    $smarty->assign('follows', $userFollows);
    $smarty->assign('privileges', $userPrivileges);
    $smarty->assign('myscore', $userVote);
    $smarty->display('pergunta/view.tpl');
  }
  else {
    safe_redirect('404.php');
  }
?>