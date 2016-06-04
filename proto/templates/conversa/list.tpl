{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer half-horizontal-padding bottom-padding">
  {include file='common/messages.tpl'}
  <div class="message half-vertical-space">
    {include file='conversa/list-navigation.tpl'}
  </div>
  <table class="ink-table alternating hover">
    {include file='conversa/list-table.tpl'}
  </table>
</div>
{/block}