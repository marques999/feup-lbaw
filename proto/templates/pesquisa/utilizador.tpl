{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid column-group push-center gutters half-bottom-padding">
  {include file='pesquisa/sidebar-utilizador.tpl'}
  <div class="column all-80 medium-75 small-100 tiny-100">
    <h3 class="slab half-top-padding">Resultados da pesquisa</h3>
    <div id="content">
    </div>
  </div>
</div>
<script type="text/javascript" src="{$BASE_URL}javascript/pesquisa.js"></script>
{/block}