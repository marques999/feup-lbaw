{if $conversa.remetenteremovido or $conversa.destinatarioremovido}
<h5 class="slab">Responder</h5>
<p class="condensed no-margin">Não pode responder a esta conversa :(</p>
{else}
<form action="{$BASE_URL}actions/conversa/reply.php" method="POST" class="ink-form ink-formvalidator">
  <h5 class="quarter-bottom-padding">
    <span class="slab no-margin">Responder</span>
    <span class="push-right condensed">
      <button class="ink-button green medium" type="submit">
        <i class="fa fa-check"></i>
        <span>Submeter</span>
      </button>
    </span>
  </h5>
  <input name="idConversa" id="idConversa" type="hidden" value="{$conversa.idconversa}">
  <div class="control-group required">
    <div class="control">
      <textarea name="descricao" id="descricao" rows="8" cols="60">
      {if $FORM_VALUES.descricao}
        {$FORM_VALUES.descricao}
      {/if}
      </textarea>
    </div>
  </div>
</form>
{/if}