/*
 * $(document.ready)
 */
$(function(){
  $.ajax({
    type: 'GET',
    contentType: 'application/json;charset=utf-8',
    url: 'https://pt.wikipedia.org/w/api.php',
    dataType: 'jsonp',
    data: {
      format: 'json',
      action: 'query',
      prop: 'extracts',
      exsentences: 2,
      exintro: '',
      explaintext: '',
      callback: 'fetchInformation',
      titles: $('#category-panel h4').text()
    }
  });
});

/*
 * fetchInformation(k)
 */
function fetchInformation(k) {
  var queryResults = k.query.pages;
  if (queryResults) {
    for (var currentEntry in queryResults) {
      var currentPage = queryResults[currentEntry].extract;
      if (currentPage) {
        $('#category-description').text(currentPage).append('\n<a class="black fw-700" href="https://pt.wikipedia.org/wiki/' + queryResults[currentEntry].title + '">ver mais <i class="fa fa-arrow-circle-right"></i></a>');
        return true;
      }
    }
  }
  $('#category-description').text("Nenhuma descrição disponível para esta categoria.");
  return false;
};