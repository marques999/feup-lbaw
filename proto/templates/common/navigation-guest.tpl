<!-- NAVEGAÇÃO -->
<body class="ink-drawer">
<header id="header-container">
<nav id="header-menu" class="ink-navigation">


<!-- NAVEGAÇÃO RESPONSIVE (tiny/small) -->
<ul class="menu horizontal black push-left hide-all show-small show-tiny small-push-center tiny-push-center">
  <li id="nav-drawer" class="hide-all show-tiny show-small">
    <button class="ink-button black half-horizontal-space quarter-vertical-padding fa fa-bars left-drawer-trigger"></button>
  </li>
  <li id="nav-notifications" class="disabled medium">
    <a href="#"><i class="fa fa-bell-o"></i>0</a>
  </li>
  <li id="nav-messages" class="disabled medium">
    <a href="#"><i class="fa fa-envelope-o"></i>0</a>
  </li>
  <li id="nav-profile" class="medium">
    <a href="user_login.php"><i class="fa fa-user"></i>Visitante</a>
  </li>
</ul>


<!-- NAVEGAÇÃO RESPONSIVE (medium/large/xlarge) -->
<ul class="menu medium horizontal black hide-small hide-tiny">
  <li id="nav-home" class="no-margin">
    <a href="index.php">
      <img src="{$BASE_DIR}/images/assets/header-256px.png" alt="">
    </a>
  </li>
  <form action="list_results.php" class="ink-form ink-search all-20 medium">
    <div class="control-group">
      <div class="control append-button" role="search">
        <span><input type="text" name="name" id="name"></span>
        <button class="ink-button"><i class="fa fa-search"></i></button>
      </div>
    </div>
  </form>
  <li id="nav-ask">
    <a href="message_guest.php">
      <i class="fa fa-comment-o"></i>
      Perguntar</a>
  </li>
  <li id="nav-answer">
    <a href="message_guest.php">
      <i class="fa fa-pencil-square-o"></i>
      Responder
    </a>
  </li>
  <li id="nav-notifications" class="disabled">
    <a href="#">
      <i class="fa fa-bell-o"></i>
      Notificações
    </a>
  </li>
  <li id="nav-profile">
    <a href="user_login.php">
      <i class="fa fa-user"></i>
      Visitante
    </a>
  </li>
</ul>
</nav>
</header>