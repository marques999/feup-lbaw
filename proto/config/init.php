<?
  error_reporting(E_ERROR | E_WARNING);
  setlocale(LC_TIME, 'Portuguese_Portugal');
  session_set_cookie_params(3600, '/~up201305642/proto/');
  session_start();

  $BASE_DIR = '/usr/users2/mieic2013/up201305642/public_html/proto/';
  $BASE_URL = '/~up201305642/proto/';

  $db = new PDO('pgsql:host=dbm;dbname=lbaw1525', 'lbaw1525', 'XZ39G6J6');
  $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  $db->exec('SET SCHEMA \'knowup\'');

  include_once($BASE_DIR . 'lib/smarty/Smarty.class.php');
  include_once($BASE_DIR . 'lib/HtmLawed.php');
  include_once($BASE_DIR . 'lib/PhpSecurity.php');

  $smarty = new Smarty;
  $smarty->template_dir = $BASE_DIR . 'templates/';
  $smarty->compile_dir = $BASE_DIR . 'templates_c/';
  $smarty->assign('BASE_URL', $BASE_URL);
  $smarty->assign('ERROR_MESSAGES', $_SESSION['error_messages']);
  $smarty->assign('FIELD_ERRORS', $_SESSION['field_errors']);
  $smarty->assign('SUCCESS_MESSAGES', $_SESSION['success_messages']);
  $smarty->assign('FORM_VALUES', $_SESSION['form_values']);
  $smarty->assign('PERMISSIONS', $_SESSION['permissions']);
  $smarty->assign('USERNAME', $_SESSION['username']);
  $smarty->assign('USERID', $_SESSION['idUtilizador']);
  $smarty->assign('ADMINISTRADOR', safe_checkAdministrador());
  $smarty->assign('MODERADOR', safe_checkModerador());

  unset($_SESSION['success_messages']);
  unset($_SESSION['error_messages']);
  unset($_SESSION['field_errors']);
  unset($_SESSION['form_values']);
?>