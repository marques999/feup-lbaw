{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer">
  <form action="{$BASE_URL}actions/utilizador/report.php"
        class="ink-form ink-formvalidator xlarge-60 large-70 medium-90 all-100 push-center quarter-vertical-padding"
        method="post" data-lang="pt_PT">
    {include file='report/submit-formulario.tpl'}
  </form>
</div>
{/block}