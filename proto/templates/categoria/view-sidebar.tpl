<nav class="ink-navigation medium vertical-padding">
{if $instituicoes_count gt 0}
  <h5 class="slab half-vertical-space">
    <i class="fa fa-institution fa-fw"></i>
    <span>Instituições</span>
  </h5>
  <ul class="menu vertical white">
  {strip}
  {foreach $instituicoes as $instituicao}
  <li>
    <a href="{$BASE_URL}pages/instituicao/view.php?id={$instituicao.sigla}">
      {$instituicao.sigla|upper}
    </a>
  </li>
  {/foreach}
  {/strip}
  </ul>
{/if}
{if $relacionadas|count gt 0}
  <h5 class="slab half-vertical-space">
    <i class="fa fa-exchange fa-fw"></i>
    <span>Relacionadas</span>
  </h5>
  <ul class="menu vertical white">
    {strip}
    {foreach $relacionadas as $relacionada}
    <li>
      <a href="{$BASE_URL}pages/categoria/view.php?id={$relacionada.idcategoria}">
        {$relacionada.nome}
      </a>
    </li>
    {/foreach}
    {/strip}
  </ul>
{/if}
{if $ADMINISTRADOR}
  <h5 class="slab half-vertical-space">
    <i class="fa fa-cog"></i>
    <span>Gestão</span>
  </h5>
  <ul class="menu vertical white">
  {strip}
    <li>
      <a href="{$BASE_URL}pages/categoria/edit.php">
        <sup><strong>(Admin)</strong></sup>
        <span>Editar categoria</span>
      </a>
    </li>
  {/strip}
  {strip}
    <li>
      <a href="{$BASE_URL}pages/categoria/delete.php">
        <sup><strong>(Admin)</strong></sup>
        <span>Apagar categoria</span>
      </a>
    </li>
  {/strip}
  </ul>
{/if}
</nav>