<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/utilizador.php');
  $smarty->assign('categorias', categoria_listarCategorias());
  $smarty->assign('titulo', 'Categorias');
  $smarty->display('categoria/list.tpl');
?>