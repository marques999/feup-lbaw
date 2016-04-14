<?
  include_once('../../config/init.php');
  include_once('../../lib/salt.php');
  include_once('.:/../database/users.php');  

  if (!$_POST['username'] || !$_POST['password']) {
    $_SESSION['error_messages'][] = 'Invalid login';
    $_SESSION['form_values'] = $_POST;
    header('Location: ' . $_SERVER['HTTP_REFERER']);
    exit;
  }

  $username = $_POST['username'];
  $password = $_POST['password'];
  $sessionId = validateLogin($username, $password);

  if ($sessionId > 0) {
    $_SESSION['username'] = $username;
    $_SESSION['userid'] = $sessionId;
    $_SESSION['success_messages'][] = 'Login successful';  
  } else {
    $_SESSION['error_messages'][] = 'Login failed';  
  }

  header('Location: ' . $_SERVER['HTTP_REFERER']);
?>