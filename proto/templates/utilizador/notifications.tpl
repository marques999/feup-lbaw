{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid">
  <div class="message half-vertical-space">
    <h5 class="slab no-margin">
      <i class="fa fa-user fa-fw"></i>
      <a class="black" href="{$BASE_URL}pages/utilizador/profile.php">Utilizador</a>
      &nbsp;<i class="fa fa-angle-right"></i>&nbsp;
      <a class="black" href="{$BASE_URL}pages/utilizador/notifications.php">Notificações</a>
    </h5>
  </div>
  {if $comentarios_count gt 0 or $respostas_count gt 0 or $seguidores_count gt 0}
  <div class="column align-center all-100">
    <nav class="ink-navigation" id="myTablePagination">
      <ul class="pagination black medium">
      </ul>
    </nav>
  </div>
  <table class="ink-table alternating hover" data-page-size="8" data-pagination="#myTablePagination">
    <thead>
      <tr>
        <th style="width:50%"></th>
        <th style="width:25%"></th>
        <th style="width:25%"></th>
      </tr>
    </thead>
    <tbody>
    {if $comentarios_count gt 0}
      {include file='utilizador/notifications/comentarios.tpl'}
    {/if}
    {if $respostas_count gt 0}
      {include file='utilizador/notifications/respostas.tpl'}
    {/if}
    {if $seguidores_count gt 0}
      {include file='utilizador/notifications/seguidores.tpl'}
    {/if}
    </tbody>
  </table>
  {/if}
</div>
{/block}
{block name=footer}
{/block}