<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');
  $smarty->assign('titulo', 'Pesquisar Utilizadores');
  $smarty->assign('query', safe_trimAll($_GET, 'query'));
  $smarty->display('pesquisa/utilizador.tpl');
?>