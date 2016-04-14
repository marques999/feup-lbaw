<? 
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  $smarty->assign('instituicoes', instituicao_listAll());
  $smarty->assign('titulo', 'Gerir Categorias');
  $smarty->display('admin/categorias.tpl');
?>