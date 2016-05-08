<?
  include_once('../../config/init.php');
  include_once('../../config/salt.php');
  include_once('../../database/utilizador.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!safe_check($_POST, 'idUtilizador')) {
    safe_error(null, 'Deve especificar um utilizador primeiro!');
  }

  if (!safe_check($_POST, 'current-password') || !safe_check($_POST, 'confirm-password')) {
    safe_error(null, 'Deve especificar uma password primeiro!');
  }

  if (!safe_check($_POST, 'new-password')) {
    safe_error(null, 'Deve especificar uma password primeiro!');
  }

  $idUtilizador = safe_getId($_POST, 'idUtilizador');
  $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
  $isAdministrator = utilizador_isAdministrator($idUtilizador);
  $isOwner = $idUtilizador == $idAdministrador;

  if (!$isOwner && !$isAdministrator) {
    safe_redirect('403.php');
  }

  $oldPassword = safe_trim($_POST, 'current-password');
  $newPassword = safe_trim($_POST, 'new-password');
  $confirmPassword = safe_trim($_POST, 'confirm-password');

  if (!utilizador_validateId($idUtilizador, $oldPassword)) {
    safe_error(null, 'Erro na operação: a palavra-passe antiga não corresponde à actual!');
  }

  if (utilizador_validateId($idUtilizador, $newPassword)) {
    safe_error(null, 'Erro na operação: introduza uma palavra-passe diferente da actual!');
  }

  if ($newPassword != $confirmPassword) {
    safe_error(null, 'Erro na operação: as palavra-passes novas introduzidas não correspondem!');
  }

  try {

    if (utilizador_alterarPassword($idUtilizador, $newPassword) > 0) {
      safe_redirect("utilizador/profile.php?id=$idUtilizador");
    }
    else {
      safe_error(null, 'Erro na operação: tentou alterar as informaçoes de outro utilizador?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>