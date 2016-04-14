<?
  include_once('../config/init.php');
  include_once('../database/categoria.php');
  include_once('../database/pergunta.php');
  $smarty->assign('questions', $questions);
  $smarty->display('categoria.tpl');
?>