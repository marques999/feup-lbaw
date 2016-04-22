<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/categoria.php');
  echo categoria_getStats($_GET['filter']);
?>