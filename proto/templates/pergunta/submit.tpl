{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer xlarge-60 large-70 medium-90 all-100">
  <form action="{$BASE_URL}actions/pergunta/submit.php" method="post" class="ink-form ink-formvalidator quarter-vertical-padding" data-lang="pt_PT">
    <fieldset>
      <legend class="quarter-vertical-padding quarter-vertical-space slab align-center">
        <i class="fa fa-pencil fa-fw"></i>
        <span>Nova Pergunta</span>
      </legend>
      {include file='common/messages.tpl'}
      <input type="hidden" name="idPergunta" id="idPergunta" value="{$pergunta.idpergunta}">
      {include file='pergunta/submit-formulario.tpl'}
    </fieldset>
  </form>
</div>
{/block}