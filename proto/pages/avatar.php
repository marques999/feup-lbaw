<?
  include_once('../config/init.php');

  if (safe_strcheck($_GET, 'thumbnail')) {
    $smallImage = safe_trimAll($_GET, 'thumbnail') === 'yes';
  }
  else {
    $smallImage = false;
  }

  if (safe_check($_GET, 'id')) {

    $idUtilizador = safe_getId($_GET, 'id');

    if ($smallImage) {
      $avatarLocation = glob($BASE_DIR . "images/avatars/{$idUtilizador}_small.{jpg,jpeg,gif,png}", GLOB_BRACE);
    }
    else {
      $avatarLocation = glob($BASE_DIR . "images/avatars/{$idUtilizador}.{jpg,jpeg,gif,png}", GLOB_BRACE);
    }

    if ($avatarLocation === false) {

      if ($smallImage) {
        $avatarLocation = $BASE_DIR . 'images/avatars/default_small.png';
      }
      else {
        $avatarLocation = $BASE_DIR . 'images/avatars/default.png';
      }
    }
    else {
      $avatarLocation = $avatarLocation[0];
    }
  }
  else {

    if ($smallImage) {
      $avatarLocation = $BASE_DIR . 'images/avatars/default_small.png';
    }
    else {
      $avatarLocation = $BASE_DIR . 'images/avatars/default.png';
    }
  }

  $imageInformation = getimagesize($avatarLocation);

  switch ($imageInformation[2]) {
  case IMAGETYPE_JPEG:
    header("Content-Type: image/jpg");
    break;
  case IMAGETYPE_GIF:
    header("Content-Type: image/gif");
    break;
  case IMAGETYPE_PNG:
    header("Content-Type: image/png");
    break;
  }

  header('Content-Length: ' . filesize($avatarLocation));
  readfile($avatarLocation);
?>