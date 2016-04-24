<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');
  include_once('../../database/resposta.php');

  if (!safe_check($_SESSION, 'idUtilizador')) {
    safe_error('utilizador/login.php', 'Deve estar autenticado para aceder a esta página!');
  }

  if (!safe_check($_GET, 'id')) {
    safe_error(null, 'Deve especificar uma resposta primeiro!');
  }

  try {

    $idResposta = safe_getId($_GET, 'id');
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
    $isSuperuser = utilizador_isAdministrator($idUtilizador) || utilizador_isModerator($idUtilizador);

    if (resposta_apagarResposta($idResposta, $idUtilizador, $isSuperuser) > 0) {
      safe_redirect("pergunta/view.php?id=1");
    }
    else {
      safe_error(null, 'Erro na operação, tentou apagar uma resposta de outro utilizador?');
    }
  }
  catch (PDOException $e) {
    safe_error(null, $e->getMessage());
  }
?>