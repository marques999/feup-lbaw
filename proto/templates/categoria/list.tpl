{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid push-center">
  <div class="column-group half-top-space">
    <div class="column all-66 large-50 medium-40 small-40 tiny-100">
      <h3 class="condensed">Categorias
        <span>|</span>
        <span class="fw-300 medium">{$categorias|count}</span>
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
  <hr class="no-margin quarter-bottom-padding">
  <div class="column-group ink-stacker">
  {foreach $categorias as $categoria}
    {if ($categoria@index % $numberRows) eq 0}
    <div class="column all-25 small-50 tiny-100">
    <ul>
    {/if}
    <li class="message half-vertical-space">
      <a class="condensed black" href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a>
      <span class="push-right">
        {$categoria.numeroperguntas}
        <i class="fa fa-question-circle fa-fw"></i>
      </span>
    </li>
    {if ($categoria@index % $numberRows) eq $numberRows - 1}
    </ul>
    </div>
    {/if}
  {/foreach}
  </div>
</div>
{/block}
{block name=footer}
{/block}