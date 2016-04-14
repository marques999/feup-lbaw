{include file='common/header.tpl'}
{include file='common/navigation.tpl'}
<div class="ink-grid">
<div class="column-group top-padding">
  <div class="column all-66 large-50 medium-40 small-40 tiny-100">
  <h3 class="condensed">Categorias
    <span class="fw-300 medium">(48)</span>
  </h3>
  </div>
  <div class="column all-33 large-50 medium-60 small-60 tiny-100">
  <nav class="ink-navigation medium push-right">
    <ul class="pagination pills">
    <li class="active"><a href="category/browse/">por categoria</a></li>
    <li><a href="{$BASE_DIR}hub/browse/">por instituição</a></li>
    </ul>
  </nav>
  </div>
</div>
<div class="all-100 ">
  <hr class="no-margin half-bottom-padding">
</div>
<div class="column-group ink-stacker half-gutters">
  {foreach $categorias as $categoria}
    {if $counter eq 0}
      <div class="column all-25 small-50 tiny-100">
      <dl>
    {/if}
    <dd><a href="{$BASE_DIR}category/{$counter}">{$categoria}</a></dd>
    {if $counter eq $numberRows - 1}
      </dl>
      </div>
    {/if}
    {$counter = ($counter + 1) % $numberRows}
  {/foreach}
</div>
{include file='common/footer-empty.tpl'}