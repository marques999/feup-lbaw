<input type="hidden" id="idInstituicao" name="idInstituicao" value="{$instituicao.sigla}">
<div class="control-group half-gutters required">
  <label for="nome" class="condensed">
    <strong>Nome</strong>
  </label>
  <div class="control medium append-symbol">
    <span>
      {if $FORM_VALUES.nome}
      <input id="nome" name="nome" type="text"
             value="{$FORM_VALUES.nome}"
             data-rules="required|text[true,false]">
      {else}
      <input id="nome" name="nome" type="text"
             value="{$instituicao.nome}"
             data-rules="required|text[true,false]">
      {/if}
      <i class="fa fa-institution"></i>
    </span>
  </div>
</div>
<div class="column-group half-gutters">
  <div class="control-group all-40 required">
    <label for="sigla" class="condensed">
      <strong>Sigla</strong>
    </label>
    <div class="control medium">
      {if $FORM_VALUES.sigla}
      <input type="text" id="sigla" name="sigla"
             value="{$FORM_VALUES.sigla}"
             data-rules="required|alpha">
      {else}
      <input type="text" id="sigla" name="sigla"
            value="{$instituicao.sigla}"
            data-rules="required|alpha">
      {/if}
    </div>
  </div>
  <div class="control-group all-60">
    <label for="contacto" class="condensed">
      <strong>Contacto</strong>
    </label>
    <div class="control medium">
      {if $FORM_VALUES.contacto}
      <input type="text" id="contacto" name="contacto"
             value="{$FORM_VALUES.contacto}"
             data-rules="required|phone[PT]">
      {else}
      <input type="text" id="contacto" name="contacto"
             value="{$instituicao.contacto}"
             data-rules="required|phone[PT]">
      {/if}
    </div>
  </div>
</div>
<div class="control-group half-gutters">
  <label for="morada" class="condensed">
    <strong>Morada</strong>
  </label>
  <div class="control medium append-symbol">
    <span>
      {if $FORM_VALUES.morada}
      <input type="text" id="morada" name="morada"
             value="{$FORM_VALUES.morada}"
             data-rules="required|text[true,true]">
      {else}
      <input type="text" id="morada" name="morada"
             value="{$instituicao.morada}"
             data-rules="required|text[true,true]">
      {/if}
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
      {if $FORM_VALUES.website}
      <input type="text" id="website" name="website"
             value="{$FORM_VALUES.website}"
             data-rules="required|url[true]">
      {else}
      <input type="text" id="website" name="website"
             value="{$instituicao.website}"
             data-rules="required|url[true]">
      {/if}
      <i class="fa fa-globe"></i>
    </span>
  </div>
</div>
<div class="control-group half-gutters">
  <label for="avatar" class="condensed">
    <strong>Fotografia</strong>
  </label>
  <div class="control medium">
    <div class="input-file">
      <input name="avatar" id="avatar" type="file">
    </div>
  </div>
</div>
<hr class="no-margin half-vertical-padding">
<div class="control-group push-right">
  <div class="button-group">
    <button class="ink-button green medium" type="submit">
      <i class="fa fa-check"></i>
      <span>Submeter</span>
    </button>
    <button class="ink-button medium red" onclick="history.go(-1)" type="reset">
      <i class="fa fa-close"></i>
      <span>Cancelar</span>
    </button>
  </div>
</div>