<fieldset>
  <legend class="quarter-vertical-padding quarter-vertical-space slab align-center">
    <i class="fa fa-pencil fa-fw"></i>
    <span>Editar Pergunta:</span>
    <small>{$pergunta.titulo}</small>
  </legend>
  {include file='common/messages.tpl'}
  <input type="hidden" name="idPergunta" id="idPergunta" value="{$pergunta.idpergunta}">
  {include file='pergunta/submit-formulario.tpl'}
</fieldset>