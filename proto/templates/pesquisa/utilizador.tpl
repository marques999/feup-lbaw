{extends file='common/header.tpl'}
{block name=navigation}
  {include file='pesquisa/utilizador-mobile.tpl'}
{/block}
{block name=content}
<div class="ink-grid content-drawer column-group bottom-padding medium-gutters large-gutters xlarge-gutters">
  <div class="column all-20 medium-25 small-100 tiny-100 hide-small hide-tiny">
    {include file='pesquisa/utilizador-sidebar.tpl'}
  </div>
  <div class="column all-80 medium-75 small-100 tiny-100">
    <h3 class="slab half-top-padding">Resultados da pesquisa</h3>
    <div class="column-group half-gutters" id="content">
    </div>
  </div>
</div>
<script type="text/javascript" src="{$BASE_URL}javascript/pesquisa.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/pesquisa-utilizador.js"></script>
{/block}