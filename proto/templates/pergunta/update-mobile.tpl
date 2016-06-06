<li class="heading">
  <i class="fa fa-fw fa-institution"></i>
  <span>Categorias</span>
</li>
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
<li class="heading">
  <i class="fa fa-fw fa-exchange"></i>
  <span>Relacionadas</span>
</li>
{foreach $relacionadas as $relacionada}
<li>
  <a href="{$BASE_URL}pages/pergunta/view.php?id={$relacionada.idpergunta}">"{$relacionada.titulo|strip_tags}" --
    <small>{$relacionada.username}</small>
  </a>
</li>
{/foreach}