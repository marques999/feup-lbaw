<form action="{$BASE_URL}actions/instituicao/update.php" method="post" class="ink-form ink-formvalidator all-100 xlarge-60 large-75 medium-85 push-center" data-lang="pt_PT">
{include file='common/messages.tpl'}
<input type="hidden" id="idInstituicao" name="idInstituicao" value="{$instituicao.idinstituicao}">
<div class="control-group half-gutters required">
  <label for="nome" class="condensed">
    <strong>Nome</strong>
  </label>
  <div class="control medium append-symbol">
    <span>
      <input id="nome" name="nome" type="text" value="{$instituicao.nome}" data-rules="required|text[true,false]">
      <i class="fa fa-institution"></i>
    </span>
  </div>
</div>
<div class="column-group half-gutters">
  <div class="control-group all-60 required">
    <label for="sigla" class="condensed">
      <strong>Sigla</strong>
    </label>
    <div class="control medium">
      <input type="text" id="sigla" name="sigla" value="{$instituicao.sigla}" data-rules="required|alpha">
    </div>
  </div>
  <div class="control-group all-40">
    <label for="contacto" class="condensed">
      <strong>Contacto</strong>
    </label>
    <div class="control medium">
      <input type="text" id="contacto" name="contacto" value="{$instituicao.contacto}" data-rules="required|phone[PT]">
    </div>
  </div>
</div>
<div class="control-group half-gutters">
  <label for="morada" class="condensed">
    <strong>Morada</strong>
  </label>
  <div class="control medium append-symbol">
    <span>
      <input type="text" id="morada" name="morada" value="{$instituicao.morada}" data-rules="required|text[true,true]">
      <i class="fa fa-envelope-o"></i>
    </span>
  </div>
</div>
<div class="control-group half-gutters">
  <label for="website" class="condensed">
    <strong>Website</strong>
  </label>
  <div class="control medium append-symbol">
    <span>
      <input type="text" id="website" name="website" value="{$instituicao.website}" data-rules="required|url[true]">
      <i class="fa fa-globe"></i>
    </span>
  </div>
</div>
<hr class="no-margin half-vertical-padding">


<!-- FORM: associar categorias -->
<div class="control-group column-group half-gutters">
    <label for="Categorias" class="align-right all-15 small-20 tiny-20 condensed">
      <strong>Categorias:</strong>
    </label>
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
<div class="control-group push-right">
  <div class="button-group">
    <button class="ink-button green medium" type="submit">
      <i class="fa fa-check"></i>
      <span>Submeter</span>
    </button>
    <button class="ink-button red medium" type="reset">
      <i class="fa fa-close"></i>
      <span>Limpar</span>
    </button>
  </div>
</div>
</form>