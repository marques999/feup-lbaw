<?
  include_once('../../config/init.php');
  include_once('../../config/salt.php');
  include_once('../../config/security.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_POST, 'username') && safe_check($_SESSION, 'password')) {
    $_SESSION['error_messages'][] = 'Invalid login!';
    $_SESSION['form_values'] = $_POST;
  }
  else {

    $myUsername = safe_trim($_POST['username']);
    $myPassword = safe_trim($_POST['password']);
    $idUtilizador = utilizador_validateLogin($myUsername, $myPassword);

    if ($idUtilizador > 0) {
      $_SESSION['username'] = $myUsername;
      $_SESSION['idUtilizador'] = $idUtilizador;
      safe_redirect('pages/homepage.php');
    }
    else {
      safe_error(null, 'ERRO: não existe um utilizador com esta combinação na base de dados!');
    }
  }
?>