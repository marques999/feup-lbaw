<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');
  $smarty->assign('location', $_SERVER['HTTP_REFERER']);
  $smarty->assign('titulo', 'Iniciar Sessão');
  $smarty->display('utilizador/login.tpl');
?>