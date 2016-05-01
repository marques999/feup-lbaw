{extends file='admin/common/pagina.tpl'}
{block name=navigation}
<div class="column-group half-top-space quarter-bottom-space">
  <div class="column all-20 large-25 medium-33 small-50 tiny-50">
    <a href="{$BASE_URL}pages/homepage.php">
      <img src="{$BASE_URL}images/assets/header-256px.png" alt="">
    </a>
  </div>
  <div class="column all-80 large-75 medium-66 small-50 tiny-50 quarter-padding">
    <h5 class="quarter-vertical-space">KnowUP! - Collaborative Q&A</h5>
    <p>{$smarty.now|date_format:"%A, %e %B %Y %H:%M"}</p>
  </div>
  <div class="message all-100 half-bottom-space">
    <h5 class="slab no-margin">
      <i class="fa fa-cog fa-fw"></i>
      <a class="black" href="{$BASE_URL}pages/admin/homepage.php">Administração</a>
      &nbsp;<i class="fa fa-angle-right"></i>&nbsp;
      <a class="black" href="{$BASE_URL}pages/admin/instituicoes.php">Gerir instituições</a>
      &nbsp;<i class="fa fa-angle-right"></i>&nbsp;
      <a class="black" href="{$BASE_URL}pages/instituicao/edit.php">Editar instituição</a>
    </h5>
  </div>
</div>
{/block}
{block name=content}

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
<form action="{$BASE_URL}actions/instituicao/update.php" method="post" class="ink-form ink-formvalidator half-vertical-padding medium all-100 xlarge-60 large-75 medium-85 push-center" data-lang="pt_PT">
    

<!-- FORM: identificador da instituição -->
<input type="hidden" id="idInstituicao" name="idInstituicao" value="{$instituicao.idinstituicao}">
    
    
<!-- FORM: nome da instituição -->
<div class="control-group required column-group half-gutters">
  <label for="nome" class="all-15 align-right">Nome:</label>
  <div class="control all-85 append-symbol">
    <span>
    <input type="text" id="nome" name="nome" value="{$instituicao.nome}" data-rules="required|text[true,false]">
    <i class="fa fa-envelope-o"></i>
    </span>
  </div>
</div>


<!-- FORM: sigla, contacto -->
<div class="control-group required column-group half-gutters">
  <label for="sigla" class="all-15 align-right">Sigla:</label>
  <div class="control all-30">
    <input type="text" id="sigla" name="sigla" value="{$instituicao.sigla}" data-rules="required|alpha">
  </div>
  <label for="contacto" class="all-10 align-right">Contacto:</label>
  <div class="control all-45">
    <input type="text" id="contacto" name="contacto" value="{$instituicao.contacto}" data-rules="required|phone[PT]">
  </div>
</div>


<!-- FORM: morada -->
<div class="control-group required column-group half-gutters">
  <label for="morada" class="all-15 align-right">Morada:</label>
  <div class="control all-85 append-symbol">
    <span>
    <input type="text" id="morada" name="morada" value="{$instituicao.morada}" data-rules="required|text[true,true]">
    <i class="fa fa-envelope-o"></i>
    </span>
  </div>
</div>


<!-- FORM: website -->
<div class="control-group required column-group half-gutters">
  <label for="website" class="all-15 align-right">Website:</label>
  <div class="control all-85 append-symbol">
    <span>
    <input type="text" id="website" name="website" value="{$instituicao.website}" data-rules="required|url[true]">
    <i class="fa fa-globe"></i>
    </span>
  </div>
</div>


<hr class="no-margin half-vertical-padding">


<!-- FORM: associar categorias -->
<div class="control-group column-group half-gutters">
  <label for="categorias" class="all-15 align-right">Categorias:</label>
    <div class="control all-70">
    <select id="categorias">
      {foreach $categorias as $this}
        <optgroup label="{$this.sigla|upper}">
        {foreach $this.json as $categoria}
          <option label="{$categoria.nome}" value="{$categoria.idcategoria}">{$categoria.nome}</option>
        {/foreach}
        </optgroup>
      {/foreach}
    </select>
  </div>
  <div class="control all-15 no-margin">
    <input id="associar-categoria" name="associar-categoria" type="button" class="ink-button" value="Adicionar">
  </div>
</div>


<!-- FORM: categorias da instituição -->
<div class="control-group column-group half-gutters">
  <label for="categorias-instituicao" class="all-15 align-right"></label>
  <div class="control all-70">
    <select id="categorias-instituicao" size="6">
    </select>
  </div>
  <div class="control all-15 no-margin">
    <input id="remover-categoria" name="remover-categoria" type="button" class="ink-button" value="Remover">
  </div>
</div>


<!-- FORM:button group -->
<div class="column control align-center all-100">
  <button class="ink-button" type="submit">Submeter</button>
  <button class="ink-button" onclick="history.go(-1)" type="reset">Cancelar</button>
</div>
</form>
</div>
{/block}