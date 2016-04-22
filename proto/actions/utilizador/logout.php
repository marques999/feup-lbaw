<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (isset($_SESSION['username'])) {
    unset($_SESSION['username']);
  }

  if (isset($_SESSION['idUtilizador'])) {
    unset($_SESSION['idUtilizador']);
  }

  session_destroy();
  safe_redirect(null);
?>