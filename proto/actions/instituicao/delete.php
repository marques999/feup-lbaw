<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_login();
  }

  if (!safe_checkAdministrador()) {
    safe_redirect('403.php');
  }

  if (safe_check($_POST, 'idInstituicao')) {
    $idInstituicao = safe_trimAll($_POST, 'idInstituicao');
  }
  else {
    safe_error('Deve especificar uma instituição primeiro!');
  }

  try {

    if (instituicao_apagarInstituicao($idInstituicao) > 0) {
      safe_redirect('admin/instituicoes.php');
    }
    else {
      safe_error('Erro desconhecido: tentou apagar uma instituição inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error($e->getMessage());
  }
?>