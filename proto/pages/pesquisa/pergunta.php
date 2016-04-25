<?
  include_once('../../config/init.php');
  include_once('../../database/pesquisa.php');

  $query = safe_trim($_GET, 'query');
  $smarty->assign('perguntas', pergunta_pesquisar($query));
  $smarty->display('pesquisa/pergunta.tpl');
?>