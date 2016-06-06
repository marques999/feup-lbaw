$(function() {

  $('span.action-buttons').hide();
  $('a.delete-button').click(function() {
    apagarCategoria(
      +$(this).parent().data('target'),
      $(this));
  });
  $('a.edit-button').click(function() {

    var myParent = $(this).parent();
    var idCategoria = +myParent.data('target');

    $.get('../../templates/categoria/update.php?id=' + idCategoria, function(data) {
      $('.ink-stacker').append(data);
    });
  });

  var messageBlock = $('div.message');

  messageBlock.mouseover(function() {

    var thisBlock = $(this);
    var actionButtons = thisBlock.find('.action-buttons');

    thisBlock.find('.category-information').hide(0, function() {
  	  actionButtons.stop(true).fadeIn('fast');
  	});
  });

  messageBlock.mouseleave(function() {

    var thisBlock = $(this);
  	var categoryInformation = thisBlock.find('.category-information');

    thisBlock.find('.action-buttons').stop(true).fadeOut(100, function() {
  		categoryInformation.show();
  	});
  });

  function apagarCategoria(thisId, domElement) {

    $.post("../../api/categoria/delete.php", {
      idCategoria: thisId
    },
    function(jsonString) {

      if (jsonString !== undefined && jsonString !== 'false') {

        var myParent = domElement.parent().parent();

        myParent.hide('fast', function() {
          myParent.remove();
        });
      }
    });
  };
});