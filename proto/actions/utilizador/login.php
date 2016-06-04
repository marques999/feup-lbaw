<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');
  include_once('../../lib/PhpSalt.php');
  
  if (safe_strcheck($_POST, 'username')) {
    $username = safe_trim($_POST, 'username');
  }
  else {
    safe_formerror('Deve especificar um username primeiro!');
  }

  if (safe_strcheck($_POST, 'password')) {
    $password = safe_trim($_POST, 'password');
  }
  else {
    safe_formerror('Deve especificar uma palavra-passe primeiro!');
  }

  $idUtilizador = utilizador_validateLogin($username, $password);

  if ($idUtilizador > 0) {

    $_SESSION['username'] = $username;
    $_SESSION['idUtilizador'] = $idUtilizador;

    if (safe_strcheck($_POST, 'location')) {
      header('Location: ' . safe_trim($_POST, 'location'));
    }
    else {
      safe_redirect('homepage.php');
    }
  }
  else {
    safe_formerror('Erro na operação: não existe um utilizador com esta combinação na base de dados!');
  }
?>