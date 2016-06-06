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

function printQuestions(jsonObject) {

  var domElement = $('div#content').empty();

  if (jsonObject.length < 1) {
    domElement.append('<p class="condensed">Não foram encontrados quaisquer resultados.</p>');
  }

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

$(function() {
  setCallback(fetchQuestions);
  setDefaults('year', 'rank', 'descending');
  registerFilter($('li.filter-option'));
  registerSort($('li.sort-option'));
  executeCallback();
});