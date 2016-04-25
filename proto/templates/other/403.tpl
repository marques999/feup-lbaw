{extends file='other/message.tpl'}
{block name='content'}
<div class="align-center half-vertical-padding">
  <h1 class="slab">Acesso negado</h1>
  <p class="no-margin half-vertical-padding">Não tem permissões para visualizar esta página!</p>
  <p>Por favor <a href="{$BASE_URL}pages/utilizador/login.php">inicie sessão</a> com uma conta de administrador.</p>
</div>
{/block}