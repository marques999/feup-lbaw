<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!utilizador_isAdministrator(safe_getId($_SESSION, 'idUtilizador'))) {
    safe_redirect('403.php');
  }

  if (!safe_check($_POST, 'idInstituicao')) {
    safe_error(null, 'Deve especificar uma instituição primeiro!');
  }

  $idInstituicao = safe_getId($_GET, 'id');
  $nome = safe_trim($_POST, 'nome');
  $sigla = safe_trim($_POST, 'sigla');
  $morada = safe_trim($_POST, 'morada');
  $contacto = safe_trim($_POST, 'contacto');
  $website = safe_trim($_POST, 'website');

  if (empty($nome) && empty($sigla) && empty($morada) && empty($contacto) && empty($website)) {
    safe_error(null, 'Operação sem efeito, nenhum campo foi alterado...');
  }

  try {

    if (instituicao_editarInstituicao($idInstituicao, $nome, $sigla, $morada, $contacto, $website) > 0) {
      safe_redirect("instituicao/view.php?=$safeSigla");
    }
    else {
      safe_error(null, 'Erro desconhecido, tentou alterar uma instituição inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>