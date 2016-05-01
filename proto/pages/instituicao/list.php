<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');
  $smarty->assign('instituicoes', instituicao_listAll());
  $smarty->display('instituicao/list.tpl');
?>