<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');
  $smarty->assign('titulo', 'Pesquisar Perguntas');
  $smarty->assign('query', safe_trimAll($_GET, 'query'));
  $smarty->display('pesquisa/pergunta.tpl');
?>