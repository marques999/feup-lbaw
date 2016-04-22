<div class="column all-20 medium-25 small-100 tiny-100">
  <nav class="ink-navigation medium vertical-padding">
  {if $categorias_count gt 0}
    <h5 class="slab half-vertical-space">
      <i class="fa fa-institution fa-fw"></i>
      <span>{$instituicao.sigla|upper}</span>
    </h5>
    <ul class="menu vertical white">
    {foreach $categorias as $categoria}
      <li><a href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a></li>
    {/foreach}
    </ul>
  {/if}
    <h5 class="slab half-vertical-space">
      <i class="fa fa-globe fa-fw"></i>
      <span>Ligações Externas</span>
    </h5>
    <ul class="menu vertical white">
      <li><a href="{$instituicao.website}/web_page.inicial">
        <span>Página Oficial</span>
        <i class="fa fa-external-link"></i>
      </a></li>
      <li><a href="{$instituicao.website}/cur_geral.cur_inicio">
        <span>Cursos</span>
        <i class="fa fa-external-link"></i>
      </a></li>
      <li><a href="https://moodle.up.pt">
        <span>Moodle U.Porto</span>
        <i class="fa fa-external-link"></i>
      </a></li>
    </ul>
  {if $administrador}
    <h5 class="slab half-vertical-space">
      <i class="fa fa-cog"></i>
      <span>Gestão</span>
    </h5>
    <ul class="menu vertical white">
      <li><a href="{$BASE_URL}pages/instituicao/edit.php">
        <sup><strong>(Admin)</strong></sup>
        <span>Editar instituição</span>
      </a></li>
      <li><a href="{$BASE_URL}pages/instituicao/delete.php">
        <sup><strong>(Admin)</strong></sup>
        <span>Apagar instituição</a></li></span>
    </ul>
  {/if}
  </nav>
</div>