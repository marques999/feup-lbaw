<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/utilizador.php');
  $queryCategorias = categoria_listAll();
  $smarty->assign('numberRows', count($queryCategorias) / 4);
  $smarty->assign('categorias', $queryCategorias);
  $smarty->assign('titulo', 'Categorias');
  $smarty->display('categoria/list.tpl');
?>