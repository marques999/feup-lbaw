<?
  include_once('../../config/init.php');
  include_once('../../database/instituicao.php');
  include_once('../../database/utilizador.php');
  $queryCountry = file_get_contents($BASE_DIR . 'javascript/countries.json');
  $smarty->assign('instituicoes', instituicao_listarInstituicoes());
  $smarty->assign('paises', json_decode($queryCountry, true));
  $smarty->assign('titulo', 'Registar Conta');
  $smarty->display('utilizador/register.tpl');
?>