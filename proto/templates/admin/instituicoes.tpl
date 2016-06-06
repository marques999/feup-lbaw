{extends file='admin/pagina.tpl'}
{block name=content}
<div class="column-group">
  <div class="column all-80 medium-70 small-60 tiny-50">
    <h3 class="condensed">Instituições
      <span class="fw-300 medium">({$instituicoes|count})</span>
    </h3>
  </div>
  <div class="column all-20 medium-30 small-40 tiny-50 align-right">
    <a href="{$BASE_URL}pages/instituicao/submit.php" class="ink-button medium">
      <i class="fa fa-plus"></i>
      <span>Adicionar instituição</span>
    </a>
  </div>
</div>
{include file='common/messages.tpl'}
<div class="column-group half-gutters">
  {foreach $instituicoes as $instituicao}
  <div class="column all-25 large-33 medium-50 small-100 tiny-100">
    {include file='admin/instituicoes-information.tpl'}
  </div>
  {/foreach}
</div>
{/block}