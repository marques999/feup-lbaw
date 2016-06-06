function fetchUtilizadores() {
  $.getJSON("../../api/pesquisa/get_utilizadores.php", {
      query: lastQuery,
      filter: lastFilter,
      sort: lastSort,
      order: lastOrder
  }).done(function(jsonString) {
    printUtilizadores(jsonString);
    getCurrentFilter().addClass('active');
    getCurrentSort().addClass('active');
  });
};

var myTemplate = '<div class="message all-50"><img class="avatar-medium push-left quarter-padding"' +
                 'src="../../pages/avatar.php?id={idutilizador}" alt="{username}">' +
                 '<div class="half-horizontal-padding quarter-vertical-padding">' +
                 '<strong>{nomeutilizador}</strong>\n' +
                 '<small class="small">({username})</small>' +
                 '<p class="medium no-margin">{email}</p>' +
                 '<small>{datahora}</small>' +
                 '</div></div>';

function printUtilizadores(jsonObject) {

  var domElement = $('div#content').empty();

  if (jsonObject.length < 1) {
    domElement.append('<p class="condensed">Não foram encontrados quaisquer resultados.</p>');
  }

  for (var i = 0; i < jsonObject.length; i++) {

    var thisObject = jsonObject[i];

    if (!thisObject.removido) {
      thisObject['nomeutilizador'] = '<a href="../../pages/utilizador/profile.php?id='
            + thisObject['idutilizador']
            + '">'
            + thisObject['nomeutilizador']
            + '</a>';
    }

    domElement.append(nano(myTemplate, thisObject));
  }
}

$(function() {
  setCallback(fetchUtilizadores);
  setDefaults('all', 'rank', 'descending');
  registerFilter($('li.filter-option'));
  registerSort($('li.sort-option'));
  executeCallback();
});