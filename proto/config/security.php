<?
  function safe_getId($array, $id){
    if (!isset($array[$id])){
      return 0;
    }
    $newid=intval($array[$id]);
    return $newid<0?0:$newid;
  }
  function safe_getVote($array, $id){
    if (!isset($array[$id])){
      return 0;
    }
    $newid=intval($array[$id]);
    if($newId==1||$newId==-1) {
      return $newId;
    }
    return 0;
  }
  function safe_redirect($defaultUrl){
    global $BASE_URL;
    if ($defaultUrl==null) {
       $refererUrl = $_SERVER['HTTP_REFERER'];
       if (!isset($_SERVER['HTTP_REFERER'])) {
        $refererUrl = $BASE_URL . 'pages/homepage.php';
      }
    }
    else {
      $refererUrl = $BASE_URL . 'pages/' . $defaultUrl;
    }
    header("Location: $refererUrl");
  }
  function safe_error($defaultUrl, $errorMessage) {
    global $_SESSION;
    if (isset($errorMessage)) {
      $_SESSION['error_messages'][] = $errorMessage;
    }
    safe_redirect($defaultUrl);
  }
  function safe_check($array, $id){
    return isset($array[$id]);
  }
  function safe_trim($text, $tags = '') {
    $workingString = preg_replace('@<(\w+)\b.*?>.*?</\1>@si', '', $text);
    $workingString = preg_replace('!\s+!', ' ', $workingString);
    return htmlspecialchars($workingString);
  }
?>