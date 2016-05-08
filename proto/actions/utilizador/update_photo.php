<?
  include_once('../../config/init.php');
  include_once('../../config/imgupload.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_POST, 'idUtilizador') && users_fileUploaded()) {

    $uploadDirectory = $BASE_DIR . 'img/avatars/';
    $baseFilename = basename($_FILES['image']['name']);
    $fileExtension = strtolower(substr($baseFilename, strrpos($baseFilename, '.') + 1));
    $outputFilename = "{$userId}_original.{$fileExtension}";
    $uploadFile = $uploadDirectory . $outputFilename;
    $smallFile = $BASE_DIR . "img/avatars/{$userId}_small.{$fileExtension}";
    $mediumFile = $BASE_DIR . "img/avatars/{$userId}.{$fileExtension}";
    array_map('unlink', glob($BASE_DIR . "img/avatars/{$userId}_original.{jpg,jpeg,gif,png}", GLOB_BRACE));

    if (!move_uploaded_file($_FILES['image']['tmp_name'], $uploadFile)){
      header("Location: message_photo.php");
    }

    $originalImage = image_readFile($uploadFile, $fileExtension);

    if ($originalImage == null) {
      header("Location: ../message_photo.php");
    }

    $resizedImage = image_resize($originalImage, 500, $fileExtension);
    $thumbnailImage = image_crop($resizedImage, 64, 64);
    array_map('unlink', glob("../img/avatars/{$userId}.{jpg,jpeg,gif,png}", GLOB_BRACE));
    array_map('unlink', glob("../img/avatars/{$userId}_small.{jpg,jpeg,gif,png}", GLOB_BRACE));
    image_writeFile($resizedImage, $mediumFile, $fileExtension);
    image_writeFile($thumbnailImage, $smallFile, $fileExtension);
    imagedestroy($originalImage);
    imagedestroy($resizedImage);
    imagedestroy($thumbnailImage);
  }

  safe_redirect(null);
?>