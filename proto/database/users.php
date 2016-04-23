<?
  function users_formatLocation($userData) {
    if (!is_array($userData) || !isset($userData['country']) || !isset($userData['location'])) {
      $userData = $defaultUser;
    }
    $countryString = getCountry($userData['country']);
    return "{$userData['location']}, $countryString";
  }
  function users_fileUploaded() {
    if (empty($_FILES)) {
      return false;
    }
    $fileName = $_FILES['image'];
    if (!file_exists($fileName['tmp_name']) || !is_uploaded_file($fileName['tmp_name'])) {
      return false;
    }
    return true;
  }
  function users_getCountryFlag($userData) {
    if (!is_array($userData) || !isset($userData['country'])) {
      $userData = $defaultUser;
    }
    $country = $userData['country'];
    if (strlen($country) != 2) {
      $country = 'europeanunion.png';
    }
    return "img/flags/$country.png";
  }
  function users_getAvatar($idUtilizador) {
    $avatarLocation = glob("img/avatars/{$idUtilizador}.{jpg,jpeg,gif,png}", GLOB_BRACE);
    return $avatarLocation != false ? $avatarLocation[0] : "holder.js/200x200/auto/ink";
  }
  function users_getSmallAvatar($idUtilizador) {
    $avatarLocation = glob("img/avatars/{$idUtilizador}_small.{jpg,jpeg,gif,png}", GLOB_BRACE);
    return $avatarLocation != false ? $avatarLocation[0] : "holder.js/64x64/auto/ink";
  }
  function users_listAllEvents($user_id, $private) {
    global $db;
    if ($private) {
      $stmt = $db->prepare('SELECT DISTINCT Events.* FROM UserEvents JOIN Utilizador, Events
        ON UserEvents.idUser = :idOwner
        AND Events.idEvent = UserEvents.idEvent
        AND Utilizador.idUser = UserEvents.idUser');
    }
    else {
      $stmt = $db->prepare('SELECT DISTINCT Events.* FROM UserEvents JOIN Utilizador, Events
        ON UserEvents.idUser = :idOwner
        AND Events.idEvent = UserEvents.idEvent
        AND Utilizador.idUser = UserEvents.idUser
        AND (Events.private = 0
        OR (Events.private = 1 AND UserEvents.idUser = :idUser))');
      $stmt->bindParam(':idUser', $thisUser, PDO::PARAM_INT);
    }
    $stmt->bindParam(':idOwner', $user_id, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
  }

  function users_listOwnEvents($user_id, $private) {
    global $db;
    if ($private) {
      $stmt = $db->prepare('SELECT DISTINCT * FROM Events WHERE idUser = :idOwner');
    }
    else {
       $stmt = $db->prepare('SELECT DISTINCT Events.* FROM Events
        JOIN UserEvents ON Events.idUser = :idOwner
        AND UserEvents.idEvent = Events.idEvent
        AND (Events.private = 0 OR (Events.private = 1 AND UserEvents.idUser = :idUser))');
       $stmt->bindParam(':idUser', $thisUser, PDO::PARAM_INT);
    }
    $stmt->bindParam(':idOwner', $user_id, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
  }
  function users_isParticipating($user_id, $event_id) {
    global $db;
    $stmt = $db->prepare('SELECT * FROM UserEvents WHERE UserEvents.idEvent = :idEvent AND UserEvents.idUser = :idUser');
    $stmt->bindParam(':idEvent', $event_id, PDO::PARAM_INT);
    $stmt->bindParam(':idUser', $user_id, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll() != false;
  }
  function users_wasInvited($user_id, $event_id) {
    global $db;
    $stmt = $db->prepare('SELECT * FROM Invites WHERE Invites.idEvent = :idEvent AND Invites.idUser = :idUser');
    $stmt->bindParam(':idEvent', $event_id, PDO::PARAM_INT);
    $stmt->bindParam(':idUser', $user_id, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll() != false;
  }
  function users_listInvite($user_id, $event_id) {
    global $db;
    $stmt = $db->prepare('SELECT Invites.idSender FROM Invites WHERE Invites.idEvent = :idEvent AND Invites.idUser = :idUser');
    $stmt->bindParam(':idEvent', $event_id, PDO::PARAM_INT);
    $stmt->bindParam(':idUser', $user_id, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetch();
  }
  function users_listFutureEvents($user_id, $current_date) {
    global $db;
    $stmt = $db->prepare('SELECT Events.* FROM UserEvents JOIN Utilizador, Events
      ON UserEvents.idUser = :idUser
      AND Events.idEvent = UserEvents.idEvent
      AND Utilizador.idUser = UserEvents.idUser
      WHERE Events.date > :currentDate');
    $stmt->bindParam(':idUser', $user_id, PDO::PARAM_INT);
    $stmt->bindParam(':currentDate', $current_date, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
  }
  function users_listInvites($user_id) {
    global $db;
    $stmt = $db->prepare('SELECT Events.*, Invites.idSender FROM Invites
      INNER JOIN Events
      ON Events.idEvent = Invites.idEvent
      AND Invites.idUser = :idUser');
    $stmt->bindParam(':idUser', $user_id, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
  }
  function users_usernameExists($username) {
    global $db;
    $stmt = $db->prepare('SELECT username FROM Utilizador WHERE username = :username');
    $stmt->bindParam(':username', $username, PDO::PARAM_STR);
    $stmt->execute();
    $result = $stmt->fetchAll();
    return $result != false && is_array($result) && count($result) > 0;
  }
  function users_idExists($user_id) {
    global $db;
    $stmt = $db->prepare('SELECT username FROM Utilizador WHERE idUser = :idUser');
    $stmt->bindParam(':idUser', $user_id, PDO::PARAM_INT);
    $stmt->execute();
    $result = $stmt->fetchAll();
    return $result != false && is_array($result) && count($result) > 0;
  }
  function users_emailExists($email) {
    global $db;
    $stmt = $db->prepare('SELECT email FROM Utilizador WHERE email = :email');
    $stmt->bindParam(':email', $email, PDO::PARAM_STR);
    $stmt->execute();
    $result = $stmt->fetchAll();
    return $result != false && is_array($result) && count($result) > 0;
  }
?>