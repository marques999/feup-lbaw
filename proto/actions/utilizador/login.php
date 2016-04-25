<?
  include_once('../../config/init.php');
  include_once('../../config/salt.php');
  include_once('../../config/security.php');

  if (safe_strcheck($_POST, 'username') && safe_strcheck($_POST, 'password')) {

    $myUsername = safe_trim($_POST, 'username');
    $myPassword = safe_trim($_POST, 'password');
    $idUtilizador = utilizador_validateLogin($myUsername, $myPassword);

    if ($idUtilizador > 0) {
      $_SESSION['username'] = $myUsername;
      $_SESSION['idUtilizador'] = $idUtilizador;
      safe_redirect('homepage.php');
    }
    else {
      safe_error(null, 'ERRO: não existe um utilizador com esta combinação na base de dados!');
    }
  }
  else {
    $_SESSION['error_messages'][] = 'Invalid login!';
    $_SESSION['form_values'] = $_POST;
  }
?>