<?
  include('templates/header.php');
  include('templates/navigation.php');
  require_once('prototype/questions.php');
?>

<div class="ink-grid column-group push-center gutters bottom-padding">

<?
  include('templates/sidebar_hub.php');
?>

<!-- PAINEL CENTRAL -->
<div class="column half-top-padding all-80 medium-75 small-100 tiny-100">


<!-- PAINEL CENTRAL: instituição -->
<div class="column-group quarter-gutters message">
  <div class="column all-75 medium-65 quarter-top-padding">
    <h4 class="quarter-vertical-space slab">Faculdade de Engenharia da Universidade do Porto</h4>
    <p><i class="fa fa-institution"></i>&nbsp;FEUP</p>
    <p class="medium quarter-vertical-space">
      <strong>Morada:</strong>
      <addr>R. Dr. Roberto Frias s/n, 4200-465 Porto</addr>
    </p>
    <p class="medium quarter-vertical-space">
      <strong>Telefone:</strong>
      22 508 1400
    </p>
  </div>
    <div class="column all-25 medium-35 quarter-padding">
    <img src="img/feup.jpg" alt="">
  </div>
</div>

<?printFirstQuestion($question1);?>
<?printLastQuestion($question3);?>

</div>
</div>

<?
  include('templates/footer.php');
?>