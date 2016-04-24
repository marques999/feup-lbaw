<?
  include_once('../../config/init.php');
  include_once('../../config/salt.php');
  include_once('../../config/security.php');
  include_once('../../database/utilizador.php');

  $userExists = users_usernameExists($_POST['username']);

  if ($userExists) {
    header("Location: ../message_register.php?id=1");
  }

  $emailExists = users_emailExists($_POST['email']);

  if ($emailExists) {
    header("Location: ../message_register.php?id=2");
  }

  if (safe_check($_POST, 'username')) {
    $_username = safe_trim($_POST['username']);
  }
  else {
    safe_error("../register.php", 'Deve preencher um username no formulário de registo!');
  }

  if (safe_check($_POST, 'password')) {
    $_password = create_hash($_POST['password']);
  }
  else {
    safe_error("../register.php", 'Deve preencher uma password no formulário de registo!');
  }

  if (safe_check($_POST, 'first-name') && safe_check($_POST, 'last-name')) {
    $_primeiroNome = safe_trim($_POST['first-name']);
    $_ultimoNome = safe_trim($_POST['last-name']);
  }
  else {
    safe_redirect("../register.php");
  }

  if (safe_check($_POST, 'email')) {
    $_email = safe_trim($_POST['email']);
  }
  else {
    safe_error("../register.php", 'Deve preencher um endereço de e-mail no formulário!');
  }

  $stmt = $db->prepare('INSERT INTO Utilizador(idUtilizador, username, password, primeiroNome, ultimoNome)
    VALUES(DEFAULT, :username, :password, :email, :primeiroNome, :ultimoNome)');
  $stmt->bindParam(':username', $_username, PDO::PARAM_STR);
  $stmt->bindParam(':password', $_password, PDO::PARAM_STR);
  $stmt->bindParam(':email', $_email, PDO::PARAM_STR);
  $stmt->bindParam(':primeiroNome', $_primeiroNome, PDO::PARAM_STR);
  $stmt->bindParam(':ultimoNome', $_ultimoNome, PDO::PARAM_STR);

  try {
    $stmt->execute();
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }

  if (users_imageUploaded()) {

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
  }

  $hasInstituicao = safe_check($_POST, 'instituicao');
  $queryString = 'UPDATE Utilizador SET ';
  $numberColumns = 0;

  if ($hasInstituicao) {
    $queryString .= 'idInstituicao = :idInstituicao';
    $numberColumns++;
  }

  $hasLocalidade = safe_check($_POST, 'localidade');

  if ($hasLocalidade) {

    if ($numberColumns > 0) {
      $queryString .= ', ';
    }

    $queryString .= 'localidade = :localidade');
    $numberColumns++;
  }

  $hasCodigoPais = safe_check($_POST, 'pais');

  if ($hasCodigoPais) {

    if ($numberColumns > 0) {
      $queryString .= ', ';
    }

    $queryString .= 'codigoPais = :codigoPais';
    $numberColumns++;
  }

  if ($numberColumns > 0) {

    if ($hasInstituicao) {
      $_instituicao = safe_getId($_POST, 'idInstituicao');
      $stmt->bindParam(':idInstituicao', $_instituicao, PDO::PARAM_INT);
    }

    if ($hasLocalidade) {
      $_localidade = safe_trim($_POST['localidade']);
      $stmt->bindParam(':localidade', $_localidade, PDO::PARAM_STR);
    }

    if ($hasCodigoPais) {
      $_codigoPais = safe_trim($_POST['codigoPais']);
      $stmt->bindParam(':codigoPais', $_codigoPais, PDO::PARAM_STR);
    }

    try {
      $stmt->execute();
    }
    catch (PDOException $e) {
      safe_error(null, $e->getMessage());
    }

    if ($stmt->rowCount() > 0) {
      safe_redirect('utilizador/login.php');
    }
  }
?>