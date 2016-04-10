<?
  error_reporting(E_ERROR | E_WARNING);
  session_set_cookie_params(3600, '/~up201305642');
  session_start();

  $BASE_DIR = '/usr/users2/mieic2013/up201305642/public_html/proto/';
  $BASE_URL = '/~up201305642/proto/';

  $db = new PDO('pgsql:host=dbm.fe.up.pt;dbname=lbaw1525', 'lbaw1525', 'XZ39G6J6');
  $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  $db->exec('SET SCHEMA \'knowUP\'');

  include_once($BASE_DIR . 'lib/smarty/Smarty.class.php');

  $smarty = new Smarty;
  $smarty->template_dir = $BASE_DIR . 'templates/';
  $smarty->compile_dir = $BASE_DIR . 'templates_c/';
  $smarty->assign('BASE_URL', $BASE_URL);
  $smarty->assign('ERROR_MESSAGES', $_SESSION['error_messages']);  
  $smarty->assign('FIELD_ERRORS', $_SESSION['field_errors']);
  $smarty->assign('SUCCESS_MESSAGES', $_SESSION['success_messages']);
  $smarty->assign('FORM_VALUES', $_SESSION['form_values']);
  $smarty->assign('USERNAME', $_SESSION['username']);
  
  unset($_SESSION['success_messages']);
  unset($_SESSION['error_messages']);  
  unset($_SESSION['field_errors']);
  unset($_SESSION['form_values']);
?>