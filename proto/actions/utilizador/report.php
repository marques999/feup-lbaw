<?
  include_once('../../config/init.php');
  include_once('../../database/utilizador.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  $idModerador = safe_getId($_SESSION, 'idUtilizador');

  if (!utilizador_isModerator($idModerador)) {
    safe_redirect('403.php');
  }

  if (!safe_check($_POST, 'idUtilizador')) {
    safe_error(null, 'Deve especificar um utilizador primeiro!');
  }

  if (!safe_strcheck($_POST, 'descricao')) {
    safe_error(null, 'O corpo da mensagem não pode estar em branco!');
  }

  try {

    $idUtilizador = safe_getId($_POST, 'idUtilizador')
    $descricao = safe_trim($_POST, 'idUtilizador')

    if (utilizador_denunciarUtilizador($idModerador, $idUtilizador, $descricao) > 0) {
      safe_redirect("utilizador/profile.php?id=$idUtilizador");
    }
    else {
      safe_error(null, 'Erro na operação, tentou denunciar um utilizador inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>