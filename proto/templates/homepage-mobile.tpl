<li class="heading">
  <i class="fa fa-fw fa-hashtag"></i>
  <span>Categorias</span>
</li>
{foreach $categorias as $categoria}
<li>
  <a href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a>
</li>
{/foreach}
<li>
  <strong><a href="{$BASE_URL}pages/categoria/list.php">ver mais...</a></strong>
</li>
<li class="heading">
  <i class="fa fa-fw fa-line-chart"></i>
  <span>Populares</span>
</li>
{include file='pesquisa/pergunta-filter.tpl'}
<li class="heading">
  <i class="fa fa-fw fa-sort-alpha-asc"></i>
  <span>Ordenar</span>
</li>
{include file='pesquisa/pergunta-sort.tpl'}