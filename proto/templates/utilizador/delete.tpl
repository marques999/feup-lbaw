{extends file='other/header.tpl'}
{block name=content}
<div class="align-center">
  {include file='common/messages.tpl'}
  <h1 class="slab">Apagar Utilizador</h1>
  {if $USERNAME == $nomeUtilizador}
  <p>Tem a certeza que deseja eliminar a sua conta <strong>{$nomeUtilizador}</strong>?</p>
  {else}
  <p>Tem a certeza que deseja eliminar a conta <strong>{$nomeUtilizador}</strong>?</p>
  {/if}
  <p>
    <strong>ATENÇÃO:</strong>
    {if $USERNAME == $nomeUtilizador}
    <span>Todas as suas publicações serão apagadas automaticamente e a sua sessão terminará de imediato!</span>
    {else}
    <span>Todas as publicações deste utilizador serão apagadas automaticamente!</span>
    {/if}
  </p>
  <form action="{$BASE_URL}actions/utilizador/delete.php" method="post" class="ink-form half-top-padding">
    {include file='utilizador/delete-formulario.tpl'}
  </form>
</div>
{/block}