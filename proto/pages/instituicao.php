<?
  include_once('../config/init.php');
  include_once('../database/instituicao.php');
  include_once('../database/pergunta.php');
  $smarty->assign('questions', $questions);
  $smarty->assign('instituicao', instituicao_listBySigla('feup'));
  $smarty->display('instituicao.tpl');
?>