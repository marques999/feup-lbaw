<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  //---------------------------------------------
  $queryCategorias = categoria_listAll();
  $smarty->assign('numberRows', count($queryCategorias) / 4);
  $smarty->assign('categorias', $queryCategorias);
  $smarty->display('categoria/list.tpl');
?>