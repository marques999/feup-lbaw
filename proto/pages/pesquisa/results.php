<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');
  $query = safe_trim($_GET, 'query');
  $smarty->assign('titulo', 'Pesquisa');
  $smarty->assign('perguntas', pergunta_pesquisar($query, null, null, null));
  $smarty->assign('utilizadores', utilizador_pesquisar($query, null, null, null));
  $smarty->display('pesquisa/results.tpl');
?>