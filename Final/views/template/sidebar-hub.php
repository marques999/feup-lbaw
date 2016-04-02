<?
  $queryResult = pg_prepare($db, "ab", "SELECT idCategoria, nome FROM knowUP.CategoriasPorInstituicao WHERE sigla = $1");
  $queryResult = pg_execute($db, "ab", array($nomeInstituicao));
?>
<div class="column all-20 medium-25 small-100 tiny-100">
  <nav class="ink-navigation medium vertical-padding">
  <h5 class="slab half-vertical-space">
    <i class="fa fa-institution"></i>&nbsp;<?=$thisHub->getSigla()?>
  </h5>
  <ul class="menu vertical white">
    <?while($thisSubject=pg_fetch_array($queryResult,NULL,PGSQL_NUM)){?>
    <li><a href="category/<?=$thisSubject[0]?>"><?=$thisSubject[1]?></a></li>
    <?}?>
  </ul>
  <h5 class="slab half-vertical-space">
    <i class="fa fa-globe"></i>&nbsp;Ligações Externas
  </h5>
  <ul class="menu vertical white">
    <li><a href="<?=$thisHub->getPaginaOficial()?>">Página Oficial
      <i class="fa fa-external-link"></i>
    </a></li>
    <li><a href="<?=$thisHub->getPaginaCursos()?>">Cursos
      <i class="fa fa-external-link"></i>
    </a></li>
    <li><a href="https://moodle.up.pt">Moodle U.Porto
      <i class="fa fa-external-link"></i>
    </a></li>
  </ul>
  <h5 class="slab half-vertical-space">
    <i class="fa fa-cog"></i>&nbsp;Gestão
  </h5>
  <ul class="menu vertical white">
    <li><a href="#">
      <sup><strong>(Admin)</strong></sup>
      Editar instituição
    </a></li>
    <li><a href="#">
      <sup><strong>(Admin)</strong></sup>
      Apagar instituição</a></li>
  </ul>
  </nav>
</div>