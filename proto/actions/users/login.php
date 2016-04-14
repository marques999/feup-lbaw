<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_POST, 'username') && safe_check($_SESSION, 'password')) {
    $_SESSION['error_messages'][] = 'invalid login';
    $_SESSION['form_values'] = $_POST;
  }
  else {
    
    $myUsername = safe_trim($_POST['username']);
    $myPassword = safe_trim($_POST['password']);
  
    if (utilizador_validateLogin($myUsername, $myPassword)) {
      $_SESSION['username'] = $myUsername;
      $_SESSION['idUtilizador'] = utilizador_getId($myUsername);
      $_SESSION['success_messages'][] = 'Login successful';  
    }
    else {
      $_SESSION['error_messages'][] = 'login failed';  
    }
  }

  safe_redirect(null);
?>