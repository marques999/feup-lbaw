<div class="message half-vertical-space">
 <b class="condensed no-margin">
    <i class="fa fa-search"></i>
    <a class="black" href="{$BASE_URL}pages/pesquisa/utilizador.php">Pesquisar utilizadores</a>
  </b>
</div>
<nav class="ink-navigation half-vertical-space medium">
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
    {include file='pesquisa/pergunta-sort.tpl'}
  </ul>
</nav>