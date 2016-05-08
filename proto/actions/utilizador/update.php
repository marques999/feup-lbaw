<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!safe_check($_POST, 'utilizador-id')) {
    safe_error(null, 'Deve especificar um utilizador primeiro!');
  }

  $idUtilizador = safe_getId($_POST, 'utilizador-id');
  $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
  $isAdministrator = utilizador_isAdministrator($idUtilizador);
  $isOwner = ($idUtilizador == $idAdministrador);

  if (!$isOwner && !$isAdministrator) {
    safe_redirect('403.php');
  }

  $numberColumns = 0;

  if (safe_strcheck($_POST, 'email')) {
    $myEmail = safe_trim($_POST, 'email');
    $numberColumns++;
  }
  else {
    $myEmail = null;
  }

  if (safe_strcheck($_POST, 'primeiro-nome')) {
    $myFirstName = safe_trim($_POST, 'primeiro-nome');
    $numberColumns++;
  }
  else {
    $myFirstName = null;
  }

  if (safe_strcheck($_POST, 'ultimo-nome')) {
    $myLastName = safe_trim($_POST, 'ultimo-nome');
    $numberColumns++;
  }
  else {
    $myLastName = null;
  }

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

  if ($numberColumns < 1) {
    safe_error(null, 'Operação sem efeito, nenhum campo foi alterado...');
  }

  try {

    if (utilizador_editarUtilizador($idUtilizador, $myFirstName, $myLastName, $myEmail, $myInstituicao, $myLocalidade, $myCodigoPais) > 0) {

      if ($isAdministrator) {
        safe_redirect('admin/utilizadores.php');
      }
      else {
        safe_redirect("utilizador/profile.php?id=$idUtilizador");
      }
    }
    else {
      safe_error('utilizador/edit.php', 'Erro na operação, utilizador inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error('utilizador/edit.php', $e->getMessage());
  }
?>