<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');
  include_once('../../lib/PhpSalt.php');
  
  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_POST, 'current-password')) {
    $oldPassword = safe_trim($_POST, 'current-password');
  }
  else {
    safe_formerror('Deve especificar a sua palavra-passe antiga!');
  }

  if (safe_strcheck($_POST, 'new-password')) {
    $newPassword = safe_trim($_POST, 'new-password');
  }
  else {
    safe_formerror('Deve especificar uma nova palavra-passe!');
  }

  if (safe_strcheck($_POST, 'confirm-password')) {
    $confirmPassword = safe_trim($_POST, 'confirm-password');
  }
  else {
    safe_formerror('Deve confirmar a sua nova palavra-passe!');
  }

  if ($newPassword != $confirmPassword) {
    safe_formerror('Erro na operação: as palavra-passes introduzidas não correspondem!');
  }

  if (!utilizador_validateId($idUtilizador, $oldPassword)) {
    safe_formerror('Erro na operação: a palavra-passe antiga não corresponde à introduzida!');
  }

  if (utilizador_validateId($idUtilizador, $newPassword)) {
    safe_formerror('Erro na operação: introduza uma palavra-passe diferente da actual!');
  }

  try {

    if (utilizador_alterarPassword($idUtilizador, $newPassword) > 0) {
      safe_redirect("utilizador/profile.php?id=$idUtilizador");
    }
    else {
      safe_formerror('Erro na operação: tentou alterar as informações de outro utilizador?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>