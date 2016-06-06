{if $instituicoes_count gt 0}
<li class="heading">
  <i class="fa fa-institution fa-fw"></i>
  <span>Instituições</span>
</li>
{strip}
{foreach $instituicoes as $instituicao}
<li>
  <a href="{$BASE_URL}pages/instituicao/view.php?id={$instituicao.sigla}">
    {$instituicao.sigla|upper}
  </a>
</li>
{/foreach}
{/strip}
{/if}
{if $relacionadas|count gt 0}
<li class="heading">
  <i class="fa fa-exchange fa-fw"></i>
  <span>Relacionadas</span>
</li>
{strip}
{foreach $relacionadas as $relacionada}
<li>
  <a href="{$BASE_URL}pages/categoria/view.php?id={$relacionada.idcategoria}">
    {$relacionada.nome}
  </a>
</li>
{/foreach}
{/strip}
{/if}
{if $ADMINISTRADOR}
<li class="heading">
  <i class="fa fa-cog"></i>
  <span>Gestão</span>
</li>
{strip}
<li>
  <a href="{$BASE_URL}pages/categoria/edit.php">
    <span>Editar categoria</span>
  </a>
</li>
{/strip}
{strip}
<li>
  <a href="{$BASE_URL}pages/categoria/delete.php">
    <span>Apagar categoria</span>
  </a>
</li>
{/strip}
{/if}