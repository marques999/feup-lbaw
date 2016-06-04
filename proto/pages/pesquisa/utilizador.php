<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');
  $query = safe_trim($_GET, 'query');
  $smarty->assign('titulo', 'Pesquisar Utilizadores');
  $smarty->assign('utilizadores', utilizador_pesquisar($query, null, null, null));
  $smarty->display('pesquisa/utilizador.tpl');
?>