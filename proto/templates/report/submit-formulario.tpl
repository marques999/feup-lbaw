<fieldset>
  <legend class="quarter-vertical-padding quarter-vertical-space slab align-center">
    <span>
      <i class="fa fa-user fa-fw"></i>
      <span>Denunciar utilizador:</span>
      <small>{$utilizador.username}</small>
    </span>
  </legend>
  <input name="idUtilizador" id="idUtilizador"
         type="hidden" value="{$utilizador.idutilizador}">
  <div class="column-group half-gutters">
    <div class="control-group all-50 required">
      <label for="moderador" class="condensed">
        <strong>Moderador</strong>
      </label>
      <div class="control medium">
        <input name="moderador" id="moderador"
               type="text" value="{$USERNAME}" disabled>
      </div>
    </div>
    <div class="control-group all-50 required">
      <label for="utilizador-reportado" class="condensed">
        <strong>Utilizador</strong>
      </label>
      <div class="control medium">
        <input name="utilizador-reportado" id="utilizador-reportado"
               type="text" value="{$utilizador.username}" disabled>
      </div>
    </div>
  </div>
  <div class="control-group required">
    <label for="descricao" class="condensed">
      <strong>Mensagem</strong>
    </label>
    <div class="control medium">
       <textarea name="descricao" id="descricao" type="text"
                 data-rules="required|text[true,true]" rows="10"
                 placeholder="Por favor escreva um texto sucinto onde indique as razões pelas quais está a denunciar este utilizador.">
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
</fieldset>