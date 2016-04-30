<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

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
    $smarty->display('utilizador/profile.tpl');
  }
  else {
    http_response_code(404);
  }
?>