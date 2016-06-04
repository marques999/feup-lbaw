{extends file='admin/common/pagina.tpl'}
{block name=navigation}
  {include file=instituicao/update-navigation.tpl'}
{/block}
{block name=content}
{include file='common/messages.tpl'}
{include file='instituicao/update-formulario.tpl'}
<script>
$(function(){
  var listaCategorias = $('select#categorias');
  var categoriasInstituicao =  $('select#categorias-instituicao');
  var buttonAssociarCategoria = $('#associar-categoria');
  var buttonRemoverCategoria = $('#remover-categoria');
  $(buttonAssociarCategoria).click(function(){
    var selectedOption = $('#categorias option:selected');
    selectedOption.next().attr('selected', 'selected');
    categoriasInstituicao.append(selectedOption);
  });
  $(buttonRemoverCategoria).click(function(){
    listaCategorias.append($('#categorias-instituicao option:selected').remove());
  });
});
</script>
{/block}