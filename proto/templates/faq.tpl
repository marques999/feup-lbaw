{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer half-horizontal-padding bottom-padding">
  <div class="message half-vertical-space">
    {include file='faq-navigation.tpl'}
  </div>
  <div class="panel-group">
    {include file='faq-content.tpl'}
  </div>
</div>
{/block}