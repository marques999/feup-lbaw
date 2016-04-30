<div class="column all-20 medium-25 small-100 tiny-100">
  {if $administrador}
   <div class="message half-vertical-space">
    <h5 class="slab no-margin">
      <i class="fa fa-key"></i>
      <a class="black" href="{$BASE_URL}pages/admin/homepage.php">Administração</a>
    </h5>
  </div>
  {elseif $instituicao != ''}
  <div class="message half-vertical-space">
    <h5 class="slab no-margin">
      <i class="fa fa-institution"></i>
      <a class="black" href="{$BASE_URL}pages/instituicao/view.php?id={$instituicao.sigla}">{$instituicao.sigla|upper}</a><sup>hub</sup>
    </h5>
  </div>
  {/if}
  <nav class="ink-navigation half-vertical-space medium">
    <h5 class="slab half-vertical-space">
      <i class="fa fa-hashtag"></i>&nbsp;Categorias
    </h5>
    <ul class="menu vertical white">
        <li><a href="list_questions.php">Ciências Forenses</a></li>
        <li><a href="list_questions.php">Engenharia Física</a></li>
        <li><a href="list_questions.php">Engenharia Informática</a></li>
        <li><a href="list_questions.php">Estudos Portugueses</a></li>
        <li class="heading"><a href="{$BASE_URL}pages/categoria/list.php">ver mais...</a></li>
    </ul>
    <h5 class="slab half-vertical-space">
      <i class="fa fa-line-chart"></i>&nbsp;Populares
    </h5>
    <ul id="sidebar-filter" class="menu vertical white">
      <li id="filter-now"><a href="#">Neste momento</a></li>
      <li id="filter-day"><a href="#">Últimas 48h</a></li>
      <li id="filter-week"><a href="#">Última semana</a></li>
      <li id="filter-month"><a href="#">Último mês</a></li>
      <li id="filter-year"><a href="#">Último ano</a></li>
    </ul>
    <h5 class="slab half-vertical-space">
      <i class="fa fa-sort-a"></i>&nbsp;Ordenar
    </h5>
    <ul id="sidebar-sort" class="menu vertical white">
      <li id="sort-answers"><a href="#">Respostas</a></li>
      <li id="sort-title"><a href="#">Título</a></li>
      <li id="sort-date"><a href="#">Timestamp</a></li>
      <li id="sort-score"><a href="#">Pontuação</a></li>
    </ul>
  </nav>
</div>