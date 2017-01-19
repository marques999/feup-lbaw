{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer">
  <form action="{$BASE_URL}actions/conversa/submit.php"
        class="ink-form ink-formvalidator quarter-vertical-padding xlarge-60 large-70 medium-90 all-100"
        method="post" data-lang="pt_PT">
    {include file='conversa/submit-formulario.tpl'}
  </form>
</div>
{/block}
{block name=footer}
{/block}