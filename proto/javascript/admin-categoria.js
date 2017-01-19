$(function()
{
  $('span.action-buttons').hide();
  $('a.delete-button').click(function()
  {
    apagarCategoria(
      +$(this).parent().data('target'),
      $(this));
  });
  $('button#insert-button').click(function()
  {
    var nomeCategoria = prompt("Por favor introduza um nome para a nova categoria:");
    if (nomeCategoria == null || nomeCategoria == '')
    {
      return;
    }
    $.post("../../api/categoria/submit.php",
    {
      'nome': nomeCategoria
    },
    function(jsonResult)
    {
      if (+jsonResult)
      {
        window.location.reload();
      }
    });
  });
  $('a.edit-button').click(function()
  {
    var myParent = $(this).parent();
    var domElement = myParent.prev();
    var nomeCategoria = prompt("Por favor introduza um novo nome para esta categoria:", domElement.text());

    if (nomeCategoria == null || nomeCategoria == '')
    {
      return;
    }

    $.post("../../api/categoria/update.php",
    {
      'idCategoria' : myParent.data('target'),
      'nome': nomeCategoria
    },
    function(jsonResult)
    {
      if (+jsonResult)
      {
        domElement.text(nomeCategoria);
      }
    });
  });
  var messageBlock = $('div.message');
  messageBlock.mouseover(function()
  {
    var thisBlock = $(this);
    var actionButtons = thisBlock.find('.action-buttons');
    thisBlock.find('.category-information').hide(0, function()
    {
  	  actionButtons.stop(true).fadeIn('fast');
  	});
  });
  messageBlock.mouseleave(function()
  {
    var thisBlock = $(this);
  	var categoryInformation = thisBlock.find('.category-information');
    thisBlock.find('.action-buttons').stop(true).fadeOut(100, function()
    {
  		categoryInformation.show();
  	});
  });
  function apagarCategoria(thisId, domElement)
  {
    $.post("../../api/categoria/delete.php", {
      idCategoria: thisId
    },
    function(jsonString)
    {
      if (jsonString !== undefined && jsonString !== 'false')
      {
        var myParent = domElement.parent().parent();
        myParent.hide('fast', function()
        {
          myParent.remove();
        });
      }
    });
  };
});