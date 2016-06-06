{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer">
  <form action="{$BASE_URL}actions/utilizador/update.php"
        class="ink-form ink-formvalidator xlarge-60 large-70 medium-90 all-100 push-center quarter-vertical-padding"
        enctype="multipart/form-data" method="post" data-lang="pt_PT">
    {include file='utilizador/update-formulario.tpl'}
  </form>
</div>
{/block}
{block name=footer}
{/block}