<?
  include_once('../../config/init.php');
  
  if (isset($_SESSION['username'])) {
    unset($_SESSION['username']);
  }

  if (isset($_SESSION['userid'])) {
    unset($_SESSION['userid']);
  }

  session_destroy();
  header('Location: ' . $BASE_URL);
?>