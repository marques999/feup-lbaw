var queryParameters = parseParameters();
var lastFilter = queryParameters['filter'] || 'year';
var lastSort = queryParameters['sort'] || 'date';
var lastOrder = queryParameters['order'] || 'descending';
var lastQuery = queryParameters['query'];

/*
 * locationHashChanged()
 */
function locationHashChanged() {
  queryParameters = parseParameters();
  lastFilter = queryParameters['filter'] || 'year';
  lastSort = queryParameters['sort'] || 'date';
  lastOrder = queryParameters['order'] || 'descending';
  lastQuery = queryParameters['query'];
  fetchQuestions();
}

window.onhashchange = locationHashChanged;

/*
 * parseParameters()
 */
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

/*
 * changeTarget()
 */
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

/*
 * fetchQuestions()
 */
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

/*
 * getCurrentSort()
 */
function getCurrentSort() {
  return $('#sidebar-sort #sort-' + lastSort + '-' + lastOrder);
};

/*
 * getCurrentFilter()
 */
function getCurrentFilter() {
  return $('#sidebar-filter #filter-' + lastFilter);
};

/*
 * $(document.ready)
 */
$(function() {
  fetchQuestions();
  getCurrentFilter().addClass('active');
  getCurrentSort().addClass('active');
  //-------------------------------------------------------
  $('#sidebar-filter li').click(function() {
    event.preventDefault();
    var currentFilter = $(this).get(0).id.split('-')[1];
    if (currentFilter !== lastFilter) {
      getCurrentFilter().removeClass('active');
      lastFilter = currentFilter;
      changeTarget();
    }
  });
  //-------------------------------------------------------
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

/*
 * printQuestions(jsonObject)
 */
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
      thisObject.badge = '<span class="ink-badge black small">\n<i class="fa fa-check"></i>\n<span>fechada</span>\n</span>';
    }

    if (thisObject.removido) {
      thisObject.linkautor = '<span class="medium">' + thisObject.nomeutilizador + '</span>';
    }
    else {
      thisObject.linkautor = '<a class="medium" href="../pages/utilizador/profile.php?id=' + thisObject.idutilizador + '">' + thisObject.nomeutilizador + '</a>';
    }

    domElement.append(nano('<div><h5 class="slab quarter-vertical-space"><a class="black" href="../pages/pergunta/view.php?id={idpergunta}">{titulo}</a>{badge}</h5><div class="condensed author-panel quarter-vertical-space"><div><p class="no-margin">{linkautor}\n&bull;\n<small>{datahora}</small>\n&bull;\n<span class="medium">\n<strong>{numerorespostas}</strong>\nrespostas\n</span>\n&bull;\n<span class="medium"><strong class="{scoretype}">{pontuacao}</strong>\npontos</span></p></div></div><p class="medium truncate no-margin align-justify">{descricao}\n<a class="black fw-700" href="../pages/pergunta/view.php?id={idpergunta}">ver mais <i class="fa fa-arrow-circle-right"></i></a></p></div>', thisObject));

    if (i != jsonObject.length - 1) {
      domElement.append('<hr>');
    }
  }
};

/*
 * printUtilizador(jsonObject)
 */
function printUtilizador(jsonObject) {

  var domElement = $('div#content').empty();

  for (var i = 0; i < jsonObject.length; i++) {

    var thisObject = jsonObject[i];

    domElement.append(nano('<div><h5 class="slab quarter-vertical-space"><a class="black" href="../pages/pergunta/view.php?id={idpergunta}">{titulo}</a>{badge}</h5><div class="condensed author-panel quarter-vertical-space"><div><p class="no-margin">{linkautor}\n&bull;\n<small>{datahora}</small>\n&bull;\n<span class="medium">\n<strong>{numerorespostas}</strong>\nrespostas\n</span>\n&bull;\n<span class="medium"><strong class="{scoretype}">{pontuacao}</strong>\npontos</span></p></div></div><p class="medium truncate no-margin align-justify">{descricao}\n<a class="black fw-700" href="../pages/pergunta/view.php?id={idpergunta}">ver mais <i class="fa fa-arrow-circle-right"></i></a></p></div>', thisObject));
  }
}