{extends file='other/header.tpl'}
{block name=content}
<div class="align-center">
  {include file='common/messages.tpl'}
  <h1 class="slab">Eliminar Instituição</h1>
  <p>Tem a certeza que deseja eliminar a instituição <strong>{$idInstituicao|upper}</strong>?</p>
  <p>
  	<strong>ATENÇÃO:</strong>
  	<span>Todas as categorias associadas apenas a esta instituição serão apagadas automaticamente, apagando também as respetivas perguntas.</span>
  </p>
  <form action="{$BASE_URL}actions/instituicao/delete.php" method="post" class="ink-form half-top-padding">
    {include file='instituicao/delete-formulario.tpl'}
  </form>
</div>
{/block}