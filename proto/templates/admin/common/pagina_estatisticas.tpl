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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.1.1/Chart.min.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/autoload.min.js"></script>
<script>
var schoolDatabase = {
  "FEUP" : [ 69, 86, 91, 103, 46, 75 ],
  "FCUP" : [ 62, 98, 21, 50,  90, 67 ],
  "FMUP" : [ 70, 45, 27, 15,  32, 91 ],
  "FLUP" : [ 50, 87, 66, 55,  69, 83 ],
  "FDUP" : [ 105, 39, 17, 28, 65, 95 ]
};
var subjectDatabase = {
  "Política" : [ 7, 24, 15, 16, 25, 8],
  "Matemática" : [ 20, 12, 22, 11, 24, 4],
  "Neurobiologia" : [ 6, 23, 10, 4, 8, 13],
  "Engenharia Informática" : [ 26, 6, 15, 24, 14, 3],
  "Geografia" : [15, 3, 18, 26, 11, 24]
}
var userDatabase = [
  {
    username: "marques999",
    numberAnswers: 2,
    numberQuestions: 4,
    numberLogins: 20
  },
  {
    username: "miserioso",
    numberAnswers: 1,
    numberQuestions: 5,
    numberLogins: 41
  },
  {
    username: "mellus",
    numberAnswers: 9,
    numberQuestions: 3,
    numberLogins: 5
  },
  {
    username: "darklord",
    numberAnswers: 4,
    numberQuestions: 2,
    numberLogins: 7
  },
  {
    username: "admin",
    numberAnswers: 2,
    numberQuestions: 1,
    numberLogins: 3
  }
];
 var chartPerguntas;
  var chartRespostas;
   var myPieChart3;
    var chartCategorias;
     var chartInstituicoes;
$(function() {
  chartPerguntas = generateQuestionsChart("myChart", userDatabase);
  chartRespostas = generateAnswersChart("myChart2", userDatabase);
  myPieChart3 = generateLoginChat("myChart3", userDatabase);
  chartCategorias = generateLineChart("myChart4", subjectDatabase);
  chartInstituicoes = generateLineChart("myChart5", schoolDatabase);
  var pillsDate = $("#pills-date li");
  pillsDate.click(function(){
    pillsDate.removeClass("active");
    $(this).addClass("active");
  });
});
</script>
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