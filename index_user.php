<?
  include('templates/header.php');
  include('templates/navigation.php');
  require_once('prototype/questions.php');
?>

<div class="ink-grid column-group gutters bottom-padding">

<?
  include('templates/sidebar_home.php');
?>

<div class="column half-top-padding all-80 medium-75 small-100 tiny-100">
  <?printQuestionSmall($question1, false);?>
  <?printQuestionSmall($question2, false);?>
  <?printQuestionSmall($question3, true);?>
</div>
</div>

<?
  include('templates/footer.php');
?>