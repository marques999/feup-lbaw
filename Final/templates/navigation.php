<!-- NAVEGAÇÃO -->
<body class="ink-drawer">
<header id="header-container">
<nav id="header-menu" class="ink-navigation">


<!-- NAVEGAÇÃO RESPONSIVE (tiny/small) -->
<ul class="menu horizontal black push-left hide-all show-small show-tiny small-push-center tiny-push-center">
  <li id="nav-drawer" class="hide-all show-tiny show-small">
    <button class="ink-button black half-horizontal-space quarter-vertical-padding fa fa-bars left-drawer-trigger"></button>
  </li>
  <li id="nav-notifications" class="medium">
    <a href="notifications.php">
      <i class="fa fa-bell-o"></i><span class="ink-badge red">5</span>
    </a>
  </li>
  <li id="nav-messages" class="medium">
    <a href="view_messages.php">
      <i class="fa fa-envelope-o"></i><span class="ink-badge red">3</span>
    </a>
  </li>
  <li id="nav-profile" class="medium">
    <a href="view_profile.php">
      <i class="fa fa-user"></i>
      <span>marques999</span>
    </a>
    <ul class="submenu fw-600">
      <div class="half-padding align-center">
       <img class="img-circle" src="holder.js/64x64/auto/ink" alt="">
      </div>
      <li><a href="view_profile.php#profile">Perfil</a></li>
      <li><a href="view_profile.php#questions">Gerir perguntas</a></li>
      <li><a href="view_profile.php#answers">Gerir respostas</a></li>
      <li><a href="user_logout.php">Terminar sessão</a></li>
    </ul>
  </li>
</ul>


<!-- NAVEGAÇÃO RESPONSIVE (medium/large/xlarge) -->
<ul class="menu medium horizontal black hide-small hide-tiny">
  <li id="nav-home" class="no-margin">
    <a href="index_user.php">
      <img src="img/header-256px.png" alt="">
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
    <a href="ask_question.php">
      <i class="fa fa-comment-o"></i>
      Perguntar
    </a>
  </li>
  <li id="nav-answer">
    <a href="categories.php">
      <i class="fa fa-pencil-square-o"></i>
      Responder
    </a>
  </li>
  <li id="nav-notifications">
    <a href="notifications.php">
      <i class="fa fa-bell-o"></i>
      Notificações<span class="ink-badge red">5</span>
    </a>
  </li>
  <li id="nav-profile">
    <a href="view_profile.php">
      <i class="fa fa-user"></i>
      marques999</span><span class="ink-badge red">3</span>
    </a>
    <ul class="submenu fw-600">
      <div class="half-padding align-center">
       <img class="img-circle" src="holder.js/64x64/auto/ink" alt="">
      </div>
      <li><b><a href="view_messages.php">Mensagens (3)</a></b></li>
      <li><a href="view_profile.php#profile">Perfil</a></li>
      <li><a href="view_profile.php#questions">Gerir perguntas</a></li>
      <li><a href="view_profile.php#answers">Gerir respostas</a></li>
      <li><a href="user_logout.php">Terminar sessão</a></li>
    </ul>
  </li>
</ul>
</nav>
</header>