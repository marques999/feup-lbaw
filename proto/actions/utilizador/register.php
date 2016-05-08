<?
  include_once('../../config/init.php');
  include_once('../../config/salt.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/homepage.php', 'Já se encontra com sessão iniciada, não pode registar-se!');
  }

  if (safe_check($_POST, 'username')) {
     $myUsername = safe_trim($_POST, 'username');
  }
  else {
    safe_error(null, 'Deve especificar um username primeiro!');
  }

  if (safe_check($_POST, 'password')) {
     $myPassword = safe_trim($_POST, 'password');
  }
  else {
    safe_error(null, 'Deve especificar uma palavra-passe primeiro!');
  }

  if (safe_strcheck($_POST, 'email')) {
    $myEmail = safe_trim($_POST, 'email');
  }
  else {
    safe_error(null, 'Deve especificar um endereço de e-mail obrigatório!');
  }

  if (safe_strcheck($_POST, 'primeiro-nome') && safe_strcheck($_POST, 'ultimo-nome')) {
    $myFirstName = safe_trim($_POST, 'primeiro-nome');
    $myLastName = safe_trim($_POST, 'ultimo-name');
  }
  else {
    safe_error(null, 'Deve especificar um nome completo obrigatório!');
  }

  try {

    if (utilizador_inserirUtilizador($myUsername, $myPassword, $myEmail, $myFirstName, $myLastName) < 1) {
      safe_error(null, 'Erro na operação: um utilizador com este username ou e-mail já existe?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }

  /*if (users_imageUploaded()) {

    $uploadDirectory = '{$BASE_URL}images/avatars/';
    $baseFilename = basename($_FILES['image']['name']);
    $fileExtension = strtolower(substr($baseFilename, strrpos($baseFilename, '.') + 1));
    $outputFilename = "{$thisUser}_original.{$fileExtension}";
    $uploadFile = $uploadDirectory . $outputFilename;
    $smallFile = "../img/avatars/{$thisUser}_small.{$fileExtension}";
    $mediumFile = "../img/avatars/{$thisUser}.{$fileExtension}";

    if (!move_uploaded_file($_FILES['image']['tmp_name'], $uploadFile)){
      header("Location: message_photo.php");
    }

    $originalImage = image_readFile($uploadFile, $fileExtension);

    if ($originalImage == null) {
      header("Location: ../message_photo.php");
    }

    $resizedImage = image_resize($originalImage, 400, $fileExtension);
    $thumbnailImage = image_crop($resizedImage, 64, 64);
    image_writeFile($resizedImage, $mediumFile, $fileExtension);
    image_writeFile($thumbnailImage, $smallFile, $fileExtension);
    imagedestroy($originalImage);
    imagedestroy($resizedImage);
    imagedestroy($thumbnailImage);
  }*/

  $numberColumns = 0;

  if (safe_check($_POST, 'instituicao')) {
    $myInstituicao = safe_getId($_POST, 'instituicao');
    $numberColumns++;
  }
  else {
    $myInstituicao = null;
  }

  if (safe_strcheck($_POST, 'localidade')) {
    $myLocalidade = safe_trim($_POST, 'localidade');
    $numberColumns++;
  }
  else {
    $myLocalidade = null;
  }

  if (safe_strcheck($_POST, 'codigo-pais')) {
    $myCodigoPais = safe_trim($_POST, 'codigo-pais');
    $numberColumns++;
  }
  else {
    $myCodigoPais = null;
  }

  if ($numberColumns > 0) {

    try {

      if (utilizador_editarUtilizador($idUtilizador, null, null, null, $idInstituicao, $myLocalidade, $myCodigoPais) > 0) {
        safe_redirect('utilizador/login.php');
      }
      else {
        safe_error(null, 'Erro na operação: tentou alterar as informações de outro utilizador?');
      }
    }
    catch (PDOException $e) {
      safe_error(null, $e->getMessage());
    }
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>