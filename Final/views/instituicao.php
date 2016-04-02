<?
  require_once(__DIR__ . '/template/questions.php');
  require_once(__DIR__ . '/template/header.php');
  require_once(__DIR__ . '/template/navigation.php');
  require_once(__DIR__ . '/template/page-fullscreen.php');
  require_once(__DIR__ . '/../model/instituicao.php');
  require_once(__DIR__ . '/../core/database.php');
  $queryResult = pg_prepare($db, "my_query", "SELECT * FROM knowup.Instituicao WHERE sigla = $1");
  $queryResult = pg_execute($db, "my_query", array($nomeInstituicao));
  $thisHub = new Instituicao(pg_fetch_array($queryResult, 0, PGSQL_NUM));
  require(__DIR__ . '/template/sidebar-hub.php');
?>
<div class="column half-top-padding all-80 medium-75 small-100 tiny-100">
  <div class="column-group quarter-gutters message">
    <div class="column all-75 medium-65 quarter-top-padding">
      <h4 class="quarter-vertical-space slab"><?=$thisHub->getNome()?></h4>
      <p><i class="fa fa-institution"></i>&nbsp;<?=$thisHub->getSigla()?></p>
      <p class="medium quarter-vertical-space">
        <strong>Morada:</strong>
        <addr><?=$thisHub->getMorada()?></addr>
      </p>
      <p class="medium quarter-vertical-space">
        <strong>Telefone:</strong>
        <?=$thisHub->getContacto()?>
      </p>
    </div>
      <div class="column all-25 medium-35 quarter-padding">
      <img src="<?=$thisHub->getImagem()?>" alt="">
    </div>
  </div>
  <?printFirstQuestion($question1);?>
  <?printLastQuestion($question3);?>
</div>
<?
  require_once(__DIR__ . '/template/footer.php');
?>