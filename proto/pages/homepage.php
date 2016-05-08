<?
  include_once('../config/init.php');
  include_once('../database/categoria.php');
  include_once('../database/utilizador.php');

  $queryCategorias = categoria_listPopular();
  
  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador'); 
    $queryInstituicao = utilizador_fetchInstituicao($idUtilizador);
    $isAdministrator = utilizador_isAdministrator($idUtilizador);
    $smarty->assign('instituicao', $queryInstituicao);
    $smarty->assign('administrador', $isAdministrator);
    $smarty->assign('titulo', 'Página Inicial');
  }

  $smarty->assign('categorias', $queryCategorias);
  $smarty->display('homepage.tpl');
?>