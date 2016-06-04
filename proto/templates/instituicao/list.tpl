{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer half-horizontal-padding">
  <div class="column-group half-top-space">
    {include file='instituicao/list-navigation.tpl'}
  </div>
  <hr class="no-margin quarter-vertical-padding">
  <div class="column-group half-gutters">
    {include file='instituicao/list-information.tpl'}
  </div>
</div>
{/block}
{block name=footer}
{/block}