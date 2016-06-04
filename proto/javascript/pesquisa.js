var queryParameters = parseParameters();
var lastFilter = queryParameters['filter'] || 'year';
var lastSort = queryParameters['sort'] || 'date';
var lastOrder = queryParameters['order'] || 'descending';
var lastQuery = $_GET('query');

function locationHashChanged() {
  queryParameters = parseParameters();
  lastFilter = queryParameters['filter'] || 'year';
  lastSort = queryParameters['sort'] || 'date';
  lastOrder = queryParameters['order'] || 'descending';
  lastQuery = $_GET('query');
  fetchQuestions();
}

window.onhashchange = locationHashChanged;

function parseParameters() {

  var vars = {};
  var aURL = window.location.href;
  var hashes = aURL.slice(aURL.indexOf('#') + 1).split('&');

  for (var i = 0; i < hashes.length; i++) {

    var hash = hashes[i].split('=');

    if (hash.length > 1) {
      vars[hash[0]] = hash[1];
    }
    else {
      vars[hash[0]] = null;
    }
  }

  return vars;
}

function $_GET(variable) {

  var query = window.location.search.substring(1);
  var vars = query.split("&");

  for (var i=0;i<vars.length;i++) {

    var pair = vars[i].split("=");

    if (pair[0] == variable) {
      return pair[1];
    }
  }
}

function changeTarget() {

  var newTarget = '';
  var targetChanged = false;

  if (lastFilter != null) {
    newTarget += 'filter=' + lastFilter;
    targetChanged = true;
  }

  if (lastSort != null) {
    newTarget += '&sort=' + lastSort;
    targetChanged = true;
  }

  if (lastOrder != null) {
    newTarget += '&order=' + lastOrder;
    targetChanged = true;
  }

  if (targetChanged) {
    location.hash = newTarget;
  }
};

function fetchQuestions() {
  $.getJSON("../../api/pesquisa/get_perguntas.php", {
      query: lastQuery,
      filter: lastFilter,
      sort: lastSort,
      order: lastOrder
  }).done(function(jsonString) {
    printQuestions(jsonString);
    getCurrentFilter().addClass('active');
    getCurrentSort().addClass('active');
  });
};

function getCurrentSort() {
  return $('#sidebar-sort #sort-' + lastSort + '-' + lastOrder);
};

function getCurrentFilter() {
  return $('#sidebar-filter #filter-' + lastFilter);
};

$(function() {

  fetchQuestions();
  getCurrentFilter().addClass('active');
  getCurrentSort().addClass('active');

  $('#sidebar-filter li').click(function() {
    event.preventDefault();
    var currentFilter = $(this).get(0).id.split('-')[1];
    if (currentFilter !== lastFilter) {
      getCurrentFilter().removeClass('active');
      lastFilter = currentFilter;
      changeTarget();
    }
  });

  $('#sidebar-sort li').click(function() {
    event.preventDefault();
    var idArguments = $(this).get(0).id.split('-');
    var currentSort = idArguments[1];
    var currentOrder = idArguments[2];
    if (currentSort !== lastSort || currentOrder !== lastOrder) {
      getCurrentSort().removeClass('active');
      lastSort = currentSort;
      lastOrder = currentOrder;
      changeTarget();
    }
  });
});

function printQuestions(jsonObject) {

  var domElement = $('div#content').empty();

  for (var i = 0; i < jsonObject.length; i++) {

    var thisObject = jsonObject[i];

    if (thisObject.pontuacao > 0) {
      thisObject.scoretype = 'positive-score';
    }
    else if(thisObject.pontuacao < 0) {
      thisObject.scoretype = 'negative-score';
    }
    else {
      thisObject.scoretype = '';
    }

    if (thisObject.ativa) {
      thisObject.badge = '';
    }
    else {
      thisObject.badge = '<span class="small">\n<i class="fa fa-check"></i>\n<span>fechada</span>\n</span>';
    }

    if (thisObject.removido) {
      thisObject.linkautor = '<span class="medium">' + thisObject.nomeutilizador + '</span>';
    }
    else {
      thisObject.linkautor = '<a class="medium" href="../utilizador/profile.php?id=' + thisObject.idutilizador + '">' + thisObject.nomeutilizador + '</a>';
    }

    domElement.append(nano('<div><h5 class="slab quarter-vertical-space"><a class="black" href="../pergunta/view.php?id={idpergunta}">{titulo}</a>{badge}</h5><div class="condensed author-panel quarter-vertical-space"><div><p class="no-margin">{linkautor}\n&bull;\n<small>{datahora}</small>\n&bull;\n<span class="medium">\n<strong>{respostas}</strong>\nrespostas\n</span>\n&bull;\n<span class="medium"><strong class="{scoretype}">{pontuacao}</strong>\npontos</span></p></div></div><p class="medium truncate highlight no-margin align-justify">{descricao}\n<a class="black fw-700" href="../pergunta/view.php?id={idpergunta}">ver mais <i class="fa fa-arrow-circle-right"></i></a></p></div>', thisObject));

    if (i != jsonObject.length - 1) {
      domElement.append('<hr>');
    }
  }
};

function printUtilizador(jsonObject) {

  var domElement = $('div#content').empty();

  for (var i = 0; i < jsonObject.length; i++) {

    var thisObject = jsonObject[i];

    domElement.append(nano('<div><h5 class="slab quarter-vertical-space"><a class="black" href="../pergunta/view.php?id={idpergunta}">{titulo}</a>{badge}</h5><div class="condensed author-panel quarter-vertical-space"><div><p class="no-margin">{linkautor}\n&bull;\n<small>{datahora}</small>\n&bull;\n<span class="medium">\n<strong>{numerorespostas}</strong>\nrespostas\n</span>\n&bull;\n<span class="medium"><strong class="{scoretype}">{pontuacao}</strong>\npontos</span></p></div></div><p class="medium truncate no-margin align-justify">{descricao}\n<a class="black fw-700" href="../pages/pergunta/view.php?id={idpergunta}">ver mais <i class="fa fa-arrow-circle-right"></i></a></p></div>', thisObject));
  }
}