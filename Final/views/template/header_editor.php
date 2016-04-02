<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="HandheldFriendly" content="True">
<meta name="MobileOptimized" content="320">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0">
<title>KnowUP! - Collaborative Q&amp;A</title>
<link rel="shortcut icon" href="img/favicon.ico">
<link rel="stylesheet" type="text/css" href="../css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="../css/font-roboto.css">
<link rel="stylesheet" type="text/css" href="../css/ink.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<script type="text/javascript" src="js/holder.min.js"></script>
<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="js/modernizr-2.8.3.min.js"></script>
<script type="text/javascript" src="js/ink-all.min.js"></script>
<script type="text/javascript" src="js/autoload.min.js"></script>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
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

  CKEDITOR.replace('text');
});
</script>
</head>