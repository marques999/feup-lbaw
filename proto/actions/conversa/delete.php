<?
  include_once('../../config/init.php');
  include_once('../../database/conversa.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_GET, 'id')) {
    $idConversa = safe_getId($_GET, 'id');
  }
  else {
    safe_error('Deve especificar uma conversa primeiro!');
  }

  if (!conversa_verificarAutor($idConversa, $idUtilizador)) {
    safe_redirect('403.php');
  }

  try {

    if (conversa_apagarConversa($idConversa, $idUtilizador) > 0) {
      safe_redirect("conversa/list.php");
    }
    else {
      safe_error('Erro desconhecido: tentou apagar uma conversa inexistente?');
    }
  }
  catch (PDOException $e) {
    safe_error($e->getMessage());
  }
?>