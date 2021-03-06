<fieldset>
  {include file='common/messages.tpl'}
  <legend class="quarter-vertical-padding quarter-vertical-space slab align-center">
    <span>
      <i class="fa fa-envelope fa-fw"></i>
      <span>Enviar mensagem:</span>
      <small>{$utilizador.username}</small>
    </span>
  </legend>
  <input name="destinatario" id="destinatario" type="hidden" value="{$utilizador.idutilizador}">
  <div class="column-group half-gutters">
    <div class="control-group all-50 required">
      <label for="nome-remetente" class="condensed">
        <strong>Remetente</strong>
      </label>
      <div class="control medium">
        <input name="nome-remetente" id="nome-remetente" type="text"
               value="{$USERNAME}" disabled>
      </div>
    </div>
    <div class="control-group all-50 required">
      <label for="nome-destinatario" class="condensed">
        <strong>Destinatário</strong>
      </label>
      <div class="control medium">
        <input name="nome-destinatario" id="nome-destinatario" type="text"
               value="{$utilizador.username}" disabled>
      </div>
    </div>
  </div>
    <div class="control-group required">
    <label for="titulo" class="condensed">
      <strong>Assunto</strong>
    </label>
    <div class="control medium">
      {if $FORM_VALUES.titulo}
      <input name="titulo" id="titulo" type="text"
             data-rules="required|text[true,true]"
             value="{$FORM_VALUES.titulo}"
             placeholder="Por favor introduza um assunto para esta mensagem...">
      {else}
      <input name="titulo" id="titulo" type="text"
             data-rules="required|text[true,true]"
             placeholder="Por favor introduza um assunto para esta mensagem...">
      {/if}
    </div>
  </div>
  <div class="control-group required">
    <label for="descricao" class="condensed">
      <strong>Mensagem</strong>
    </label>
    <div class="control medium">
      {if $FORM_VALUES.descricao}
      <textarea name="descricao" id="descricao" type="text"
                 data-rules="required|text[true,true]" rows="10"
                 placeholder="Por favor escreva aqui a sua mensagem...">
         {$FORM_VALUES.descricao}
      </textarea>
      {else}
      <textarea name="descricao" id="descricao" type="text"
                 data-rules="required|text[true,true]" rows="10"
                 placeholder="Por favor escreva aqui a sua mensagem...">
      </textarea>
      {/if}
    </div>
  </div>
  <div class="control-group push-right">
    <div class="button-group">
      <button class="ink-button medium green" type="submit">
        <i class="fa fa-check"></i>
        <span>Submeter</span>
      </button>
      <button class="ink-button medium red" onclick="history.go(-1)" type="reset">
        <i class="fa fa-close"></i>
        <span>Cancelar</span>
      </button>
    </div>
  </div>
</fieldset>