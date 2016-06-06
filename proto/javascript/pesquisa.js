var queryParameters = parseParameters();
var defaultCallback = null;
var defaultFilter = null;
var defaultSort = null;
var defaultOrder = null;
var lastFilter = queryParameters['filter'] || defaultFilter;
var lastSort = queryParameters['sort'] || defaultSort;
var lastOrder = queryParameters['order'] || defaultOrder;
var lastQuery = $_GET('query');

function locationHashChanged() {
  queryParameters = parseParameters();
  lastFilter = queryParameters['filter'] || defaultFilter;
  lastSort = queryParameters['sort'] || defaultSort;
  lastOrder = queryParameters['order'] || defaultOrder;
  lastQuery = $_GET('query');
  executeCallback();
};

function setCallback(myCallback) {
  defaultCallback = myCallback;
};

function setDefaults(myFilter, mySort, myOrder) {
  
  defaultFilter = myFilter;

  if (lastFilter == null) {
    lastFilter = myFilter;
  }
  
  defaltSort = mySort;

  if (lastSort == null) {
    lastSort = mySort;
  }  

  defaultOrder = myOrder;

  if (lastOrder == null) {
    lastOrder = myOrder;
  }
};

function executeCallback() {

  if (defaultCallback != null) {
    defaultCallback.call();
  }
};

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
};

function $_GET(variable) {

  var query = window.location.search.substring(1);
  var vars = query.split("&");

  for (var i=0;i<vars.length;i++) {

    var pair = vars[i].split("=");

    if (pair[0] == variable) {
      return pair[1];
    }
  }
};

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

function getCurrentSort() {
  return $('li.sort-' + lastSort + '-' + lastOrder);
};

function getCurrentFilter() {
  return $('li.filter-' + lastFilter);
};

function registerFilter(domElement) {

  domElement.click(function() {

    event.preventDefault();
    var currentFilter = $(this).data('filter');

    if (currentFilter !== lastFilter) {
      getCurrentFilter().removeClass('active');
      lastFilter = currentFilter;
      changeTarget();
    }
  });
};

function registerSort(domElement) {

  domElement.click(function() {

    event.preventDefault();
    var currentSort = $(this).data('sort');
    var currentOrder = $(this).data('order');

    if (currentSort !== lastSort || currentOrder !== lastOrder) {
      getCurrentSort().removeClass('active');
      lastSort = currentSort;
      lastOrder = currentOrder;
      changeTarget();
    }
  });
};