{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer half-horizontal-padding bottom-padding">
  {include file='common/messages.tpl'}
  <div class="message half-vertical-space">
    {include file='conversa/list-navigation.tpl'}
  </div>
  {if $conversas_count gt 0}
  <table class="ink-table alternating hover">
    {include file='conversa/list-table.tpl'}
  </table>
  {else}
  <div class="ink-alert block success">
    <h4>INFORMAÇÃO</h4>
    <p class="condensed">Não foram encontradas conversas para este utilizador!</p>
  </div>
  {/if}
</div>
{/block}