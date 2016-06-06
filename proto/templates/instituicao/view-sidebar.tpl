<nav class="ink-navigation medium vertical-padding">
{if $categorias_count gt 0}
  <h5 class="slab half-vertical-space">
    <i class="fa fa-institution fa-fw"></i>
    <span>{$instituicao.sigla|upper}</span>
  </h5>
  <ul class="menu vertical white">
  {strip}
  {foreach $categorias as $categoria}
  <li>
    <a href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">
      <span>{$categoria.nome}</span>
    </a>
  </li>
  {/foreach}
  {/strip}
  </ul>
{/if}
  <h5 class="slab half-vertical-space">
    <i class="fa fa-globe fa-fw"></i>
    <span>Ligações Externas</span>
  </h5>
  <ul class="menu vertical white">
    <li>
      <a href="{$instituicao.website}/web_page.inicial">
        <span>Página Oficial</span>
        <i class="fa fa-external-link"></i>
      </a>
    </li>
    <li>
      <a href="{$instituicao.website}/cur_geral.cur_inicio">
        <span>Cursos</span>
        <i class="fa fa-external-link"></i>
      </a>
    </li>
    <li>
      <a href="https://moodle.up.pt">
        <span>Moodle U.Porto</span>
        <i class="fa fa-external-link"></i>
      </a>
    </li>
  </ul>
{if $ADMINISTRADOR}
  <h5 class="slab half-vertical-space">
    <i class="fa fa-cog"></i>
    <span>Gestão</span>
  </h5>
  <ul class="menu vertical white">
  {strip}
    <li>
      <a href="{$BASE_URL}pages/instituicao/update.php?id={$instituicao.sigla}">
        <sup><strong>(Admin)</strong></sup>
        <span>&nbsp;Editar instituição</span>
      </a>
    </li>
  {strip}
  {/strip}
    <li>
      <a href="{$BASE_URL}pages/instituicao/delete.php?id={$instituicao.sigla}">
        <sup><strong>(Admin)</strong></sup>
        <span>&nbsp;Apagar instituição</span>
      </a>
    </li>
  {/strip}
  </ul>
{/if}
</nav>