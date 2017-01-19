{extends file='other/header.tpl'}
{block name=content}
<div class="align-center">
  {include file='common/messages.tpl'}
  <h1 class="slab">Apagar Pergunta</h1>
  <p>Tem a certeza que deseja eliminar a pergunta <strong>{$pergunta.titulo}</strong>?</p>
  <p>
    <strong>ATENÇÃO:</strong>
    <span>Todas as contribuições e votos dos outros utilizadores serão apagados, bem como deixarão de seguir esta pergunta.</span>
  </p>
  <form action="{$BASE_URL}actions/pergunta/delete.php" method="POST" class="ink-form half-top-padding">
    {include file='pergunta/delete-formulario.tpl'}
  </form>
</div>
{/block}