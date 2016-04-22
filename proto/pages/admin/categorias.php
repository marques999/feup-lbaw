<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if ($_SESSION['idUtilizador']) {

    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');

    if (utilizador_isAdministrator($idUtilizador)) {
      $smarty->assign('categorias', categoria_listAll());
      $smarty->assign('titulo', 'Gerir Categorias');
      $smarty->display('admin/categorias.tpl');
    }
    else {
      safe_redirect('403.php');
    }
  }
  else {
    safe_redirect('utilizador/login.php');
  }
?>