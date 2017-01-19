{if $USERID and $USERID neq $pergunta.idutilizador and $pergunta.ativa}
<p class="no-margin half-top-padding"><strong>Responder</strong></p>
<hr class="quarter-vertical-space">
<section id="reply-form" class="push-center half-vertical-space">
  <form action="{$BASE_URL}actions/resposta/submit.php" method="POST" class="ink-form ink-formvalidator">
    <input type="hidden" name="idPergunta" id="idPergunta" value="{$pergunta.idpergunta}">
    <div class="control-group column-group quarter-gutters">
      <div class="control">
        <textarea name="descricao" id="descricao" rows="8" cols="60">
        {if $FORM_VALUES.descricao}
          {$FORM_VALUES.descricao}
        {/if}
        </textarea>
      </div>
    </div>
    <div class="control-group push-right">
      <div class="button-group">
        <button class="ink-button medium green" type="submit">
          <i class="fa fa-check"></i>
          <span>Submeter</span>
        </button>
        <button class="ink-button medium red" onclick="history.go(-1)">
          <i class="fa fa-close"></i>
          <span>Cancelar</span>
        </button>
      </div>
    </div>
  </form>
</section>
{include file='common/editor.tpl'}
{/if}