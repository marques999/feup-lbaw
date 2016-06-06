<?
  include_once('../../config/init.php');

  if (isset($_SESSION['username'])) {
    unset($_SESSION['username']);
  }

  if (isset($_SESSION['permissions'])) {
  	unset($_SESSION['permissions']);
  }

  if (isset($_SESSION['idUtilizador'])) {
    unset($_SESSION['idUtilizador']);
  }

  session_destroy();
  safe_redirect(null);
?>