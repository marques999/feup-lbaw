<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

  if ($_SESSION['idUtilizador']) {
    $smarty->display('pergunta/ask.tpl');
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>