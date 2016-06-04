{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer bottom-padding half-horizontal-padding">
  <div class="message half-vertical-space">
    {include file='utilizador/notifications-heading.tpl'}
  </div>
  {if $notificacoes_count gt 0}
  <div class="column push-center">
    <nav class="ink-navigation" id="pagination">
      <ul class="pagination white medium">
      </ul>
    </nav>
  </div>
  <table class="ink-table alternating hover" data-page-size="7" data-pagination="#pagination">
    {include file='utilizador/notifications-table.tpl'}
  </table>
  {/if}
</div>
{/block}