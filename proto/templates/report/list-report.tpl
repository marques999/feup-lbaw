{foreach $reports as $report}
<div class="column all-50 small-100 tiny-100">
  <div class="report-entry message">
    <div class="report-close push-right">
       <small>
        <a href="#reply-form" class="black remove-button">
          <i class="fa fa-close fa-fw"></i>
        </a>
      </small>
    </div>
    <div class="report-header half-bottom-space">
      <img class="avatar-small push-left quarter-horizontal-space"
           src="{$utilizador.idutilizador|utilizador_getAvatar}"
           alt="{$utilizador.username}">
      <p class="no-margin">
        <strong>
        {if $report.removido}
          {$report.nomeutilizador}
        {else}
          {strip}
          <a href="{$BASE_URL}pages/utilizador/profile.php?id={$utilizador.idutilizador}">
            {$report.nomeutilizador}
          </a>
          {/strip}
        {/if}
        </strong>
        <small>({$report.username})</small>
      </p>
      <p class="slab">
        <small>
          <i class="fa fa-calendar"></i>
          {$report.datahora|date_format:"%A, %e %B %Y %H:%M"}
        </small>
      </p>
    </div>
    <div class="report-content medium half-bottom-space">
      {$report.descricao}
    </div>
  </div>
</div>
{/foreach}