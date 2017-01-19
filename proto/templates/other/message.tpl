<!DOCTYPE html>
<html lang="pt-PT">
<head>
<meta charset="utf-8">
<meta name="HandheldFriendly" content="True">
<meta name="MobileOptimized" content="320">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0">
<title>KnowUP! - Collaborative Q&A</title>
<link rel="shortcut icon" href="{$BASE_URL}images/favicon.ico">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/css/ink.min.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="{$BASE_URL}css/font-roboto.css">
<link rel="stylesheet" type="text/css" href="{$BASE_URL}css/other.css">
</head>
<body>
  <div id="responsive-bg">
    <img src="{$BASE_URL}images/assets/background.png" alt="">
  </div>
  <div class="ink-grid xlarge-50 large-60 medium-80 all-100 overlay top-padding push-center">
    <div class="column double-horizontal-padding">
      <a href="{$BASE_URL}pages/homepage.php">
        <img src="{$BASE_URL}images/assets/header.png" alt="">
      </a>
  </div>
  {block name=content}
  {/block}
</body>
</html>