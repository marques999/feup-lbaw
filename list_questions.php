<?
  include('templates/header.php');
  include('templates/navigation.php');
  require_once('prototype/questions.php');
?>

<div class="ink-grid column-group push-center gutters bottom-padding">

<?
  include('templates/sidebar_subject.php');
?>

<!-- PAINEL CENTRAL -->
<div class="column half-top-padding all-80 medium-75 small-100 tiny-100">


<!-- PAINEL CENTRAL: categoria -->
<div class="column-group quarter-gutters message">
  <div class="column all-75 medium-65 quarter-top-padding">
    <h4 class="quarter-vertical-space slab">Engenharia Informática</h4>
    <p><i class="fa fa-institution"></i>&nbsp;FCUP&nbsp;&bull;&nbsp;FEUP</p>
    <p class="medium quarter-vertical-space">
O ensino da Engenharia Informática e Computação foi concebido na FEUP como requerendo um ciclo de formação e aprendizagem completo de cinco anos integrados, correspondendo aos 1º e 2º ciclos da implementação do Processo de Bolonha e conferindo de imediato o grau de Mestre.
    </p>
  </div>
  <div class="column all-25 medium-35 quarter-padding">
    <img src="img/question-marks.png" alt="">
  </div>
</div>

<?printFirstQuestion($question1);?>
<?printLastQuestion($question3);?>

</div>
</div>

<?
  include('templates/footer.php');
?>