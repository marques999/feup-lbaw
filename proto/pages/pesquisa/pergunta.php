<?
  include_once('../../config/init.php');
  include_once('../../database/pesquisa.php');
  $smarty->assign('titulo', 'Pesquisar Perguntas');
  $smarty->assign('query', safe_trim($_GET, 'query'));
  $smarty->display('pesquisa/pergunta.tpl');
?>