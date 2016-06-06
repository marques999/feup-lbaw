<fieldset>
  <legend class="quarter-vertical-padding quarter-vertical-space slab align-center">
    <i class="fa fa-user fa-fw"></i>
    <span>Alterar palavra-passe</span>
    <small>{$utilizador.username}</small>
  </legend>
  {include file='common/messages.tpl'}
  <input name="idUtilizador" id="idUtilizador" type="hidden" value="{$idUtilizador}">
  <div class="control-group half-gutters required">
    <label for="current_password" class="condensed">
      <strong>Palavra-passe antiga:</strong>
    </label>
    <div class="control medium">
      {if $FORM_VALUES.current_password}
      <input name="current_password" id="current_password"
             type="password" data-rules="required"
             value="{$FORM_VALUES.current_password}"
             placeholder="Por favor introduza a sua palavra-passe antiga...">
      {else}
      <input name="current_password" id="current_password"
             type="password" data-rules="required"
             placeholder="Por favor introduza a sua palavra-passe antiga...">
      {/if}
    </div>
  </div>
  <div class="control-group half-gutters required">
    <label for="new_password" class="condensed">
      <strong>Palavra-passe nova:</strong>
    </label>
    <div class="control medium">
      {if $FORM_VALUES.new_password}
      <input name="new_password" id="new_password"
             type="password" data-rules="required|min_length[8]"
             value="{$FORM_VALUES.new_password}"
             placeholder="Por favor introduza a sua nova palavra-passe...">
      {else}
      <input name="new_password" id="new_password"
             type="password" data-rules="required|min_length[8]"
             placeholder="Por favor introduza a sua nova palavra-passe...">
      {/if}
    </div>
  </div>
  <div class="control-group half-gutters required">
    <label for="confirm_password" class="condensed">
      <strong>Confirmar palavra-passe:</strong>
    </label>
    <div class="control medium">
      {if $FORM_VALUES.confirm_password}
      <input name="confirm_password" id="confirm_password"
             type="password" data-rules="required|min_length[8]"
             value="{$FORM_VALUES.confirm_password}"
             placeholder="Por favor confirme a sua nova palavra-passe...">
      {else}
      <input name="confirm_password" id="confirm_password"
             type="password" data-rules="required|min_length[8]"
             placeholder="Por favor confirme a sua nova palavra-passe...">
      {/if}
    </div>
  </div>
  <div class="control-group quarter-vertical-space push-right">
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