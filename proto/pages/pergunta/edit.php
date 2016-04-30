<?
  include_once('../../config/init.php');
  include_once('../../database/pergunta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {

    if (safe_check($_GET, 'id')) {

      $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
      $idPergunta = safe_getId($_GET, 'id');
      $queryPergunta = pergunta_listById($idPergunta);
      $idAutor = safe_getId($queryPergunta, 'idutilizador');

      if ($idUtilizador == $idAutor) {
        $smarty->display('pergunta/edit.tpl');
      }
      else {
        safe_redirect('403.php');
      }
    }
    else {
      safe_redirect('404.php');
    }
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>