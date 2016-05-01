<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {
    safe_redirect('403.php');
  }

  $numberColumns = 0;

  if (safe_strcheck($_POST, 'nome')) {
    $myNome = safe_trim($_POST, 'nome');
    $numberColumns++;
  }
  else {
    safe_error(null, 'O nome da instituição não pode estar em branco!');
  }

  if (safe_strcheck($_POST, 'sigla')) {
    $mySigla = safe_trim($_POST, 'sigla');
    $numberColumns++;
  }
  else {
    safe_error(null, 'A sigla da instituição não pode estar em branco!');
  }

  if (safe_strcheck($_POST, 'morada')) {
    $myMorada = safe_trim($_POST, 'morada');
    $numberColumns++;
  }
  else {
    $myMorada = null;
  }

  if (safe_strcheck($_POST, 'contacto')) {
    $myContacto = safe_trim($_POST, 'contacto');
    $numberColumns++;
  }
  else {
    $myContacto = null;
  }

  if (safe_strcheck($_POST, 'website')) {
    $myWebsite = safe_trim($_POST, 'website');
    $numberColumns++;
  }
  else {
    $myWebsite = null;
  }

  if ($numberColumns < 1) {
    safe_error(null, 'Operação sem efeito, não foi enviada informação suficiente...');
  }

  try {

    if (instituicao_adicionarInstituicao($myNome, $mySigla, $myMorada, $myContacto, $myWebsite) > 0) {
      safe_redirect("instituicao/view.php?=$mySigla");
    }
    else {
      safe_error(null, 'Erro desconhecido: tentou adicionar uma instituição que já existe?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>