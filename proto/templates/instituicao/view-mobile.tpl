<li class="heading">
  <span>{$instituicao.sigla|upper}</span>
</li>
{strip}
{foreach $categorias as $categoria}
<li>
  <a href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">
    {$categoria.nome}
  </a>
</li>
{/foreach}
{/strip}
<li class="heading">
  <span>Ligações Externas</span>
</li>
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
{if $ADMINISTRADOR}
<li class="heading">
  <span>Gestão</span>
</li>
{strip}
<li>
  <a href="{$BASE_URL}pages/instituicao/update.php?id={$instituicao.sigla}">
    <span>Editar instituição</span>
  </a>
</li>
{strip}
{/strip}
<li>
  <a href="{$BASE_URL}pages/instituicao/delete.php?id={$instituicao.sigla}">
    <span>Apagar instituição</span>
  </a>
</li>
{/strip}
{/if}