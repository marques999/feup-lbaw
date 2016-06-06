<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="HandheldFriendly" content="True">
<meta name="MobileOptimized" content="320">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0">
{if $titulo}
<title>{$titulo} - KnowUP!</title>
{else}
<title>KnowUP! - Collaborative Q&A</title>
{/if}
<link rel="shortcut icon" href="{$BASE_URL}images/favicon.ico">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/css/ink.min.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="{$BASE_URL}css/main.css">
<link rel="stylesheet" type="text/css" href="{$BASE_URL}css/font-roboto.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/js/modernizr-all.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/js/ink-all.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/holder.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/autoload.min.js"></script>
</head>
<body class="ink-drawer">
<nav class="left-drawer ink-navigation">
  <ul class="menu vertical black">
    <li id="heading-pesquisa" class="heading">
      <span>Pesquisa</span>
    </li>
    <li class="search">
      <form action="{$BASE_URL}pages/pesquisa/pergunta.php" method="GET" class="docsearch" role="search">
        {if $FORM_VALUES.query}
        <input type="search" class="search-field" name="query"
               autocomplete="off" tabindex="-1"
              value="{$FORM_VALUES.query}">
        {else}
        <input type="search" class="search-field" name="query"
               autocomplete="off" tabindex="-1">
        {/if}
        <span class="fa fa-search"></span>
      </form>
    </li>
    {block name=navigation}
    {/block}
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
    {if $ADMINISTRADOR}
    <li>
      <a href="{$BASE_URL}pages/admin/homepage.php">
        <i class="fa fa-fw fa-key"></i>
        <span>Administração</span>
      </a>
    </li>
    {/if}
    <li>
      <a href="{$BASE_URL}pages/utilizador/profile.php#questions">
        <i class="fa fa-fw fa-cog"></i>
        <span>Gerir publicações</span>
      </a>
    </li>
    {if $MODERADOR}
    <li>
      <a href="{$BASE_URL}pages/utilizador/report.php">
        <i class="fa fa-fw fa-cog"></i>
        <span>Gerir reports</span>
      </a>
    </li>
    {/if}
    <li>
      <a href="{$BASE_URL}actions/utilizador/logout.php">
        <i class="fa fa-fw fa-door"></i>
        <span>Terminar sessão</span>
      </a>
    </li>
    {/if}
  </ul>
</nav>
<header id="header-container">
  <nav id="header-menu" class="ink-navigation">
    <ul class="menu horizontal black hide-all show-small show-tiny">
    {if $USERNAME}
      {include file='common/navigation-user.tpl'}
    {else}
      {include file='common/navigation-guest.tpl'}
    {/if}
    </ul>
  </nav>
</header>
{block name=content}
{/block}
{block name=footer}
<script>
$(function() {
  $("#footer-links").hide();
  $("#footer").hover(function() {
    $("#footer-links").stop(!0, !0).slideToggle("fast");
  })
});
</script>
<footer id="footer" class="medium fixed horizontal-padding">
  <ul id="footer-links" class="unstyled medium inline quarter-vertical-space">
    <li><a href="{$BASE_URL}pages/about.php">About</a></li>
    <li><a href="{$BASE_URL}pages/sitemap.php">Sitemap</a></li>
    <li><a href="{$BASE_URL}pages/contacts.php">Contacts</a></li>
  </ul>
  <p class="note medium no-margin half-vertical-padding">
    <i class="fa fa-copyright"></i>
    <span>2016 KnowUP! - Collaborative Q&A</span>
  </p>
</footer>
{/block}
</body>
</html>