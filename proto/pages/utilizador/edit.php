<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador1 = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_redirect('utilizador/login.php');
  }

  if (safe_check($_GET, 'id')) {

    $idUtilizador2 = safe_getId($_GET, 'id');

    if ($idUtilizador1 == $idUtilizador2 || utilizador_isAdministrator($idUtilizador1)) {
      $queryCountry = file_get_contents($BASE_DIR . 'javascript/countries.json');
      $smarty->assign('idUtilizador', $idUtilizador2);
      $smarty->assign('utilizador', utilizador_getById($idUtilizador2));
      $smarty->assign('instituicoes', instituicao_listAll());
      $smarty->assign('paises', json_decode($queryCountry, true));
      $smarty->assign('titulo', 'Editar Utilizador');
      $smarty->display('utilizador/edit.tpl');
    }
    else {
      safe_redirect('403.php');
    }
  }
  else {
    $queryCountry = file_get_contents('../../javascript/countries.json');
    $smarty->assign('idUtilizador', $idUtilizador1);
    $smarty->assign('utilizador', utilizador_getById($idUtilizador1));
    $smarty->assign('instituicoes', instituicao_listAll());
    $smarty->assign('paises', json_decode($queryCountry, true));
    $smarty->assign('titulo', 'Editar Utilizador');
    $smarty->display('utilizador/edit.tpl');
  }
?>