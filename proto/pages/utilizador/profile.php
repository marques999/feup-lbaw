<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/pergunta.php');

  $idUtilizador = 0;  
  
  if (safe_check($_GET, 'id')) {
    $idUtilizador = safe_getId($_GET, 'id');
  }
  else if ($_SESSION['idUtilizador']) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }

  $queryUtilizador = utilizador_getById($idUtilizador); 
  
  if ($queryUtilizador && is_array($queryUtilizador)) {
    $smarty->assign('utilizador', $queryUtilizador);
    $smarty->assign('perguntas', pergunta_listByAuthor($idUtilizador));
    $smarty->assign('respostas', resposta_listByAuthor($idUtilizador));
    $smarty->display('utilizador/profile.tpl'); 
  }
  else {
    http_response_code(404);
  }
?>