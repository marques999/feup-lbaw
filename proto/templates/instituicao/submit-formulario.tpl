<input type="hidden" id="idInstituicao" name="idInstituicao" value="{$instituicao.idinstituicao}">
<div class="control-group half-gutters required">
  <label for="nome" class="condensed">
    <strong>Nome</strong>
  </label>
  <div class="control medium">
    {if $FORM_VALUES.nome}
    <input type="text" id="nome" name="nome"
           value="{$FORM_VALUES.nome}"
           data-rules="required|text[true,false]">
    {else}
    <input type="text" id="nome" name="nome"
           data-rules="required|text[true,false]">
    {/if}
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
           data-rules="required|url[true]">
    {/if}
    <i class="fa fa-globe"></i>
    </span>
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