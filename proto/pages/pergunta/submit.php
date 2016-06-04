<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/pergunta.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }
  
  $queryCategorias = categoria_listarCategoriasJson();

  for ($i = 0; $i < count($queryCategorias); $i++) {
    $queryCategorias[$i]['json'] = json_decode($queryCategorias[$i]['json'], true);
  }

  $smarty->assign('categorias', $queryCategorias);
	$smarty->assign('titulo', 'Fazer Pergunta');
  $smarty->display('pergunta/submit.tpl');
?>