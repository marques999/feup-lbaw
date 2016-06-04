<nav class="ink-navigation medium vertical-padding">
  <h5 class="slab half-vertical-space">
    <i class="fa fa-institution"></i>
    <span>Categorias</span>
  </h5>
  <ul class="menu vertical white">
  {strip}
    {foreach $categorias as $categoria}
      {if $categoria.idcategoria eq $pergunta.idcategoria}
      <li class="active">
        <a href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a>
      </li>
      {else}
      <li>
        <a href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a>
      </li>
      {/if}
    {/foreach}
  {/strip}
  </ul>
  <h5 class="slab half-vertical-space">
    <i class="fa fa-exchange"></i>
    <span>Relacionadas</span>
  </h5>
  <ul class="menu vertical white">
  {foreach $relacionadas as $relacionada}
    <li><a href="{$BASE_URL}pages/pergunta/view.php?id={$relacionada.idpergunta}">"{$relacionada.titulo|strip_tags}" --
      <small>{$relacionada.username}</small>
    </a></li>
  {/foreach}
  </ul>
</nav>