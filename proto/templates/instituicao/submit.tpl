{extends file='admin/common/pagina.tpl'}
{block name=navigation}
<div class="column-group half-top-space quarter-bottom-space">
  {include file=instituicao/submit-navigation.tpl'}
</div>
{/block}
{block name=content}
{include file='common/messages.tpl'}
<form action="{$BASE_URL}actions/instituicao/submit.php"
      method="post"
      class="ink-form ink-formvalidator half-vertical-padding medium all-100 xlarge-60 large-75 medium-85 push-center"
      data-lang="pt_PT">
  {include file=instituicao/submit-formulario.tpl'}
</form>
{/block}