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

    if (utilizador_isAdministrator($idUtilizador)) {
      $grupoUtilizador = 'Administradores';
    }
    else if (utilizador_isModerator($idUtilizador)) {
      $grupoUtilizador = 'Moderadores';
    }

    $smarty->assign('utilizador', $queryUtilizador);
    $smarty->assign('grupo', $grupoUtilizador);
    $smarty->assign('perguntas', pergunta_listByAuthor($idUtilizador));
    $smarty->assign('respostas', resposta_listByAuthor($idUtilizador));
    $smarty->assign('titulo', $queryUtilizador['username']);
    $smarty->display('utilizador/profile.tpl');
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>