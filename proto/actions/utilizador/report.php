<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idModerador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (!utilizador_isModerator($idModerador)) {
    safe_redirect('403.php');
  }

  if (safe_check($_POST, 'idUtilizador')) {
    $idUtilizador = safe_getId($_POST, 'idUtilizador')
  }
  else {
    safe_formerror('Deve especificar um utilizador primeiro!');
  }

  if (safe_strcheck($_POST, 'descricao')) {
    $descricao = safe_trim($_POST, 'idUtilizador')
  }
  else {
    safe_formerror('O corpo da mensagem não pode estar em branco!');
  }

  try {

    if (utilizador_denunciarUtilizador($idModerador, $idUtilizador, $descricao) > 0) {
      safe_redirect("utilizador/profile.php?id=$idUtilizador");
    }
    else {
      safe_formerror('Erro desconhecido: tentou denunciar um utilizador inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>