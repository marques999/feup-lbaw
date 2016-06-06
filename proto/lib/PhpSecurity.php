<?
function safe_getId($array, $id)
{
	if (!isset($array[$id]) || !is_numeric($array[$id]))
	{
		return 0;
	}
	
	$safeId = intval($array[$id]);
	
	return $safeId < 0 ? 0 : $safeId;
}

function safe_checkAdministrador()
{
	global $_SESSION;
	return $_SESSION['permissions'] == 'AD6tkUOG';
}

function safe_checkModerador()
{
	global $_SESSION;
	return $_SESSION['permissions']  == 'GQ7h3hBA';
}

function safe_getVote($array, $id)
{
	if (!isset($array[$id]) || !is_numeric($array[$id]))
	{
		return 0;
	}

	$safeId = intval($array[$id]);

	if ($safeId == 1 || $safeId == -1)
	{
		return $safeId;
	}

	return 0;
}

function safe_redirect($defaultUrl)
{
	global $BASE_URL;

	if ($defaultUrl == null)
	{
		$refererUrl = $_SERVER['HTTP_REFERER'];

		if (!isset($_SERVER['HTTP_REFERER']))
		{
			$refererUrl = $BASE_URL . 'pages/homepage.php';
		}
	}
	else
	{
		$refererUrl = $BASE_URL . 'pages/' . $defaultUrl;
	}

	header("Location: $refererUrl");

	exit;
}
  
function safe_formerror($errorMessage, $defaultUrl = null)
{
	global $_POST;
	global $_SESSION;

	if (isset($errorMessage))
	{
		$_SESSION['error_messages'][] = $errorMessage;
		$_SESSION['form_values'] = $_POST;
	}

	safe_redirect($defaultUrl);
}

function safe_login()
{
	global $_SESSION;
	$_SESSION['error_messages'][] = 'Deve estar autenticado para aceder a esta página!';
	safe_redirect('utilizador/login.php');
}

function safe_error($errorMessage, $defaultUrl = null)
{
	global $_SESSION;

	if (isset($errorMessage))
	{
		$_SESSION['error_messages'][] = $errorMessage;
	}

	safe_redirect($defaultUrl);
}

function safe_check($array, $index)
{
	return isset($array[$index]);
}

function safe_strcheck($array, $index)
{
	return isset($array[$index]) && !empty($array[$index]);
}

function safe_trimAll($array, $index)
{
	$workingString = preg_replace('@<(\w+)\b.*?>.*?</\1>@si', '', $array[$index]);
	$workingString = preg_replace('!\s+!', ' ', $workingString);
	return htmlspecialchars($workingString);
}

function safe_trim($array, $index)
{
	return htmLawed($array[$index]);
}
?>