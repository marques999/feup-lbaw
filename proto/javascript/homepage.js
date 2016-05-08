var queryParameters = parseParameters();
var lastFilter = queryParameters['filter'] || 'year';
var lastSort = queryParameters['sort'] || 'date';
var lastOrder = queryParameters['order'] || 'descending';
var lastQuery = queryParameters['query'];

function locationHashChanged() {
  queryParameters = parseParameters();
  lastFilter = queryParameters['filter'];
  lastSort = queryParameters['sort'];
  lastOrder = queryParameters['order'];
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
    newTarget += '&filter=' + lastFilter;
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
  $.getJSON("../api/pesquisa/get_perguntas.php", {
      sort: lastSort.substring(5, lastSort.length),
      filter: lastFilter.substring(7, lastFilter.length),
      order: lastOrder.substring(6, lastOrder.length)
  }, function(jsonString) {
    printQuestions(jsonString);
  });
};

/*
 * $(document.ready)
 */
$(function() {
  fetchQuestions();
  $('ul#sidebar-filter #' + lastFilter).addClass('active');
  $('ul#sidebar-sort #' + lastSort).addClass('active');
  $('ul#sidebar-order #' + lastOrder).addClass('active');
  //-------------------------------------------------------
  $('ul#sidebar-filter li').click(function() {
    event.preventDefault();
    var currentFilter = $(this).get(0).id;
    if (currentFilter !== lastFilter) {
      $('ul#sidebar-filter #' + lastFilter).removeClass('active');
      lastFilter = currentFilter;
      fetchQuestions();
      $(this).addClass('active');
    }
  });
  //-------------------------------------------------------
  $('ul#sidebar-sort li').click(function() {
    event.preventDefault();
    var currentSort = $(this).get(0).id;
    if (currentSort !== lastSort) {
      $('ul#sidebar-sort #' + lastSort).removeClass('active');
      lastSort = currentSort;
      fetchQuestions();
      $(this).addClass('active');
    }
  });
  //-------------------------------------------------------
  $('ul#sidebar-order li').click(function() {
    event.preventDefault();
    var currentOrder = $(this).get(0).id;
    if (currentOrder !== lastOrder) {
      $('ul#sidebar-order #' + lastOrder).removeClass('active');
      lastOrder = currentOrder;
      fetchQuestions();
      $(this).addClass('active');
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