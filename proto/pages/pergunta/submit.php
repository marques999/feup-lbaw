<?
  include_once('../../config/init.php');
  include_once('../../database/categoria.php');
  include_once('../../database/utilizador.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_login();
  }

  $queryCategorias = categoria_listarCategoriasJson();

  for ($i = 0; $i < count($queryCategorias); $i++) {
    $queryCategorias[$i]['json'] = json_decode($queryCategorias[$i]['json'], true);
  }

  if (safe_check($_GET, 'id')) {
    $smarty->assign('idCategoria', safe_getId($_GET, 'id'));
  }

  $smarty->assign('select', $queryCategorias);
  $smarty->assign('titulo', 'Fazer Pergunta');
  $smarty->display('pergunta/submit.tpl');
?>