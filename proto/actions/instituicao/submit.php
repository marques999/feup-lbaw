<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../lib/ImageUpload.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_login();
  }

  if (!safe_checkAdministrador()) {
    safe_redirect('403.php');
  }

  if (safe_strcheck($_POST, 'nome')) {
    $nome = safe_trimAll($_POST, 'nome');
  }
  else {
    safe_formerror('O nome da instituição não pode estar em branco!');
  }

  if (safe_strcheck($_POST, 'sigla')) {
    $sigla = safe_trimAll($_POST, 'sigla');
  }
  else {
    safe_formerror('A sigla da instituição não pode estar em branco!');
  }

  if (safe_strcheck($_POST, 'morada')) {
    $morada = safe_trimAll($_POST, 'morada');
  }
  else {
    $morada = null;
  }

  if (safe_strcheck($_POST, 'contacto')) {
    $contacto = safe_trimAll($_POST, 'contacto');
  }
  else {
    $contacto = null;
  }

  if (safe_strcheck($_POST, 'website')) {
    $website = safe_trimAll($_POST, 'website');
  }
  else {
    $website = null;
  }

  try {

    if (!instituicao_adicionarInstituicao($nome, $sigla, $morada, $contacto, $website) > 0) {
      safe_formerror('Erro desconhecido: tentou adicionar uma instituição que já existe?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }

  if (image_validateFormat()) {

    $baseFilename = basename($_FILES['avatar']['name']);
    $targetDirectory = "{$BASE_DIR}images/instituicao/";
    $targetFile = "{$targetDirectory}{$baseFilename}";
    $temporaryPath = $_FILES['avatar']['tmp_name'];
    $fileExtension = pathinfo($targetFile, PATHINFO_EXTENSION);
    $resizedUrl = "{$targetDirectory}{$sigla}.{$fileExtension}";
    $originalUrl = "{$targetDirectory}{$sigla}_original.{$fileExtension}";

    array_map('unlink', glob("{$targetDirectory}{$sigla}.{jpg,jpeg,gif,png}", GLOB_BRACE));
    array_map('unlink', glob("{$targetDirectory}{$sigla}_original.{jpg,jpeg,gif,png}", GLOB_BRACE));

    if (!move_uploaded_file($temporaryPath, $originalUrl)) {
      safe_formerror("Erro desconhecido: não foi possível escrever {$sigla}_original.{$fileExtension} no filesystem!");
    }

    $originalImage = image_readFile($originalUrl, $fileExtension);

    if ($originalImage == null) {
      safe_formerror('Deve especificar um formato de imagem válido!');
    }

    $resizedImage = image_advancedcrop($originalImage, 550, 330);

    if (!image_writeFile($resizedImage, $resizedUrl, $fileExtension)) {
      safe_formerror("Erro desconhecido: não foi possível escrever {$fileExtension}.jpg no filesystem!");
    }

    imagedestroy($originalImage);
    imagedestroy($resizedImage);
  }

  safe_redirect("instituicao/view.php?=$sigla");
?>