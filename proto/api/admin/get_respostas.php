<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/pergunta.php');
  echo resposta_getStats($_GET['filter']);
?>