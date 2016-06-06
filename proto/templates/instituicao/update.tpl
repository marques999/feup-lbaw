{extends file='admin/pagina.tpl'}
{block name=navigation}
<div class="column-group half-top-space quarter-bottom-space">
  {include file='instituicao/update-navigation.tpl'}
</div>
{/block}
{block name=content}
<form action="{$BASE_URL}actions/instituicao/update.php"
      class="ink-form ink-formvalidator all-100 xlarge-60 large-75 medium-85 push-center"
      method="post" data-lang="pt_PT">
  {include file='instituicao/update-formulario.tpl'}
</form>
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