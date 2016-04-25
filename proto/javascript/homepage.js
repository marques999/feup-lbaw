var lastFilter = 'filter-year';
var lastSort = 'sort-date';
var lastOrder = 'order-descending';

/*
 * fetchQuestions()
 */
function fetchQuestions() {
  $.getJSON("../api/pesquisa/get_perguntas.php", {
      sort: lastSort.substring(5, lastSort.length),
      filter: lastFilter.substring(7, lastFilter.length),
      order: lastOrder.substring(6, lastOrder.length)
  }).done(function(jsonString) {
    printQuestions(jsonString);
  });
};

/*
 * document.ready()
 */
$(function() {
  fetchQuestions();
  $('ul#sidebar-filter #' + lastFilter).addClass('active');
  $('ul#sidebar-sort #' + lastSort).addClass('active');
  $('ul#sidebar-order #' + lastOrder).addClass('active');
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
    domElement.append(nano('<div><h5 class="slab quarter-vertical-space"><a class="black" href="../pages/pergunta/view.php?id={idpergunta}">{titulo}</a></h5><div class="condensed author-panel quarter-vertical-space"><div><p class="no-margin"><a class="medium" href="../pages/utilizador/profile.php?id={idutilizador}">{nomeutilizador}</a>\n&bull;\n<small>{datahora}</small>\n&bull;\n<span class="medium">\n<strong>{numerorespostas}</strong>\nrespostas\n</span>\n&bull;\n<span class="medium"><strong class="positive-score">{pontuacao}</strong>\npontos</span></p></div></div><p class="medium truncate no-margin align-justify">{descricao}\n<a class="black fw-700" href="../pages/pergunta/view.php?id={idpergunta}">ver mais <i class="fa fa-arrow-circle-right"></i></a></p></div>', jsonObject[i]));
    if (i != jsonObject.length - 1) {
      domElement.append('<hr>');
    }
  }
};