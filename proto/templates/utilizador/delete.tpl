{extends file='other/header.tpl'}
{block name=content}
<div class="align-center">
  <h1 class="slab">Apagar utilizador</h1>
  <p>Tem a certeza que deseja eliminar a sua conta <strong>{$USERNAME}</strong>?</p>
  <p>
    <strong>ATENÇÃO:</strong>
    <span>Todas as suas publicações serão apagadas automaticamente e a sua sessão terminará a partir deste momento!</span>
  </p>
  <form action="{$BASE_URL}actions/utilizador/delete.php" method="post" class="ink-form half-top-padding">
    {include file='utilizador/delete-formulario.tpl'}
  </form>
</div>
{/block}