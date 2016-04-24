<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/pesquisa.php');

  echo pergunta_pesquisar(
  	safe_trim($_GET['query']),
  	safe_trim($_GET['filter']),
  	safe_trim($_GET['sort']),
  	safe_trim($_GET['order'])
  );
?>