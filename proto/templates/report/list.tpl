{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer half-horizontal-padding bottom-padding">
  <div class="message half-vertical-space">
    {include file='report/list-navigation.tpl'}
  </div>
  <div class="column-group half-gutters">
    {include file='report/list-report.tpl'}
  </div>
</div>
{/block}