<?
  require_once(__DIR__ . '/template/questions.php');
  require_once(__DIR__ . '/template/header.php');
  require_once(__DIR__ . '/template/navigation-guest.php');
  require_once(__DIR__ . '/template/page-fullscreen.php');
  require(__DIR__ . '/template/sidebar-guest.php');
?>
<div class="column half-top-padding all-80 medium-75 small-100 tiny-100">
  <?printQuestionSmall($question1, false);?>
  <?printQuestionSmall($question2, false);?>
  <?printQuestionSmall($question3, true);?>
</div>
<?
  require_once(__DIR__ . '/template/footer.php');
?>