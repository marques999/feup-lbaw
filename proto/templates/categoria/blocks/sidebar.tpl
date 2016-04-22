<div class="column all-20 medium-25 small-100 tiny-100">
  <nav class="ink-navigation medium vertical-padding">
  {if $instituicoes_count gt 0}
    <h5 class="slab half-vertical-space">
      <i class="fa fa-institution fa-fw"></i>
      <span>Instituições</span>
    </h5>
    <ul class="menu vertical white">
    {foreach $instituicoes as $instituicao}
      <li><a href="{$BASE_URL}pages/instituicao/view.php?id={$instituicao.sigla}">{$instituicao.sigla|upper}</a></li>
    {/foreach}
    </ul>
  {/if}
  {if $relacionadas|count gt 0}
    <h5 class="slab half-vertical-space">
      <i class="fa fa-exchange fa-fw"></i>
      <span>Relacionadas</span>
    </h5>
    <ul class="menu vertical white">
    {foreach $relacionadas as $relacionada}
      <li><a href="{$BASE_URL}pages/categoria/view.php?id={$relacionada.idcategoria}">{$relacionada.nome}</a></li>
    {/foreach}
    </ul>
  {/if}
    <h5 class="slab half-vertical-space">
      <i class="fa fa-line-chart fa-fw"></i>
      <span>Populares</span>
    </h5>
    <ul class="menu vertical white">
      <li class="active"><a href="#">Neste momento</a></li>
      <li><a href="#">Últimas 24h</a></li>
      <li><a href="#">Últimas 48h</a></li>
      <li><a href="#">Última semana</a></li>
      <li><a href="#">Último mês</a></li>
    </ul>
  {if $administrador}
    <h5 class="slab half-vertical-space">
      <i class="fa fa-cog"></i>
      <span>Gestão</span>
    </h5>
    <ul class="menu vertical white">
      <li><a href="{$BASE_URL}pages/categoria/edit.php">
        <sup><strong>(Admin)</strong></sup>
        <span>Editar categoria</span>
      </a></li>
      <li><a href="{$BASE_URL}pages/categoria/delete.php">
        <sup><strong>(Admin)</strong></sup>
        <span>Apagar categoria</span>
      </a></li>
    </ul>
  {/if}
  </nav>
</div>