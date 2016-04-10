<?
  include_once('../config/init.php');
  include_once('../database/instituicao.php');
  $smarty->assign('instituicoes', instituicao_listAll());
  $smarty->display('lista_instituicoes.tpl');
?>