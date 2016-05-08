<?
  include_once('../../config/init.php');
  include_once('../../database/notificacao.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
  	$idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  	$queryResposta = notificacao_novasRespostas($idUtilizador);
  	$querySeguidores = notificacao_novosSeguidores($idUtilizador);
  	$queryComentarios = notificacao_novosComentarios($idUtilizador);
  	$smarty->assign('respostas', $queryResposta);
  	$smarty->assign('seguidores', $querySeguidores);
  	$smarty->assign('comentarios', $queryComentarios);
  	$smarty->assign('respostas_count', count($queryResposta));
  	$smarty->assign('seguidores_count', count($querySeguidores));
  	$smarty->assign('comentarios_count', count($queryComentarios));
  	$smarty->assign('titulo', 'Notificações');
    $smarty->display('utilizador/notifications.tpl');
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>