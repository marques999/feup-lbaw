<?
	session_start();
	include_once('../model/action.php');
	include_once('../core/salt.php');
	include_once('../model/users.php');

	$sessionId = validateLogin($_POST['username'], $_POST['password']);

	if ($sessionId > 0) {
		$_SESSION['username'] = $_POST['username'];
		$_SESSION['userid'] = $sessionId;
		header("Location: ../index.php");
	}
	else {
		header("Location: ../login.php?error=1");
	}
?>