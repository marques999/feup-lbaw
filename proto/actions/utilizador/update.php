<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idAdministrador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_POST, 'idUtilizador')) {
    $idUtilizador = safe_getId($_POST, 'idUtilizador');
  }
  else {
    safe_formerror('Deve especificar um utilizador primeiro!');
  }

  $isAdministrator = utilizador_isAdministrator($idUtilizador);

  if (($idUtilizador != $idAdministrador) && !$isAdministrator) {
    safe_redirect('403.php');
  }

  $numberColumns = 0;

  if (safe_strcheck($_POST, 'email')) {
    $email = safe_trim($_POST, 'email');
    $numberColumns++;
  }
  else {
    $email = null;
  }

  if (safe_strcheck($_POST, 'primeiro-nome')) {
    $primeiroNome = safe_trim($_POST, 'primeiro-nome');
    $numberColumns++;
  }
  else {
    $primeiroNome = null;
  }

  if (safe_strcheck($_POST, 'ultimo-nome')) {
    $ultimoNome = safe_trim($_POST, 'ultimo-nome');
    $numberColumns++;
  }
  else {
    $ultimoNome = null;
  }

  if (safe_check($_POST, 'instituicao')) {
    $idInstituicao = safe_getId($_POST, 'instituicao');
    $numberColumns++;
  }
  else {
    $idInstituicao = null;
  }

  if (safe_strcheck($_POST, 'localidade')) {
    $localidade = safe_trim($_POST, 'localidade');
    $numberColumns++;
  }
  else {
    $localidade = null;
  }

  if (safe_strcheck($_POST, 'codigo-pais')) {
    $codigoPais = safe_trim($_POST, 'codigo-pais');
    $numberColumns++;
  }
  else {
    $codigoPais = null;
  }

  if ($numberColumns < 1) {
    safe_formerror('Erro na operação: não foi enviada informação suficiente!');
  }

  try {

    if (utilizador_editarUtilizador($idUtilizador, $primeiroNome, $ultimoNome, $email, $idInstituicao, $localidade, $codigoPais) > 0) {

      if ($isAdministrator) {
        safe_redirect('admin/utilizadores.php');
      }
      else {
        safe_redirect("utilizador/profile.php?id=$idUtilizador");
      }
    }
    else {
      safe_formerror('Erro desconhecido: utilizador inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>