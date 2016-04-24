<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/conversa.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!safe_check($_GET, 'id')) {
    safe_error(null, 'Deve especificar uma conversa primeiro!');
  }

  try {

    $idConversa = safe_getId($_GET, 'id');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

    if (conversa_delete($idConversa, $idUtilizador) > 0) {
      safe_redirect("conversa/list.php");
    }
    else {
      safe_error(null, 'Erro na operação, tentou apagar uma conversa de outro utilizador?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>