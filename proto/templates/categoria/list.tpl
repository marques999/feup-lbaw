{extends file='common/header.tpl'}
{block name=content}
  <div class="column-group half-top-space">
    <div class="column all-66 large-50 medium-40 small-40 tiny-100">
      <h3 class="condensed">Categorias
        <span class="fw-300 medium">({count($categorias)})</span>
      </h3>
    </div>
    <div class="column all-33 large-50 medium-60 small-60 tiny-100">
      <nav class="ink-navigation medium push-right">
        <ul class="pagination pills">
        <li class="active"><a href="{$BASE_URL}pages/categoria/list.php">por categoria</a></li>
        <li><a href="{$BASE_URL}pages/instituicao/list.php">por instituição</a></li>
        </ul>
      </nav>
    </div>
  </div>
  <div class="all-100 ">
    <hr class="no-margin half-bottom-padding">
  </div>
  <div class="column-group ink-stacker half-gutters">
  {foreach $categorias as $categoria}
    {if ($categoria@index % $numberRows) eq 0}
    <div class="column all-25 small-50 tiny-100">
    <dl>
    {/if}
    <dd><a href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a></dd>
    {if ($categoria@index % $numberRows) eq $numberRows - 1}
    </dl>
    </div>
    {/if}
  {/foreach}
  </div>
{/block}