<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="HandheldFriendly" content="True">
<meta name="MobileOptimized" content="320">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0">
<title>KnowUP! - Collaborative Q&A</title>
<link rel="shortcut icon" href="{$BASE_URL}images/favicon.ico">
<link rel="stylesheet" type="text/css" href="{$BASE_URL}css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="{$BASE_URL}css/font-roboto.css">
<link rel="stylesheet" type="text/css" href="{$BASE_URL}css/ink.css">
<link rel="stylesheet" type="text/css" href="{$BASE_URL}css/other.css">
<script type="text/javascript" src="{$BASE_URL}javascript/modernizr-2.8.3.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/ink-all.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/autoload.min.js"></script>
</head>
<body>
  <div id="responsive-bg">
    <img src="{$BASE_URL}images/assets/background.png" alt="">
  </div>
  <div class="ink-grid push-center overlay half-vertical-padding xlarge-50 large-60 medium-80 all-100">
    <div class="column double-horizontal-padding half-vertical-space">
      <a href="{$BASE_URL}pages/index.php">
        <img src="{$BASE_URL}images/assets/header.png" alt="">
      </a>
    </div>
  <h3 class="slab align-center">Administração</h3>
  <hr>
  <div class="column-group hide-small hide-tiny half-vertical-space">
    <a href="{$BASE_URL}pages/admin/categorias.php">
      <div class="column ink-button black all-33">
        <div class="huge-button">
          <i class="fa fa-database"></i>
        </div>
        <h4 class="condensed half-vertical-space">Gerir Categorias</h4>
      </div>
    </a>
    <a href="{$BASE_URL}pages/admin/estatisticas.php">
      <div class="column ink-button black all-33">
        <div class="huge-button">
          <i class="fa fa-line-chart"></i>
        </div>
        <h4 class="condensed half-vertical-space">Estatísticas</h4>
      </div>
    </a>
    <a href="{$BASE_URL}pages/admin/utilizadores.php">
      <div class="column ink-button black all-33">
        <div class="huge-button">
          <i class="fa fa-users"></i>
        </div>
          <h4 class="condensed half-vertical-space">Gerir Utilizadores</h4>
      </div>
    </a>
  </div>
  <div class="column-group hide-all show-small show-tiny half-vertical-space">
    <a href="{$BASE_URL}pages/admin/categorias.php">
      <div class="column all-100 ink-button black">
        <div class="huge-button all-25 push-left">
          <i class="fa fa-institution"></i>
        </div>
        <h2 class="condensed all-75 vertical-space">Gerir Categorias</h2>
      </div>
    </a>
    <a href="{$BASE_URL}pages/admin/estatisticas.php">
      <div class="column all-100 ink-button black">
        <div class="huge-button all-25 push-left">
          <i class="fa fa-line-chart"></i>
        </div>
        <h2 class="condensed all-75 vertical-space">Estatísticas</h2>
      </div>
    </a>
    <a href="{$BASE_URL}pages/admin/utilizadores.php">
      <div class="column all-100 ink-button black">
        <div class="huge-button all-25 push-left">
          <i class="fa fa-users"></i>
        </div>
        <h2 class="condensed all-75 vertical-space">Gerir Utilizadores</h2>
      </div>
    </a>
  </div>
  <hr>
  <h4 class="condensed align-center no-margin">Utilizador:
    <a href="{$BASE_URL}pages/utilizador/profile.php">{$USERNAME}</a>
  </h4>
  </div>
</body>
</html>