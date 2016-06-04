<body class="ink-drawer">
<nav class="left-drawer ink-navigation">
  <ul class="menu vertical black">
    <li id="heading-pesquisa" class="heading">
      <span>Pesquisa</span>
    </li>
    <li class="search">
      <form action="http://ink.sapo.pt/search/" method="GET" class="docsearch" role="search">
        <input type="search" class="search-field" name="search">
        <span class="fa fa-search"></span>
      </form>
    </li>
    <li class="heading">
      <span>Navegação</span>
    </li>
    <li id="nav-perguntar">
      <a href="{$BASE_URL}pages/categoria/list.php">
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
      <li>
      <a href="{$BASE_URL}pages/instituicao/list.php">
        <i class="fa fa-fw fa-search"></i>
        <span>Pesquisa avançada</span>
      </a>
    </li>
    {if $USERNAME}
    <li class="heading">
      <span>Utilizador</span>
    </li>
    <li>
      <a href="{$BASE_URL}pages/utilizador/profile.php">
        <i class="fa fa-fw fa-user"></i>
        <span>Ver perfil</span>
      </a>
    </li>
    <li>
      <a href="{$BASE_URL}pages/utilizador/profile.php#questions">
        <i class="fa fa-fw fa-cog"></i>
        <span>Gerir publicações</span>
      </a>
    </li>
    <li>
      <a href="{$BASE_URL}actions/utilizador/logout.php">
        <i class="fa fa-fw fa-door"></i>
        <span>Terminar sessão</span>
      </a>
    </li>
    {/if}
  </ul>
</nav>
{if $USERNAME}
  {include file='common/navigation-user.tpl'}
{else}
  {include file='common/navigation-guest.tpl'}
{/if}