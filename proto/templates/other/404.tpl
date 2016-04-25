{extends file='other/message.tpl'}
{block name='content'}
<div class="align-center half-top-padding double-bottom-padding">
  <h1 class="slab">Página não encontrada</h1>
  <p>Pedimos desculpa, mas a página que tentou visualizar não existe.</p>
  <form class="ink-form medium half-top-padding" action="#" method="get">
    <div class="control-group all-15">
    </div>
    <div class="control-group all-70">
      <div class="control append-button" role="search">
        <span>
          <input type="text" name="name" id="name">
        </span>
        <button class="ink-button black">Pesquisar</button>
      </div>
    </div>
  </form>
</div>
{/block}