<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/instituicao.php');
  echo instituicao_getStats($_GET['filter']);
?>