<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');
  include_once('../../lib/ImageUpload.php');
  include_once('../../lib/PhpSalt.php');
  
  if (safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/homepage.php', 'Já se encontra com sessão iniciada, não pode registar-se!');
  }

  if (safe_strcheck($_POST, 'username')) {
    $username = safe_trimAll($_POST, 'username');
  }
  else {
    safe_formerror('Deve especificar um username obrigatório!');
  }

  if (safe_strcheck($_POST, 'password')) {
    $password = safe_trimAll($_POST, 'password');
  }
  else {
    safe_formerror('Deve especificar uma palavra-passe obrigatória!');
  }

  if (safe_strcheck($_POST, 'email')) {
    $email = safe_trimAll($_POST, 'email');
  }
  else {
    safe_formerror('Deve especificar um endereço de e-mail obrigatório!');
  }

  if (safe_strcheck($_POST, 'primeiro-nome') && safe_strcheck($_POST, 'ultimo-nome')) {
    $primeiroNome = safe_trimAll($_POST, 'primeiro-nome');
    $ultimoNome = safe_trimAll($_POST, 'ultimo-name');
  }
  else {
    safe_formerror('Deve especificar um nome completo obrigatório!');
  }

  try {

    if (utilizador_inserirUtilizador($username, $password, $email, $primeiroNome, $ultimoNome) < 1) {
      safe_formerror('Erro desconhecido: um utilizador com este username ou e-mail já existe?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }

  if (image_validateUpload()) {

    $baseFilename = basename($_FILES['image']['name']);
    $targetDirectory = "{$BASE_DIR}images/avatars/";
    $targetFile = "{$targetDirectory}{$baseFilename}";
    $temporaryPath = $_FILES['image']['tmp_name'];
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
  }

  $numberColumns = 0;

  if (safe_check($_POST, 'instituicao')) {
    $idInstituicao = safe_getId($_POST, 'instituicao');
    $numberColumns++;
  }
  else {
    $idInstituicao = null;
  }

  if (safe_strcheck($_POST, 'localidade')) {
    $localidade = safe_trimAll($_POST, 'localidade');
    $numberColumns++;
  }
  else {
    $localidade = null;
  }

  if (safe_strcheck($_POST, 'codigo-pais')) {
    $codigoPais = safe_trimAll($_POST, 'codigo-pais');
    $numberColumns++;
  }
  else {
    $codigoPais = null;
  }

  if ($numberColumns < 1) {
    safe_formerror('Erro na operação: não foi enviada informação suficiente!');
  }

  try {

    if (utilizador_editarUtilizador($idUtilizador, null, null, null, $idInstituicao, $localidade, $codigoPais) > 0) {
      safe_redirect('utilizador/login.php');
    }
    else {
      safe_formerror('Erro desconhecido: tentou alterar as informações de um utilizador inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>