<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/pergunta.php');

  $idPergunta = safe_getId($_GET, 'id');
  $queryPergunta = pergunta_listById($idPergunta);

  if ($queryPergunta && is_array($queryPergunta)) {
    
    $idCategoria = safe_getId($queryPergunta, 'idcategoria');
    $queryInstituicoes = instituicao_listByCategoria($idCategoria);
    $queryRespostas = pergunta_fetchRespostas($idPergunta);
    $queryComentarios = pergunta_fetchComments($idPergunta);
    $isAdministrator = utilizador_isAdministrator($_SESSION['idUtilizador']);
    $isModerator = utilizador_isModerator($_SESSION['idUtilizador']);

    $smarty->assign('pergunta', $queryPergunta);
    $smarty->assign('instituicoes', $queryInstituicoes);
    $smarty->assign('respostas', $queryRespostas);
    $smarty->assign('comentarios', $queryComentarios);
    $smarty->assign('administrador', $isAdministrator);
    $smarty->assign('moderador', $isModerator);
    $smarty->assign('categorias', (11));
    $smarty->display('pergunta/view.tpl');
  }
  else {
    safe_redirect('404.php');
  }
?>