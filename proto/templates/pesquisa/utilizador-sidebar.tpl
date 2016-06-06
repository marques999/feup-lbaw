<div class="message half-vertical-space">
 <b class="condensed no-margin">
    <i class="fa fa-search"></i>
    <a class="black" href="{$BASE_URL}pages/pesquisa/pergunta.php">Pesquisar perguntas</a>
  </b>
</div>
<nav class="ink-navigation half-vertical-space medium">
  <h5 class="slab half-vertical-space">
    <i class="fa fa-fw fa-sliders"></i>
    <span>Filtrar</span>
  </h5>
  <ul class="menu vertical white">
    {include file='pesquisa/utilizador-filter.tpl'}
  </ul>
  <h5 class="slab half-vertical-space">
    <i class="fa fa-fw fa-sort-alpha-asc"></i>
    <span>Ordenar</span>
  </h5>
  <ul class="menu vertical white">
    {include file='pesquisa/utilizador-sort.tpl'}
  </ul>
</nav>