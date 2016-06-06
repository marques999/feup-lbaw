<?
  error_reporting(E_ERROR | E_WARNING);
  setlocale(LC_TIME, 'Portuguese_Portugal');
  session_save_path('/opt/lbaw/lbaw1525/public_html/');
  session_set_cookie_params(3600, '/~lbaw1525/final/');
  session_start();

  $BASE_DIR = '/opt/lbaw/lbaw1525/public_html/final/';
  $BASE_URL = '/~lbaw1525/final/';

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
  $smarty->assign('USERNAME', $_SESSION['username']);
  $smarty->assign('USERID', $_SESSION['idUtilizador']);

  unset($_SESSION['success_messages']);
  unset($_SESSION['error_messages']);
  unset($_SESSION['field_errors']);
  unset($_SESSION['form_values']);
?>