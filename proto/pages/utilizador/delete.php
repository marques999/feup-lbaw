<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_GET, 'id')) {

    $idUtilizador = safe_getId($_GET, 'id');
    $queryUtilizador = utilizador_getById($idUtilizador);

    if ($queryUtilizador && is_array($queryUtilizador)) {

      if ($idAdministrador == $idUtilizador || safe_checkAdministrador()) {
        $smarty->assign('nomeUtilizador', $queryUtilizador['username']);
        $smarty->assign('idUtilizador', $idUtilizador);
      }
      else {
        safe_redirect('403.php');
      }
    }
    else {
      safe_redirect('404.php');
    }
  }
  else {
    
    $queryUtilizador = utilizador_getById($idAdministrador);

    if ($queryUtilizador && is_array($queryUtilizador)) {
      $smarty->assign('nomeUtilizador', $queryUtilizador['username']);
      $smarty->assign('idUtilizador', $idAdministrador);
    }
    else {
      safe_redirect('404.php');
    }
  }

  $smarty->assign('titulo', 'Apagar Utilizador');
  $smarty->display('utilizador/delete.tpl');
?>