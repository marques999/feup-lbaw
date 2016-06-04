<header id="header-container">
<nav id="header-menu" class="ink-navigation">
<ul class="menu horizontal black push-left hide-all show-small show-tiny small-push-center tiny-push-center">
  <li class="hide-all show-tiny show-small">
    <a href="#left-drawer" class="ink-button black half-horizontal-space quarter-vertical-padding fa fa-bars left-drawer-trigger"></a>
  </li>
  <li class="disabled medium">
    <a href="#">
      <i class="fa fa-bell-o"></i>
      <span>0</span>
    </a>
  </li>
  <li class="disabled medium">
    <a href="#">
      <i class="fa fa-envelope-o"></i>
      <span>0</span>
    </a>
  </li>
  <li class="medium push-right">
    <a href="{$BASE_URL}pages/utilizador/login.php">
      <i class="fa fa-user"></i>
      <span>Visitante</span>
    </a>
  </li>
</ul>
<ul class="menu medium horizontal black hide-small hide-tiny">
  <li class="no-margin">
    <a href="{$BASE_URL}pages/homepage.php">
      <img src="{$BASE_URL}/images/assets/header-256px.png" alt="">
    </a>
  </li>
  <form action="{$BASE_URL}pages/pesquisa/pergunta.php" class="ink-form ink-search all-20 medium">
    <div class="control-group">
      <div class="control append-button" role="search">
        <span><input type="text" name="query" id="query"></span>
        <button class="ink-button"><i class="fa fa-search"></i></button>
      </div>
    </div>
  </form>
  <li>
    <a href="{$BASE_URL}pages/utilizador/login.php">
      <i class="fa fa-comment-o"></i>
      <span>Perguntar</span>
    </a>
  </li>
  <li>
    <a href="{$BASE_URL}pages/categoria/list.php">
      <i class="fa fa-pencil-square-o"></i>
      <span>Responder</span>
    </a>
  </li>
  <li class="disabled">
    <a href="#">
      <i class="fa fa-bell-o"></i>
      <span>Notificações</span>
    </a>
  </li>
  <li>
    <a href="{$BASE_URL}pages/utilizador/login.php">
      <i class="fa fa-user"></i>
      <span>Visitante</span>
    </a>
  </li>
</ul>
</nav>
</header>