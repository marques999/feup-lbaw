<thead>
  <th>Utilizador</th>
  <th>Descrição</th>
  <th>Data submissão</th>
  <th>Acções</th>
</thead>
<tbody>
{foreach $reports as $report}
<tr>
  <td class="fw-700">
    <img class="avatar-medium push-left quarter-padding"
         src="{$report.idutilizador|utilizador_getAvatar}"
         alt="{$report.username}">
    <div class="half-vertical-padding all-50 medium-20 small-30">
      <p class="no-margin">
        {if $report.removido}
        {$report.username}
        {else}
        <a href="{$BASE_URL}pages/utilizador/profile.php?id={$report.idutilizador}">{$report.username}</a>
        {/if}
      </p>
      <note class="medium">{$report.sigla|upper}</note>
    </div>
  </td>
  <td class="medium">
    {$report.descricao}
  </td>
  <td class="medium">
    <i class="fa fa-user"></i>
    <a href="{$BASE_URL}pages/utilizador/profile.php?id={$report.idmoderador}">{$USERNAME}</a>
    <p>
      <small>{$report.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
    </p>
  </td>
  <td class="fw-700">
    {if not $ADMINISTRADOR and not $report.ativo}
    <button class="ink-button medium" disabled>ver perfil</button>
    {elseif $ADMINISTRADOR}
      {if $report.ativo}
      <a href="{$BASE_URL}actions/utilizador/ban.php?id={$report.idutilizador}"
         class="ink-button medium">banir</a>
      {else}
      <a href="{$BASE_URL}actions/utilizador/enable.php?id={$report.idutilizador}"
         class="ink-button medium">ativar</a>
      {/if}
    {else}
    <a href="{$BASE_URL}pages/utilizador/profile.php?id={$report.idutilizador}"
       class="ink-button medium">ver perfil</a>
    {/if}
    <a href="{$BASE_URL}actions/report/delete.php?id={$report.idreport}"
       class="ink-button medium">apagar</a>
  </td>
</tr>
{/foreach}
</tbody>