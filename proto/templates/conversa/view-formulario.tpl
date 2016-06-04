{if $conversa.remetenteremovido or $conversa.destinatarioremovido}
<h5 class="slab">
  <span>Responder</span>
  <span class="push-right">
    <i class="fa fa-arrow-up fa-fw"></i>
  </span>
</h5>
<p class="condensed half-vertical-space">Não pode responder a esta conversa :(</p>
{else}
<form action="{$BASE_URL}actions/conversa/reply.php" method="post" class="ink-form">
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
  <div class="control-group">
    <div class="control">
      <textarea name="descricao" id="descricao" rows="8" cols="60">
      </textarea>
    </div>
  </div>
</form>
{/if}