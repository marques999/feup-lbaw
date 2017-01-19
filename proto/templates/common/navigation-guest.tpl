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
    <a href="{$BASE_URL}pages/utilizador/login.php">
      <i class="fa fa-fw fa-user"></i>
      <span>Visitante</span>
    </a>
  </li>
</ul>
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
      <span>
        {if $query}
        <input type="text" name="query" id="query" value="{$query}">
        {else}
        <input type="text" name="query" id="query">
        {/if}
      </span>
      <button class="ink-button">
        <i class="fa fa-search"></i>
      </button>
    </div>
  </div>
</form>
<li>
  <a href="{$BASE_URL}pages/utilizador/login.php">
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
    <a href="{$BASE_URL}pages/utilizador/login.php">
      <i class="fa fa-fw fa-user"></i>
      <span>Visitante</span>
    </a>
  </li>
</ul>