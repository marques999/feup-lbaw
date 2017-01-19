{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer half-horizontal-padding bottom-padding">
  <div class="message half-vertical-space">
    {include file='report/list-navigation.tpl'}
  </div>
  <table class="ink-table alternating hover">
    {include file='report/list-report.tpl'}
  </table>
</div>
{/block}