<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  //---------------------------------------------
  $smarty->assign('perguntas', pergunta_pesquisar($_GET['query']));
  $smarty->display('pesquisa/pergunta.tpl');
?>