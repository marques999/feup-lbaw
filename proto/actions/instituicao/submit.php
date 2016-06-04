<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (!utilizador_isAdministrator($idUtilizador)) {
    safe_redirect('403.php');
  }

  $numberColumns = 0;

  if (safe_strcheck($_POST, 'nome')) {
    $nome = safe_trimAll($_POST, 'nome');
    $numberColumns++;
  }
  else {
    safe_formerror('O nome da instituição não pode estar em branco!');
  }

  if (safe_strcheck($_POST, 'sigla')) {
    $sigla = safe_trimAll($_POST, 'sigla');
    $numberColumns++;
  }
  else {
    safe_formerror('A sigla da instituição não pode estar em branco!');
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

    if (!instituicao_adicionarInstituicao($nome, $sigla, $morada, $contacto, $website) > 0) {
      safe_formerror('Erro desconhecido: tentou adicionar uma instituição que já existe?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }

  if (safe_check($_POST, 'image') && image_validateUpload()) {

    $baseFilename = basename($_FILES['image']['name']);
    $targetDirectory = "{$BASE_DIR}images/instituicao/";
    $targetFile = "{$targetDirectory}{$baseFilename}";
    $temporaryPath = $_FILES['image']['tmp_name'];
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

    $resizedImage = image_advancedcrop($originalImage, 64, 64);

    if (!image_writeFile($resizedImage, $resizedUrl, $fileExtension)) {
      safe_formerror("Erro desconhecido: não foi possível escrever {$sigla}.{$fileExtension} no filesystem!");
    }

    imagedestroy($originalImage);
    imagedestroy($resizedImage);
  }

  safe_redirect("instituicao/view.php?=$sigla");
?>