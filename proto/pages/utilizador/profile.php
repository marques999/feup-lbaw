<?
  include_once('../../config/init.php');
  include_once('../../database/country.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/resposta.php');
  include_once('../../database/utilizador.php');

  $idUtilizador = 0;

  if (safe_check($_GET, 'id')) {
    $idUtilizador = safe_getId($_GET, 'id');
  }
  else if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }

  $queryUtilizador = utilizador_getById($idUtilizador);

  if ($queryUtilizador && is_array($queryUtilizador)) {

    $grupoUtilizador = 'Utilizadores';

    if (safe_checkAdministrador()) {
      $grupoUtilizador = 'Administradores';
    }
    else if (safe_checkModerador()) {
      $grupoUtilizador = 'Moderadores';
    }

    $queryPerguntas = pergunta_listByAuthor($idUtilizador);
    $queryRespostas = resposta_listByAuthor($idUtilizador);
    $smarty->assign('utilizador', $queryUtilizador);
    $smarty->assign('grupo', $grupoUtilizador);
    $smarty->assign('perguntas', $queryPerguntas);
    $smarty->assign('respostas', $queryRespostas);
    $smarty->assign('perguntas_count', count($queryPerguntas));
    $smarty->assign('respostas_count', count($queryRespostas));
    $smarty->assign('titulo', $queryUtilizador['username']);
    $smarty->display('utilizador/profile.tpl');
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>