<body class="ink-drawer">
<header id="header-container">
<nav id="header-menu" class="ink-navigation">
<ul class="menu horizontal black push-left hide-all show-small show-tiny small-push-center tiny-push-center">
  <li id="nav-drawer" class="hide-all show-tiny show-small">
    <button class="ink-button black half-horizontal-space quarter-vertical-padding fa fa-bars left-drawer-trigger"></button>
  </li>
  <li id="nav-notifications" class="medium">
    <a href="{$BASE_URL}pages/utilizador/notifications.php">
      <i class="fa fa-bell-o"></i><span class="ink-badge red">5</span>
    </a>
  </li>
  <li id="nav-messages" class="medium">
    <a href="{$BASE_URL}pages/conversa/list.php">
      <i class="fa fa-envelope-o"></i><span class="ink-badge red">3</span>
    </a>
  </li>
  <li id="nav-profile" class="medium">
    <a href="{$BASE_URL}pages/utilizador/profile.php">
      <i class="fa fa-user"></i>
      <span>{$USERNAME}</span>
    </a>
    <ul class="submenu fw-600">
      <div class="half-vertical-padding align-center">
       <img class="avatar-medium" src="{$USERID|utilizador_getAvatar}" alt="">
      </div>
      <li><a href="{$BASE_URL}pages/utilizador/profile.php">Perfil</a></li>
      <li><a href="{$BASE_URL}pages/utilizador/manage.php#questions">Gerir perguntas</a></li>
      <li><a href="{$BASE_URL}pages/utilizador/manage.php#answers">Gerir respostas</a></li>
      <li><a href="{$BASE_URL}pages/utilizador/logout.php">Terminar sessão</a></li>
    </ul>
  </li>
</ul>
<ul class="menu medium horizontal black hide-small hide-tiny">
  <li id="nav-home" class="no-margin">
    <a href="{$BASE_URL}pages/homepage.php">
      <img src="{$BASE_URL}images/assets/header-256px.png" alt="">
    </a>
  </li>
  <form action="{$BASE_URL}pages/pesquisa/pergunta.php" class="ink-form ink-search all-20 medium">
    <div class="control-group">
      <div class="control append-button" role="search">
        <span><input type="text" name="query" id="query" value="{$FORM_VALUES.query}"></span>
        <button class="ink-button"><i class="fa fa-search"></i></button>
      </div>
    </div>
  </form>
  <li id="nav-ask">
    <a href="{$BASE_URL}pages/pergunta/ask.php">
      <i class="fa fa-comment-o"></i>
      Perguntar
    </a>
  </li>
  <li id="nav-answer">
    <a href="{$BASE_URL}pages/categoria/list.php">
      <i class="fa fa-pencil-square-o"></i>
      Responder
    </a>
  </li>
  <li id="nav-notifications">
    <a href="{$BASE_URL}pages/utilizador/notifications.php">
      <i class="fa fa-bell-o"></i>
      Notificações<span class="ink-badge red">5</span>
    </a>
  </li>
  <li id="nav-profile">
    <a href="{$BASE_URL}pages/utilizador/profile.php">
      <i class="fa fa-user"></i>
      {$USERNAME}</span><span class="ink-badge red">3</span>
    </a>
    <ul class="submenu fw-600">
      <div class="half-vertical-padding align-center">
       <img class="avatar-medium" src="{$USERID|utilizador_getAvatar}" alt="">
      </div>
      <li><b><a href="{$BASE_URL}pages/conversa/list.php">Mensagens (3)</a></b></li>
      <li><a href="{$BASE_URL}pages/utilizador/profile.php">Perfil</a></li>
      <li><a href="{$BASE_URL}pages/utilizador/manage.php#questions">Gerir perguntas</a></li>
      <li><a href="{$BASE_URL}pages/utilizador/manage.php#answers">Gerir respostas</a></li>
      <li><a href="{$BASE_URL}actions/utilizador/logout.php">Terminar sessão</a></li>
    </ul>
  </li>
</ul>
</nav>
</header>