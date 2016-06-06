{extends file='admin/pagina.tpl'}
{block name=content}
{include file='common/messages.tpl'}
{if $ativos_count gt 0}
  <h3 class="condensed all-75">Utilizadores Activos
    <span class="fw-300 medium">({$ativos_count})</span>
  </h3>
  <form class="ink-form medium all-25">
    {include file='admin/utilizadores-formulario.tpl'}
  </form>
  <table class="ink-table alternating hover">
  {include file='admin/utilizadores-ativos.tpl'}
  </table>
{/if}
{if $inativos_count gt 0}
  <h3 class="condensed all-75">Utilizadores Inativos
    <span class="fw-300 medium">({$inativos_count})</span>
  </h3>
  <form class="ink-form medium all-25">
    {include file='admin/utilizadores-formulario.tpl'}
  </form>
  <table class="ink-table alternating hover">
    {include file='admin/utilizadores-inativos.tpl'}
  </table>
{/if}
{if $banidos_count gt 0}
  <h3 class="condensed all-75">Utilizadores Banidos
    <span class="fw-300 medium">({$banidos_count})</span>
  </h3>
  <form class="ink-form medium all-25">
    {include file='admin/utilizadores-formulario.tpl'}
  </form>
  <table class="ink-table alternating hover">
    {include file='admin/utilizadores-banidos.tpl'}
  </table>
{/if}
{/block}