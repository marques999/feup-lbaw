{include file='common/header.tpl'}
{include file='common/navigation.tpl'}
{include file='common/page-fullscreen.tpl'}
{if $USERNAME}
	{include file='common/sidebar-home.tpl'}
{else}
  {include file='common/sidebar-guest.tpl'}
{/if}
<div class="column half-top-padding all-80 medium-75 small-100 tiny-100">
{foreach $questions as $question}
  <?printQuestionSmall($question1, false);?>
  <?printQuestionSmall($question2, false);?>
  <?printQuestionSmall($question3, true);?>
{/foreach}
</div>
{include file='common/footer.tpl'}