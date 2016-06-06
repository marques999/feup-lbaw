<?
  include_once('../config/init.php');
  include_once('../database/categoria.php');
  include_once('../database/utilizador.php');

  $queryCategorias = categoria_listarPopulares();

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $queryInstituicao = utilizador_obterInstituicao($idUtilizador);
    $smarty->assign('instituicao', $queryInstituicao);
  }

  $smarty->assign('categorias', $queryCategorias);
  $smarty->assign('titulo', 'Página Inicial');
  $smarty->display('homepage.tpl');
?>