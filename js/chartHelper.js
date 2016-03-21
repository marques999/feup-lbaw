var chartColors = [
  "#F7464A",
  "#46BFBD",
  "#FDB45C",
  "#00B721"
];

var highlightColors = [
  "#FF5A5E",
  "#5AD3D1",
  "#FFC870",
  "#00E826"
];

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

function generatePieChart(canvasNode, chartData) {
	return new Chart(document.getElementById(canvasNode).getContext("2d")).Pie(chartData,pieChartOptions);
};