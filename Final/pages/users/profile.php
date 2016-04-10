<?
  include_once('../../config/init.php');
  $stmt = $conn->prepare("SELECT * FROM Utilizador WHERE idUtilizador = ?");
  $result = $stmt->execute(array($idUtilizador));
  $smarty->assign('utilizador', $result);
  $smarty->display('users/profile.tpl');
?>