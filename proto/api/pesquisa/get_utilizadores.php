<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/pesquisa.php');

  $query = safe_trim($_GET['query']);
  $filterBy = safe_trim($_GET['filter']);
  $sortBy = safe_trim($_GET['sort']);
  $orderBy = safe_trim($_GET['order']);
 
  echo json_encode(utilizador_pesquisar($query, $filterBy, $sortBy, $orderBy));
?>