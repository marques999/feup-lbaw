<li class="hide-all show-tiny show-small">
  <button class="ink-button black fa fa-bars left-drawer-trigger"></button>
</li>
<li class="medium">
 <a href="{$BASE_URL}pages/homepage.php">
  <strong>KnowUP!</strong>
  <small>collaborative q&a</small>
  </a>
</li>
<ul class="push-right">
  <li class="medium">
    <a href="#">
      <i class="fa fa-user"></i>
      <span>{$USERNAME}</span>
    </a>
  </li>
</ul>
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
        <input type="search" name="query" id="query" value="{$FORM_VALUES.query}">
      </span>
      <button class="ink-button">
        <i class="fa fa-search"></i>
      </button>
    </div>
  </div>
</form>
<li>
  <a href="{$BASE_URL}pages/pergunta/submit.php">
    <i class="fa fa-fw fa-question-circle"></i>
    <span>Perguntar</span>
  </a>
</li>
<li>
  <a href="{$BASE_URL}pages/categoria/list.php">
    <i class="fa fa-fw fa-database"></i>
    <span>Categorias</span>
  </a>
</li>
<li>
  <a href="{$BASE_URL}pages/instituicao/list.php">
    <i class="fa fa-fw fa-institution"></i>
    <span>Instituições</span>
  </a>
</li>
<ul class="push-right">
  <li>
    <a href="{$BASE_URL}pages/utilizador/profile.php">
      <i class="fa fa-fw fa-user"></i>
      <span>{$USERNAME}</span><span class="ink-badge red">3</span>
    </a>
    <ul class="submenu fw-600">
      <li class="half-vertical-padding align-center">
        <img class="avatar-medium"
             src="{$USERID|utilizador_getAvatar}"
             alt="{$USERNAME}">
      </li>
      {if $ADMINISTRADOR}
      <li>
        <a href="{$BASE_URL}pages/admin/homepage.php">
          <span>Administração</span>
        </a>
      </li>
      {/if}
      <li>
        <a href="{$BASE_URL}pages/conversa/list.php">
          <strong>Mensagens (3)</strong>
        </a>
      </li>
      <li>
        <a href="{$BASE_URL}pages/utilizador/notifications.php">
          <strong>Notificações (5)</strong>
        </a>
      </li>
      <li>
        <a href="{$BASE_URL}pages/utilizador/profile.php">
          <span>Ver perfil</span>
        </a>
      </li>
      <li>
        <a href="{$BASE_URL}pages/utilizador/profile.php#questions">
          <span>Gerir publicações</span>
        </a>
      </li>
      {if $MODERADOR}
      <li>
        <a href="{$BASE_URL}pages/utilizador/report.php">
          <span> Gerir reports</span>
        </a>
      </li>
      {/if}
      <li>
        <a href="{$BASE_URL}actions/utilizador/logout.php">
          <span>Terminar sessão</span>
        </a>
      </li>
    </ul>
  </li>
</ul>