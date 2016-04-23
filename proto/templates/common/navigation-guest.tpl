<body class="ink-drawer">
<header id="header-container">
  <nav id="header-menu" class="ink-navigation">
    <ul class="menu horizontal black push-left hide-all show-small show-tiny small-push-center tiny-push-center">
      <li id="nav-drawer" class="hide-all show-tiny show-small">
        <button class="ink-button black half-horizontal-space quarter-vertical-padding fa fa-bars left-drawer-trigger"></button>
      </li>
      <li id="nav-notifications" class="disabled medium">
        <a href="#">
          <i class="fa fa-bell-o"></i>
          <span id="tag-notifications">0</span>
        </a>
      </li>
      <li id="nav-messages" class="disabled medium">
        <a href="#">
          <i class="fa fa-envelope-o"></i>
          <span id="tag-messages">0</span>
        </a>
      </li>
      <li id="nav-profile" class="medium">
        <a href="{$BASE_URL}pages/utilizador/login.php">
          <i class="fa fa-user"></i>
          <span id="tag-profile">Visitante</span>
        </a>
      </li>
    </ul>
    <ul class="menu medium horizontal black hide-small hide-tiny">
      <li id="nav-home" class="no-margin">
        <a href="{$BASE_URL}pages/homepage.php">
          <img src="{$BASE_URL}/images/assets/header-256px.png" alt="">
        </a>
      </li>
      <form action="{$BASE_URL}pages/pesquisa/results.php" class="ink-form ink-search all-20 medium">
        <div class="control-group">
          <div class="control append-button" role="search">
            <span><input type="text" name="query" id="query"></span>
            <button class="ink-button"><i class="fa fa-search"></i></button>
          </div>
        </div>
      </form>
      <li id="nav-ask">
        <a href="{$BASE_URL}pages/utilizador/login.php">
          <i class="fa fa-comment-o"></i>
          <span id="tag-ask">Perguntar</span>
        </a>
      </li>
      <li id="nav-browse">
        <a href="{$BASE_URL}pages/categoria/list.php">
          <i class="fa fa-pencil-square-o"></i>
          <span id="tag-browse">Responder</span>
        </a>
      </li>
      <li id="nav-notifications" class="disabled">
        <a href="#">
          <i class="fa fa-bell-o"></i>
          <span id="tag-notifications">Notificações</span>
        </a>
      </li>
      <li id="nav-profile">
        <a href="{$BASE_URL}pages/utilizador/login.php">
          <i class="fa fa-user"></i>
          <span id="tag-profile">Visitante</span>
        </a>
      </li>
    </ul>
  </nav>
</header>