<?
	if (!isset($_SESSION)) {
		session_start();
	}

	include_once('../model/action.php');
	include_once('../model/users.php');
	include_once('../model/session.php');

	if (safe_check($_POST, 'idUser') && $loggedIn) {

		$result = false;
		$userId = safe_getId($_POST['idUser']);
		$userExists = users_idExists($userId);

		if ($userId > 0 && $userExists && $thisUser == $userId) {

			$stmt = $db->prepare('DELETE FROM Users WHERE idUser = :idUser');
			$stmt->bindParam(':idUser', $userId, PDO::PARAM_INT);

			if ($stmt->execute()){
				$result = true;
			}
			else {
				header("Location: ../database_error.php");
			}

			if ($result) {

				if (isset($_SESSION['username'])) {
					unset($_SESSION['username']);
				}

				if (isset($_SESSION['userid'])) {
					unset($_SESSION['userid']);
				}

				session_destroy();
				header("Location: ../index.php");
			}
		}
	}
	else {
		safe_redirect("../index.php");
	}
?>