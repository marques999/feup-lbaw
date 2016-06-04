<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  $queryCountry = file_get_contents('../../javascript/countries.json');

  if (safe_check($_GET, 'id')) {

    $idUtilizador = safe_getId($_GET, 'id');

    if ($idAdministrador == $idUtilizador || utilizador_isAdministrator($idAdministrador)) {
      $smarty->assign('idUtilizador', $idUtilizador);
      $smarty->assign('utilizador', utilizador_getById($idUtilizador));
      $smarty->assign('instituicoes', instituicao_listarInstituicoes());
      $smarty->assign('paises', json_decode($queryCountry, true));
      $smarty->assign('titulo', 'Editar Utilizador');
    }
    else {
      safe_redirect('403.php');
    }
  }
  else {
    $smarty->assign('idUtilizador', $idAdministrador);
    $smarty->assign('utilizador', utilizador_getById($idAdministrador));
    $smarty->assign('instituicoes', instituicao_listarInstituicoes());
    $smarty->assign('paises', json_decode($queryCountry, true));
    $smarty->assign('titulo', 'Editar Utilizador');
  }

  $smarty->display('utilizador/update.tpl');
?>