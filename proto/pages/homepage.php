<?
  include_once('../config/init.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $queryInstituicao = utilizador_fetchInstituicao($idUtilizador);
    $isAdministrator = utilizador_isAdministrator($idUtilizador);
    $smarty->assign('instituicao', $queryInstituicao);
    $smarty->assign('administrador', $isAdministrator);
  }
  
  $smarty->display('homepage.tpl');
?>