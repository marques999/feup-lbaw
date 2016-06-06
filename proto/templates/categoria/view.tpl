{extends file='common/header.tpl'}
{block name='navigation'}
  {include file='categoria/view-mobile.tpl'}
{/block}
{block name=content}
<div class="ink-grid content-drawer column-group bottom-padding medium-gutters large-gutters xlarge-gutters">
  <div class="column all-20 medium-25 small-100 tiny-100 hide-small hide-tiny">
    {include file='categoria/view-sidebar.tpl'}
  </div>
  <div class="column all-80 medium-75 small-100 tiny-100 half-vertical-padding">
    {include file='common/messages.tpl'}
    <div class="column-group message">
      {include file='categoria/view-information.tpl'}
    </div>
    <div class="column-group half-vertical-space">
      {include file='categoria/view-questions.tpl'}
    </div>
  </div>
</div>
{/block}