{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer half-horizontal-padding bottom-padding">
  {include file='common/editor.tpl'}
  {include file='common/messages.tpl'}
  <div class="message half-vertical-space">
    {include file='conversa/view-navigation.tpl'}
  </div>
  {include file='conversa/view-message.tpl'}
  <div id="reply-form" class="message half-vertical-space">
    {include file='conversa/view-formulario.tpl'}
  </div>
</div>
<script type="text/javascript" src="{$BASE_URL}javascript/conversa.js"></script>
{/block}