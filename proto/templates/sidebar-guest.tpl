<div class="column all-20 medium-25 small-100 tiny-100">
  <nav class="ink-navigation medium vertical-padding">
    <h5 class="slab half-vertical-space">
      <i class="fa fa-hashtag"></i>
      <span>Categorias</span>
    </h5>
    <ul class="menu vertical white">
      {foreach $categorias as $categoria}
      <li><a href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a></li>
      {/foreach}
      <li class="heading"><a href="{$BASE_URL}pages/categoria/list.php">ver mais...</a></li>
    </ul>
    <h5 class="slab half-vertical-space">
      <i class="fa fa-line-chart"></i>
      <span>Populares</span>
    </h5>
    <ul id="sidebar-filter" class="menu vertical white">
      <li id="filter-now"><a href="#">Neste momento</a></li>
      <li id="filter-day"><a href="#">Últimas 48h</a></li>
      <li id="filter-week"><a href="#">Última semana</a></li>
      <li id="filter-month"><a href="#">Último mês</a></li>
      <li id="filter-year"><a href="#">Último ano</a></li>
    </ul>
    <h5 class="slab half-vertical-space">
      <i class="fa fa-sort-a"></i>
      <span>Ordenar</span>
    </h5>
    <ul id="sidebar-sort" class="menu vertical white">
      <li id="sort-answers"><a href="#">Respostas</a></li>
      <li id="sort-title"><a href="#">Título</a></li>
      <li id="sort-date"><a href="#">Timestamp</a></li>
      <li id="sort-score"><a href="#">Pontuação</a></li>
    </ul>
  </nav>
</div>