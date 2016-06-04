<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/utilizador.php');
  $queryCategorias = categoria_listarCategorias();
  $numeroCategorias = count($queryCategorias);
  $ultimaLinha = round($numeroCategorias % 4);
  $numeroLinhas = floor(($numeroCategorias - $ultimaLinha) / 3);
  $smarty->assign('numberRows', $numeroLinhas);
  $smarty->assign('categorias', $queryCategorias);
  $smarty->assign('titulo', 'Categorias');
  $smarty->display('categoria/list.tpl');
?>