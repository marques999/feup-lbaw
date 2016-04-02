<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="HandheldFriendly" content="True">
<meta name="MobileOptimized" content="320">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0">
<title>KnowUP! - Collaborative Q&A</title>
<link rel="shortcut icon" href="../img/favicon.ico">
<link rel="stylesheet" type="text/css" href="css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="css/font-roboto.css">
<link rel="stylesheet" type="text/css" href="css/ink.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script type="text/javascript" src="js/chart.min.js"></script>
<script type="text/javascript" src="js/chartHelper.js"></script>
<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
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

$(function() {
  var myPieChart1 = generateQuestionsChart("myChart", userDatabase);
  var myPieChart2 = generateAnswersChart("myChart2", userDatabase);
  var myPieChart3 = generateLoginChat("myChart3", userDatabase);
  var myPieChart4 = generateLineChart("myChart4", subjectDatabase);
  var myPieChart5 = generateLineChart("myChart5", schoolDatabase);
  var pillsDate = $("#pills-date li");
  pillsDate.click(function(){
    pillsDate.removeClass("active");
    $(this).addClass("active");
  });
});
</script>
</head>


<!-- PÁGINA -->
<body>
<div class="ink-grid push-center">


<!-- NAVEGAÇÃO -->
<div class="column-group half-vertical-space">
  <div class="column all-20 large-25 medium-33 small-50 tiny-50">
    <a href="index_user.html">
      <img src="img/header-256px.png" alt="">
    </a>
  </div>
  <div class="column all-80 large-75 medium-66 small-50 tiny-50 quarter-padding">
    <h5 class="quarter-vertical-space">KnowUP! - Collaborative Q&A</h5>
    <p>segunda-feira, 21 de Março de 2016</p>
  </div>
  <div class="message all-100 half-bottom-space">
   <h5 class="slab no-margin">
      <i class="fa-cog fa"></i>
      <a href="manage.html" class="black">Administração</a>
      <strong>&gt;</strong>
      <a href="view_stats.html" class="black">Estatísticas</a>
    </h5>
  </div>
  <nav class="ink-navigation medium push-right">
    <ul id="pills-date" class="pagination pills">
      <li><a>agora</a></li>
      <li class="active"><a>esta semana</a></li>
      <li><a>este mês</a></li>
      <li><a>último trimestre</a></li>
      <li><a>último semestre</a></li>
    </ul>
  </nav>
</div>


<!-- MAIS PERGUNTAS -->
<div class="column-group half-gutters">
<div class="column all-33 medium-50 small-100 tiny-100">
  <h4 class="align-center condensed">Mais perguntas (esta semana)</h4>
  <canvas id="myChart" width="500" height="400"></canvas>
  <table class="ink-table quarter-vertical-space alternating hover">
    <thead>
      <tr>
        <th style="width:40%">Utilizador</th>
        <th style="width:20%">#Perguntas</th>
        <th style="width:40%">Última Pergunta</th>
      </tr>
    </thead>
    <tbody class="align-center">
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">marques999</a>
        </td>
        <td>20</td>
        <td>
          <small>18/03/2016 12:37</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">darklord</a>
        </td>
        <td>7</td>
        <td>
          <small>20/03/2016 14:42</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">mellus</a>
        </td>
        <td>5</td>
        <td>
          <small>17/03/2016 08:14</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">admin</a>
        </td>
        <td>3</td>
        <td>
          <small>15/03/2016 02:20</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">misterioso</a>
        </td>
        <td>1</td>
        <td>
          <small>15/03/2016 21:19</small>
        </td>
      </tr>
    </tbody>
  </table>
</div>


<!-- MAIS RESPOSTAS -->
<div class="column all-33 medium-50 small-100 tiny-100">
  <h4 class="align-center condensed">Mais respostas (esta semana)</h4>
  <canvas id="myChart2" width="500" height="400"></canvas>
  <table class="ink-table quarter-vertical-space alternating hover">
    <thead>
      <tr>
        <th style="width:40%">Utilizador</th>
        <th style="width:20%">#Respostas</th>
        <th style="width:40%">Última Resposta</th>
      </tr>
    </thead>
    <tbody class="align-center">
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">mellus</a>
        </td>
        <td>9</td>
        <td>
          <small>20/03/2016 15:59</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">misterioso</a>
        </td>
        <td>5</td>
        <td>
          <small>17/03/2016 11:31</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">darklord</a>
        </td>
        <td>4</td>
        <td>
          <small>15/03/2016 03:02</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">marques999</a>
        </td>
        <td>2</td>
        <td>
          <small>16/03/2016 23:40</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">admin</a>
        </td>
        <td>2</td>
        <td>
          <small>19/03/2016 21:08</small>
        </td>
      </tr>
    </tbody>
  </table>
</div>


<!-- MAIS ACTIVOS -->
<div class="column all-33 medium-100 small-100 tiny-100">
  <h4 class="align-center condensed">Mais activos (esta semana)</h4>
  <canvas id="myChart3" width="500" height="400"></canvas>
  <table class="ink-table quarter-vertical-space alternating hover">
    <thead>
      <tr>
        <th style="width:40%">Utilizador</th>
        <th style="width:20%">#Sessões</th>
        <th style="width:40%">Última Sessão</th>
      </tr>
    </thead>
    <tbody class="align-center">
      <tr>
        <td class="align-left medium">
          <i class="fa fa-user"></i>
          <a href="view_profile.html">misterioso</a>
        </td>
        <td>41</td>
        <td>
          <small>20/03/2016 23:59</small>
        </td>
      </tr>
    <tr>
      <td class="align-left medium">
        <i class="fa fa-user"></i>
        <a href="view_profile.html">marques999</a>
      </td>
      <td>20</td>
      <td>
        <small>19/03/2016 07:54</small>
      </td>
    </tr>
    <tr>
      <td class="align-left medium">
        <i class="fa fa-user"></i>
        <a href="view_profile.html">darklord</a>
      </td>
      <td>7</td>
      <td>
        <small>18/03/2016 14:22</small>
      </td>
    </tr>
    <tr>
      <td class="align-left medium">
        <i class="fa fa-user"></i>
        <a href="view_profile.html">mellus</a>
      </td>
      <td>5</td>
      <td>
        <small>16/03/2016 19:02</small>
      </td>
    </tr>
    <tr>
      <td class="align-left medium">
        <i class="fa fa-user"></i>
        <a href="view_profile.html">admin</a>
      </td>
      <td>3</td>
      <td>
        <small>18/03/2016 11:46</small>
      </td>
    </tr>
  </tbody>
  </table>
</div>


<!-- CATEGORIAS POPULARES -->
<div class="column all-50 small-100 tiny-100 half-vertical-space">
  <h4 class="align-center condensed">Categorias populares</h4>
  <canvas id="myChart4" width="400" height="200"></canvas>
  <table class="ink-table quarter-vertical-space alternating hover">
    <thead>
      <tr>
        <th style="width:35%">Categoria</th>
        <th style="width:15%">#Perguntas</th>
        <th style="width:40%">Última Pergunta</th>
      </tr>
    </thead>
    <tbody class="align-center">
      <tr>
        <td class="align-left medium">
          <a href="list_questions.html">Geografia</a>
        </td>
        <td>24</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>sábado, 19/03/2016 10:10</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <a href="list_questions.html">Neurobiologia</a>
        </td>
        <td>13</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>sábado, 19/03/2016 12:55</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <a href="list_questions.html">Política</a>
        </td>
        <td>8</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>terça-feira, 15/03/2016 18:48</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <a href="list_questions.html">Matemática</a>
        </td>
        <td>4</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>quinta-feira, 17/03/2016 13:07</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <a href="list_questions.html">Engenharia Informática</a>
        </td>
        <td>3</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>quarta-feira, 16/03/2016 20:28</small>
        </td>
      </tr>
    </tbody>
  </table>
</div>


<!-- INSTITUIÇÕES POPULARES -->
<div class="column all-50 small-100 tiny-100 half-vertical-space">
  <h4 class="align-center condensed">Instituições populares</h4>
  <canvas id="myChart5" width="400" height="200"></canvas>
  <table class="ink-table quarter-vertical-space alternating hover">
    <thead>
      <tr>
        <th style="width:30%">Instituição</th>
        <th style="width:20%">#Perguntas</th>
        <th style="width:50%">Última Pergunta</th>
      </tr>
    </thead>
    <tbody class="align-center">
      <tr>
        <td class="align-left medium">
          <i class="fa fa-institution"></i>
          <a href="hub.html">FDUP</a>
        </td>
        <td>95</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>domingo, 20/03/2016 02:29</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-institution"></i>
          <a href="hub.html">FMUP</a>
        </td>
        <td>91</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>sexta-feira, 18/03/2016 17:55</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-institution"></i>
          <a href="hub.html">FLUP</a>
        </td>
        <td>83</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>sábado, 19/03/2016 11:32</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-institution"></i>
          <a href="hub.html">FEUP</a>
        </td>
        <td>75</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>segunda-feira, 21/03/2016 17:55</small>
        </td>
      </tr>
      <tr>
        <td class="align-left medium">
          <i class="fa fa-institution"></i>
          <a href="hub.html">FCUP</a>
        </td>
        <td>67</td>
        <td class="medium">
          <a class="black" href="view_question.html">ver pergunta</a>
          <i class="fa fa-external-link"></i>
          <br>
          <small>quarta-feira, 16/03/2016 12:24</small>
        </td>
      </tr>
    </tbody>
  </table>
</div>
</div>
<?
  require_once(__DIR__ . '/template/footer-empty.php')
?>