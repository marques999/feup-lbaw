{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer">
  <form action="{$BASE_URL}actions/utilizador/password.php"
        class="ink-form ink-formvalidator xlarge-60 large-70 medium-90 all-100 push-center quarter-vertical-padding"
        method="post" data-lang="pt_PT">
    {include file='utilizador/password-formulario.tpl'}
  </form>
</div>
{/block}
{block name=footer}
{/block}