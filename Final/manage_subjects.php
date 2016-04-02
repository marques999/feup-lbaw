<? 
  $pageLink = "manage_subjects.html";
  $pageTitle = "Gerir Categorias";
  require_once(__DIR__ . '/core/database.php');
  require_once(__DIR__ . '/model/instituicao.php');
  require_once(__DIR__ . '/templates/header_admin.php');
  $queryResult = pg_query($db, "SELECT * FROM MembrosInstituicao ORDER BY sigla");
?>
<div class="column-group">
  <div class="column all-80 medium-70 small-60 tiny-50">
    <h3 class="condensed">Instituições
      <span class="fw-300 medium">(8)</span>
    </h3>
  </div>
  <div class="column all-20 medium-30 small-40 tiny-50 align-right">
   <a href="#" class="ink-button medium"><i class="fa fa-plus"></i>&nbsp;Adicionar instituição</a>
  </div>
</div>
<div class="column-group half-gutters">
  <?
    while($thisArray=pg_fetch_array($queryResult, NULL, PGSQL_NUM)){
    $thisHub = new Instituicao($thisArray);
  ?>
  <div class="column all-25 large-33 medium-50 small-100 tiny-100">
    <div class="message">
      <img class="all-100" src="<?=$thisHub->getImagem()?>" alt="">
      <div class="quarter-vertical-padding">
        <b class="no-margin">
          <a class="black" href="<?=$thisHub->getPage()?>"><?=$thisHub->getNome()?></a>
          <small><?=$thisHub->getSigla()?></small>
        </b>
        <p class="no-margin">
          <small><i class="fa fa-user"></i>&nbsp;<?=$thisArray[6]?> membros</small>
        </p>
        <p class="no-margin">
          <small><i class="fa fa-question-circle"></i>&nbsp;24 perguntas</small>
        </p>
        <p class="half-bottom-space">
          <small><i class="fa fa-eye"></i>&nbsp;500 visualizações</small>
        </p>
        <p class="no-margin align-center">
           <small><button class="ink-button"><i class="fa fa-pencil-square-o"></i>&nbsp;Editar</button></small>
           <small><button class="ink-button"><i class="fa fa-close"></i>&nbsp;Apagar</button></small>
        </p>
      </div>
    </div>
  </div>
  <?}?>
</div>
<?
  require_once(__DIR__ . '/templates/footer_empty.php');
?>