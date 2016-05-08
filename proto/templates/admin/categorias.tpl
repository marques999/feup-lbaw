{extends file='admin/common/pagina.tpl'}
{block name=content}
{literal}
<script>
$(function()
{
  $('span.action-buttons').hide();
  $('a.delete-button').click(function()
  {
    apagarCategoria(
      +$(this).parent().data('target'), 
      $(this));
  });
  $('a.edit-button').click(function()
  {
    var myParent = $(this).parent();
    var idCategoria = +myParent.data('target');
    $.get('../../templates/categoria/edit.html', function(data){
      $('.ink-stacker').append(data);
    });
  });
  var messageBlock = $('li.message');
  messageBlock.mouseover(function()
  {
    $(this).children().next().stop(true).fadeIn('fast');
  });
  messageBlock.mouseleave(function()
  {
    $(this).children().next().stop(true).fadeOut('fast');
  });
  function apagarCategoria(thisId, domElement)
  {
    $.post("../../api/categoria/delete.php",
    {
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
</script>
{/literal}
<div class="column-group quarter-vertical-space ink-stacker">
{foreach $categorias as $categoria}
  {if ($categoria@index % $numberRows) eq 0}
  <div class="column all-25 small-50 tiny-100">
  <ul>
  {/if}
  <li class="message half-vertical-space">
    <a class="condensed black" href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a>
    <span class="action-buttons push-right" data-target="{$categoria.idcategoria}">
      <a class="black medium edit-button" id="#update-category"><i class="fa fa-pencil fa-fw"></i></a>
      <a class="black medium delete-button"><i class="fa fa-close fa-fw"></i></a>
    </span>
  </li>
  {if ($categoria@index % $numberRows) eq $numberRows - 1}
  </ul>
  </div>
  {/if}
{/foreach}
</div>
{/block}