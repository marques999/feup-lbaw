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
<script type="text/javascript" src="{$BASE_URL}javascript/holder.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/modernizr-2.8.3.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/ink-all.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/nano.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/autoload.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}ckeditor/ckeditor.js"></script>
{literal}
<script>
$(function() {
  CKEDITOR.editorConfig = function(config) {
    config.language = 'pt';
    config.height = 400;
    config.toolbarGroups = [
      {name: 'clipboard', groups: ['clipboard', 'undo']},
      {name: 'editing', groups: ['find', 'selection', 'spellchecker', 'editing']},
      {name: 'basicstyles', groups: ['basicstyles', 'cleanup']},
      {name: 'links', groups: ['links']},
      {name: 'insert', groups: ['insert']},
      {name: 'forms', groups: ['forms']},
      {name: 'tools', groups: ['tools']},
      {name: 'document', groups: ['mode', 'document', 'doctools']},
      {name: 'others', groups: ['others']},
      {name: 'paragraph', groups: ['list', 'indent', 'blocks', 'align', 'bidi', 'paragraph']},
      {name: 'styles', groups: ['styles']},
      {name: 'colors', groups: ['colors']},
      {name: 'about', groups: ['about']}
    ];
    config.removeButtons = 'Underline,Subscript,Superscript,PasteFromWord,PasteText,About,Outdent,Indent,Maximize,Source,Anchor,Scayt';
  };
  CKEDITOR.replace('descricao');
});
</script>
{/literal}
</head>
<body>
  {block name=navigation}
  {include file='common/navigation.tpl'}
  {/block}
  {block name=content}
  {/block}
  {block name=footer}
  <script>
  $(function() {
    $("ul#footer-links").hide();
    $("#footer").hover(function() {
      $("ul#footer-links").stop(!0, !0).slideToggle("fast");
    })
  });
  </script>
  <footer id="footer" class="clearfix medium fixed horizontal-padding">
    <ul id="footer-links" class="unstyled medium inline quarter-vertical-space">
      <li><a href="about.php">About</a></li>
      <li><a href="sitemap.php">Sitemap</a></li>
      <li><a href="contacts.php">Contacts</a></li>
    </ul>
    <p class="note medium no-margin half-vertical-padding">
       <i class="fa fa-copyright"></i>
       <span>2016 KnowUp! - Collaborative Q&A</span>
    </p>
  </footer>
  {/block}
</body>
</html>