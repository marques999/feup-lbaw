<header id="header-container">
<nav id="header-menu" class="ink-navigation">
<ul class="menu horizontal black hide-all show-small show-tiny small-push-center tiny-push-center">
  <li class="hide-all show-tiny show-small">
    <button class="ink-button black half-horizontal-space quarter-vertical-padding fa fa-bars left-drawer-trigger"></button>
  </li>
  <li class="medium">
    <a href="{$BASE_URL}pages/utilizador/notifications.php">
      <i class="fa fa-bell-o"></i><span class="ink-badge red">5</span>
    </a>
  </li>
  <li class="medium">
    <a href="{$BASE_URL}pages/conversa/list.php">
      <i class="fa fa-envelope-o"></i><span class="ink-badge red">3</span>
    </a>
  </li>
  <li class="medium">
    <a href="#">{$USERNAME}</a>
  </li>
</ul>
<ul class="menu medium horizontal black hide-small hide-tiny">
  <li class="no-margin">
    <a href="{$BASE_URL}pages/homepage.php">
      <img src="{$BASE_URL}images/assets/header-256px.png" alt="">
    </a>
  </li>
  <form action="{$BASE_URL}pages/pesquisa/pergunta.php" class="ink-form ink-search all-20 medium">
    <div class="control-group">
      <div class="control append-button" role="search">
        <span>
          <input type="text" name="query" id="query" value="{$FORM_VALUES.query}">
        </span>
        <button class="ink-button">
          <i class="fa fa-search"></i>
        </button>
      </div>
    </div>
  </form>
  <li>
    <a href="{$BASE_URL}pages/pergunta/ask.php">
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
  <li>
    <a href="{$BASE_URL}pages/utilizador/notifications.php">
      <i class="fa fa-bell-o"></i>
      <span>Notificações</span><span class="ink-badge red">5</span>
    </a>
  </li>
  <li>
    <a href="{$BASE_URL}pages/utilizador/profile.php">
      <i class="fa fa-user"></i>
      <span>{$USERNAME}</span><span class="ink-badge red">3</span>
    </a>
    <ul class="submenu fw-600">
      <li class="half-vertical-padding align-center">
        <img class="avatar-medium" 
             src="{$USERID|utilizador_getAvatar}"
             alt="{$USERNAME}">
      </li>
      <li>
        <a href="{$BASE_URL}pages/conversa/list.php">
          <strong>Mensagens (3)</strong>
        </a>
      </li>
      <li>
        <a href="{$BASE_URL}pages/utilizador/profile.php">
          <span>Perfil</span>
        </a>
      </li>
      <li>
        <a href="{$BASE_URL}pages/utilizador/profile.php#questions">
          <span>Gerir perguntas</span>
        </a>
      </li>
      <li>
        <a href="{$BASE_URL}pages/utilizador/profile.php#answers">
          <span>Gerir respostas</span>
        </a>
      </li>
      <li>
        <a href="{$BASE_URL}actions/utilizador/logout.php">
          <span>Terminar sessão</span>
        </a>
      </li>
    </ul>
  </li>
</ul>
</nav>
</header>