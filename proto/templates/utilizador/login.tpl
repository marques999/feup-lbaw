{extends file='other/header.tpl'}
{block name=content}
<form action="{$BASE_URL}actions/utilizador/login.php"
      class="ink-form ink-formvalidator"
      method="post"
      data-lang="pt_PT">
	{include file='utilizador/login-formulario.tpl'}
</form>
{/block}