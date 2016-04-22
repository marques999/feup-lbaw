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
<link rel="stylesheet" type="text/css" href="{$BASE_URL}css/main.css">
<script type="text/javascript" src="{$BASE_URL}javascript/modernizr-2.8.3.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/ink-all.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/autoload.min.js"></script>
</head>
<body>
<div class="ink-grid push-center">
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
        <i class="fa-cog fa"></i>
        <a href="{$BASE_URL}pages/admin/homepage.php" class="black">Administração</a>
        <strong>&gt;</strong>
        <a href="{$smarty.server.REQUEST_URI}" class="black">{$titulo}</a>
     </h5>
    </div>
  </div>
  {block name=content}
  {/block}
</div>
</body>
</html>