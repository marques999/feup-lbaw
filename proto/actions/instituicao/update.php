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

  if (safe_strcheck($_POST, 'idInstituicao')) {
    $oldSigla = safe_trimAll($_POST, 'idInstituicao');
  }
  else {
    safe_formerror('Deve especificar uma instituição primeiro!');
  }

  $numberColumns = 0;

  if (safe_strcheck($_POST, 'nome')) {
    $nome = safe_trimAll($_POST, 'nome');
    $numberColumns++;
  }
  else {
    $nome = null;
  }

  if (safe_strcheck($_POST, 'sigla')) {
    $sigla = safe_trimAll($_POST, 'sigla');
    $numberColumns++;
  }
  else {
    $sigla = null;
  }

  if (safe_strcheck($_POST, 'morada')) {
    $morada = safe_trimAll($_POST, 'morada');
    $numberColumns++;
  }
  else {
    $morada = null;
  }

  if (safe_strcheck($_POST, 'contacto')) {
    $contacto = safe_trimAll($_POST, 'contacto');
    $numberColumns++;
  }
  else {
    $contacto = null;
  }

  if (safe_strcheck($_POST, 'website')) {
    $website = safe_trimAll($_POST, 'website');
    $numberColumns++;
  }
  else {
    $website = null;
  }

  if ($numberColumns < 1) {
    safe_formerror('Erro na operação: não foi enviada informação suficiente!');
  }

  try {

    if (instituicao_editarInstituicao($oldSigla, $nome, $sigla, $morada, $contacto, $website) <= 0) {
      safe_formerror('Erro desconhecido: tentou alterar uma instituição inexistente?');
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
      safe_formerror("Erro desconhecido: não foi possível escrever {$sigla}.{$fileExtension} no filesystem!");
    }

    imagedestroy($originalImage);
    imagedestroy($resizedImage);
  }
  else if ($sigla != null) {
    
    $targetDirectory = "{$BASE_DIR}images/instituicao/";
    $oldResizedUrl = glob("{$targetDirectory}{$oldSigla}.{jpg,jpeg,gif,png}", GLOB_BRACE);
    $oldOriginalUrl = glob("{$targetDirectory}{$oldSigla}_original.{jpg,jpeg,gif,png}", GLOB_BRACE);
    
    if ($oldResizedUrl !== false && $oldOriginalUrl !== false) {
      
      $oldResizedUrl = $oldResizedUrl[0];
      $oldOriginalUrl = $oldOriginalUrl[0];
      $fileExtension = pathinfo($oldResizedUrl, PATHINFO_EXTENSION);
      $newResizedUrl = "{$targetDirectory}{$sigla}.{$fileExtension}";
      $newOriginalUrl = "{$targetDirectory}{$sigla}_original.{$fileExtension}";

      if ($oldResizedUrl !== $newResizedUrl) {
        rename($oldResizedUrl, $newResizedUrl);
      }

      if ($oldOriginalUrl !== $newOriginalUrl) {
        rename($oldOriginalUrl, $newOriginalUrl);
      }
    }
  }

  safe_redirect("instituicao/view.php?=$sigla");
?>