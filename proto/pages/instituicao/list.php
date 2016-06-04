<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');
  $smarty->assign('instituicoes', instituicao_listarInstituicoes());
  $smarty->assign('titulo', 'Instituições');
  $smarty->display('instituicao/list.tpl');
?>