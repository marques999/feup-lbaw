<?
  include_once('../../config/init.php');
  include_once('../../lib/imgupload.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_error('Deve estar autenticado para aceder a esta página!', 'utilizador/login.php');
  }
  
  if (!safe_check($_POST, 'avatar')) {
    safe_formerror('Deve especificar uma imagem diferente da atual!');
  }

  if (!image_validateUpload()) {
    safe_formerror('Deve especificar um formato de imagem válido!');
  }

  $baseFilename = basename($_FILES['avatar']['name']);
  $targetDirectory = "{$BASE_DIR}images/avatars/";
  $targetFile = "{$targetDirectory}{$baseFilename}";
  $temporaryPath = $_FILES['avatar']['tmp_name'];
  $fileExtension = pathinfo($targetFile, PATHINFO_EXTENSION);
  $originalUrl = "{$targetDirectory}{$idUtilizador}_original.{$fileExtension}";
  $smallUrl = "{$targetDirectory}{$idUtilizador}_small.{$fileExtension}";
  $mediumUrl ="{$targetDirectory}{$idUtilizador}.{$fileExtension}";

  array_map('unlink', glob("{$targetDirectory}{$idUtilizador}.{jpg,jpeg,gif,png}", GLOB_BRACE));
  array_map('unlink', glob("{$targetDirectory}{$idUtilizador}_original.{jpg,jpeg,gif,png}", GLOB_BRACE));
  array_map('unlink', glob("{$targetDirectory}{$idUtilizador}_small.{jpg,jpeg,gif,png}", GLOB_BRACE));

  if (!move_uploaded_file($temporaryPath, $originalUrl)) {
    safe_formerror("Erro desconhecido: não foi possível escrever {$idUtilizador}_original.{$fileExtension} no filesystem!");
  }

  $originalImage = image_readFile($originalUrl, $fileExtension);

  if ($originalImage == null) {
    safe_formerror('Deve especificar um formato de imagem válido!');
  }

  $mediumImage = image_resize($originalImage, 500, $fileExtension);
  $smallImage = image_crop($mediumImage, 64, 64);

  if (!image_writeFile($mediumImage, $mediumUrl, $fileExtension)) {
    safe_formerror("Erro desconhecido: não foi possível escrever {$idUtilizador}.{$fileExtension} no filesystem!");
  }

  if (!image_writeFile($smallImage, $smallUrl, $fileExtension)) {
    safe_formerror("Erro desconhecido: não foi possível escrever {$idUtilizador}_small.{$fileExtension} no filesystem!");
  }

  imagedestroy($originalImage);
  imagedestroy($mediumImage);
  imagedestroy($smallImage);

  safe_redirect(null);
?>