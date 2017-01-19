{if $USERNAME}
{if $ADMINISTRADOR}
<div class="message half-vertical-space">
  <h5 class="slab no-margin">
    <i class="fa fa-key"></i>
    <a class="black" href="{$BASE_URL}pages/admin/homepage.php">Administração</a>
  </h5>
</div>
{elseif $instituicao}
<div class="message half-vertical-space">
  <h5 class="slab no-margin">
    <i class="fa fa-institution"></i>
    <a class="black" href="{$BASE_URL}pages/instituicao/view.php?id={$instituicao.sigla}">{$instituicao.sigla|upper}</a><sup>hub</sup>
  </h5>
</div>
{/if}
<nav class="ink-navigation medium">
{else}
<nav class="ink-navigation medium half-vertical-space">
{/if}
  <h5 class="slab half-vertical-space">
    <i class="fa fa-fw fa-hashtag"></i>
    <span>Categorias</span>
  </h5>
  <ul class="menu vertical white">
    {foreach $categorias as $categoria}
    <li>
      <a href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a>
    </li>
    {/foreach}
    <li class="heading">
      <a href="{$BASE_URL}pages/categoria/list.php">ver mais...</a>
    </li>
  </ul>
  <h5 class="slab half-vertical-space">
    <i class="fa fa-fw fa-line-chart"></i>
    <span>Populares</span>
  </h5>
  <ul class="menu vertical white">
    {include file='pesquisa/pergunta-filter.tpl'}
  </ul>
  <h5 class="slab half-vertical-space">
    <i class="fa fa-fw fa-sort-alpha-asc"></i>
    <span>Ordenar</span>
  </h5>
  <ul class="menu vertical white">
    {include file='homepage-sort.tpl'}
  </ul>
</nav>