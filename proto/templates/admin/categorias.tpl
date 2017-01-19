{extends file='admin/pagina.tpl'}
{block name=content}
<div class="column-group">
  <div class="column all-80 medium-70 small-60 tiny-50">
    <h3 class="condensed">Categorias
      <span class="fw-300 medium">({$categorias|count})</span>
    </h3>
  </div>
  <div class="column all-20 medium-30 small-40 tiny-50 align-right">
    <button id="insert-button" class="ink-button medium">
      <i class="fa fa-plus"></i>
      <span>Adicionar categoria</span>
    </button>
  </div>
</div>
{include file='common/messages.tpl'}
<div class="column-group half-gutters">
  {foreach $categorias as $categoria}
  <div class="column all-25 large-33 medium-50 small-50 tiny-100">
    {include file='admin/categorias-information.tpl'}
  </div>
  {/foreach}
</div>
<script type="text/javascript" src="{$BASE_URL}javascript/admin-categoria.js"></script>
{/block}