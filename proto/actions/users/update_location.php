<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/utilizador.php');

  $returnValue = 0;

  if (safe_check($_POST, 'localidade') && safe_check($_POST, 'codigoPais')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $safeLocation = safe_trim($_POST, 'localidade');
    $safeCountry = safe_trim($_POST, 'codigoPais');
    $stmt = $db->prepare('UPDATE Users
      SET location = :location, country = :country
      WHERE idUser = :idUser');
    $stmt->bindParam(':location', $safeLocation, PDO::PARAM_STR);
    $stmt->bindParam(':country', $safeCountry, PDO::PARAM_STR);
    $stmt->bindParam(':idUtilizador', $idUtilizador, PDO::PARAM_INT);
    $stmt->execute();
    $returnValue = $stmt->rowCount();
  }

  safe_redirect(null);
?>