<?
  include_once('../../config/init.php');
  include_once('../../database/notificacao.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  $queryResposta = notificacao_novasRespostas($idUtilizador);
  $querySeguidores = notificacao_novosSeguidores($idUtilizador);
  $queryComentarios = notificacao_novosComentarios($idUtilizador);

  for ($i = 0; $i < count($queryComentarios); $i++) {
    $queryComentarios[$i]['accao1'] = 'novo comentário!';
    $queryComentarios[$i]['accao2'] = 'comentou';
  }

  for ($i = 0; $i < count($querySeguidores); $i++) {
    $querySeguidores[$i]['accao1'] = 'novo seguidor!';
    $querySeguidores[$i]['accao2'] = 'seguiu';
  }

  for ($i = 0; $i < count($queryResposta); $i++) {
    $queryResposta[$i]['accao1'] = 'nova resposta!';
    $queryResposta[$i]['accao2'] = 'respondeu';
  }

  $queryNotificacoes = $queryResposta + $querySeguidores + $queryComentarios;

  uasort($queryNotificacoes, function($a, $b){
      return $a['datahora'] < $b['datahora'];
  });

  $smarty->assign('notificacoes', $queryNotificacoes);
  $smarty->assign('notificacoes_count', count($queryNotificacoes));
  $smarty->assign('titulo', 'Notificações');
  $smarty->display('utilizador/notifications.tpl');
?>