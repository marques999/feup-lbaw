{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid xlarge-60 large-70 medium-90 all-100">
  <form action="{$BASE_URL}actions/utilizador/update.php"
        class="ink-form ink-formvalidator quarter-vertical-padding"
        method="post"
        data-lang="pt_PT">
    {include file='utilizador/update-formulario.tpl'}
  </form>
</div>
{/block}
{block name=footer}
{/block}