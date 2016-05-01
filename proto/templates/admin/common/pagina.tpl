<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="HandheldFriendly" content="True">
<meta name="MobileOptimized" content="320">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0">
<title>KnowUP! - Collaborative Q&A</title>
<link rel="shortcut icon" href="{$BASE_URL}images/favicon.ico">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/css/ink.min.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="{$BASE_URL}css/main.css">
<link rel="stylesheet" type="text/css" href="{$BASE_URL}css/font-roboto.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/js/modernizr-all.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/js/ink-all.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/autoload.min.js"></script>
</head>
<body>
<div class="ink-grid push-center">
  {block name=navigation}
  <div class="column-group half-top-space quarter-bottom-space">
    <div class="column all-20 large-25 medium-33 small-50 tiny-50">
      <a href="{$BASE_URL}pages/index.php">
        <img src="{$BASE_URL}images/assets/header-256px.png" alt="">
      </a>
    </div>
    <div class="column all-80 large-75 medium-66 small-50 tiny-50 quarter-padding">
      <h5 class="quarter-vertical-space">KnowUP! - Collaborative Q&A</h5>
      <p>{$smarty.now|date_format:"%A, %e %B %Y %H:%M"}</p>
    </div>
    <div class="message all-100 half-bottom-space">
      <h5 class="slab no-margin">
        <i class="fa fa-cog fa-fw"></i>
        <a class="black" href="{$BASE_URL}pages/admin/homepage.php">Administração</a>
        &nbsp;<i class="fa fa-angle-right"></i>&nbsp;
        <a class="black" href="{$smarty.server.REQUEST_URI}">{$titulo}</a>
     </h5>
    </div>
  </div>
  {/block}
  {include file='common/messages.tpl'}
  {block name=content}
  {/block}
</div>
</body>
</html>