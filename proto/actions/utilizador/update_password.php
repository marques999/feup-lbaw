<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/utilizador.php');

  $returnValue = 0;
  $oldPassword = $currentUser['password'];

  if (isset($_POST['current-password']) && isset($_POST['next-password']) && isset($_POST['confirm-password'])) {

    $currentPassword = safe_trim($_POST['current-password']);
    $confirmPassword = safe_trim($_POST['confirm-password']);
    $safePassword = safe_trim($_POST['next-password']);

    if (!validate_password($currentPassword, $oldPassword)){
      header("Location: ../update_profile.php?field=$changedField&error=1");
    }
    else if (validate_password($safePassword, $oldPassword)){
      header("Location: ../update_profile.php?field=$changedField&error=3");
    }
    else if ($safePassword != $confirmPassword) {
      header("Location: ../update_profile.php?field=$changedField&error=2");
    }
    else {
      $validOperation = true;
      $newPassword = create_hash($safePassword);
      $stmt = $db->prepare('UPDATE Users SET password = :password WHERE idUser = :idUser');
      $stmt->bindParam(':password', $newPassword, PDO::PARAM_STR);
    }
  }

  safe_redirect(null);
?>