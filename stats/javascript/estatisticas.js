var lastFilter = 'year';

var utilizadorTemplate = '<tr><td class="align-left medium">\n<i class="fa fa-user"></i>\n';
	+ '{username}</td><td>'
	+ '{count}</td><td>'
	+ '<small>{datahora}</small></td></tr>';

var categoriaTemplate = '<tr>\n<td class="align-left medium">\n<i class="fa fa-cube fa-fw"></i>\n'
	+ '<a href="../../pages/categoria/view.php?id={idcategoria}">{nome}</a>\n'
	+ '</td>\n<td>{count}</td>\n<td class="medium">'
	+ '<a class="black" href="../../pages/pergunta/view.php?id={ultimapergunta}">ver pergunta</a>\n'
	+ '<i class="fa fa-external-link"></i>\n'
	+ '<br>\n<small>{datahora}</small>\n</td>\n</tr>';

var instituicaoTemplate = '<tr><td class="align-left medium">\n<i class="fa fa-institution fa-fw"></i>\n'
	+ '<a href="../../pages/instituicao/view.php?id={sigla}">{upper}</a>\n'
	+ '</td>\n<td>{count}</td>\n<td class="medium">'
	+ '<a class="black" href="../../pages/pergunta/view.php?id={ultimapergunta}">ver pergunta</a>\n'
	+ '<i class="fa fa-external-link"></i>\n'
	+ '<br>\n<small>{datahora}</small>\n</td>\n</tr>';

$(function(){
  getQuestions();
  getAnswers();
  getCategorias();
  getInstituicoes();
});

function appendUtilizador(domElement, jsonObject) {

  if (jsonObject.removido) {

	jsonObject[username] = '<a href="../../pages/utilizador/profile.php?id='
		+ jsonObject['idutilizador']
		+ '">'
		+ jsonObject['username'}
		+ '</a>';
  }

  domElement.append(nano(utilizadorTemplate, jsonObject));
};

function appendCategoria(domElement, jsonObject) {
  domElement.append(nano(categoriaTemplate, jsonObject));
};

function appendInstituicao(domElement, jsonObject) {
  domElement.append(nano(instituicaoTemplate, jsonObject));
};

function getCurrentFilter() {
   return $('#sidebar-filter #filter-' + lastFilter);
};

function getQuestions() {
  $.getJSON("../../api/admin/get_perguntas.php", {
      filter: lastFilter,
  }).done(function(jsonString) {
    printTable($('#tabela-perguntas'), jsonString);
    getCurrentFilter().addClass('active');
  });
};

function getAnswers() {
  $.getJSON("../../api/admin/get_respostas.php", {
      filter: lastFilter,
  }).done(function(jsonString) {
    printTable($('#tabela-respostas'), jsonString);
    getCurrentFilter().addClass('active');
  });
};

function getCategorias() {
  $.getJSON("../../api/admin/get_categorias.php", {
	filter: lastFilter,
  }).done(function(jsonString) {
    printInstituicoes($('#tabela-categorias'), jsonString);
    getCurrentFilter().addClass('active');
  });
};

function getInstituicoes() {
  $.getJSON("../../api/admin/get_instituicoes.php", {
      filter: lastFilter,
  }).done(function(jsonString) {
    printInstituicoes($('#tabela-instituicoes'), jsonString);
    getCurrentFilter().addClass('active');
  });
};

function getUtilizadores() {
  $.getJSON("../../api/admin/get_utilizadores.php", {
      filter: lastFilter,
  }).done(function(jsonString) {
    printTable($('#tabela-utilizadores'), jsonString);
    getCurrentFilter().addClass('active');
  });
};

function printTable(domElement, jsonObject) {

  domElement.empty();

  for (var i = 0; i < jsonObject.length; i++) {
      appendUtilizador(domElement, jsonObject[i]);
  }
};

function printCategorias(domElement, jsonObject) {

  domElement.empty();

  for (var i = 0; i < jsonObject.length; i++) {
      appendCategoria(domElement, jsonObject[i]);
  }
};

function printInstituicoes(domElement, jsonObject) {

  domElement.empty();

  for (var i = 0; i < jsonObject.length; i++) {
      appendInstituicao(domElement, jsonObject[i]);
  }
};

var chartColors = [
  "#DD1E2F",
  "#EBB035",
  "#06A2CB",
  "#218559",
  "#E2822D"
];

var highlightColors = [
  "#F23043",
  "#FFC34C",
  "#13B3DB",
  "#309B6B",
  "#F48C42"
];

var lineChartOptions = {
    scaleShowGridLines : true,
    scaleGridLineColor : "rgba(0,0,0,.05)",
    scaleGridLineWidth : 1,
    scaleShowHorizontalLines: true,
    scaleShowVerticalLines: true,
    bezierCurve : true,
    bezierCurveTension : 0.4,
    pointDot : true,
    pointDotRadius : 4,
    pointDotStrokeWidth : 1,
    pointHitDetectionRadius : 20,
    datasetStroke : true,
    datasetStrokeWidth : 2,
    datasetFill : true,
    responsive : true,
    legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].strokeColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"
};

var pieChartOptions = {
    segmentShowStroke : true,
    segmentStrokeColor : "#fff",
    segmentStrokeWidth : 2,
    percentageInnerCutout : 50,
    animationSteps : 100,
    animationEasing : "easeOutBounce",
    animateRotate : true,
    animateScale : true,
    responsive : true,
    legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
};

function generateQuestionsChart(canvasNode, userDatabase) {

  var questionsData = [];

  for (var i = 0; i < userDatabase.length; i++) {
    questionsData[i] = {
      value: userDatabase[i]["numberQuestions"],
      color: chartColors[i],
      highlight: highlightColors[i],
      label: userDatabase[i]["username"]
    };
  }

  return generatePieChart(canvasNode, questionsData);
};

function generateAnswersChart(canvasNode, userDatabase) {

  var answersData = [];

  for (var i = 0; i < userDatabase.length; i++) {
    answersData[i] = {
      value: userDatabase[i]["numberAnswers"],
      color: chartColors[i],
      highlight: highlightColors[i],
      label: userDatabase[i]["username"]
    };
  }

  return generatePieChart(canvasNode, answersData);
};

function generateLoginChat(canvasNode, userDatabase) {

  var loginData = [];

  for (var i = 0; i < userDatabase.length; i++) {
    loginData[i] = {
      value: userDatabase[i]["numberLogins"],
      color: chartColors[i],
      highlight: highlightColors[i],
      label: userDatabase[i]["username"]
    };
  }

  return generatePieChart(canvasNode, loginData);
}

var lineColors = [
  "86, 110, 164",
  "57, 82, 141",
  "69, 147, 147",
  "36, 62, 121",
  "43, 126, 126"
];

var schoolColors = [
  "153, 0, 0",
  "111, 168, 220",
  "255, 215, 0",
  "0, 0, 102",
  "205, 0, 0"
];

function generatePieChart(canvasNode, chartData) {
  return new Chart(document.getElementById(canvasNode).getContext("2d")).Pie(chartData,pieChartOptions);
};

function generateRgba(paletteIndex, alphaChannel) {
  return "rgba(" + lineColors[paletteIndex] + ", " + alphaChannel + ")";
};

/*
 * generatePieChart(canvasNode, userDatabase)
 */
function generateLineChart(canvasNode, userDatabase) {

  var dataSets = [];
  var i = 0;

  for (var subject in userDatabase) {
    dataSets[i] = {
      label: subject,
      fillColor: generateRgba(i, "0.2"),
      strokeColor: generateRgba(i, "1.0"),
      pointColor: generateRgba(i, "1.0"),
      pointStrokeColor: "#fff",
      pointHighlightFill: "#fff",
      pointHighlightStroke: generateRgba(i, "1.0"),
      data: userDatabase[subject]
    };

    i++;
  }

  return new Chart(document.getElementById(canvasNode).getContext("2d")).Line({
    labels: ["Outubro", "Novembro", "Dezembro", "Janeiro", "Fevereiro", "Março"],
    datasets: dataSets
  }, lineChartOptions);
};