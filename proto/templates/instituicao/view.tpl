{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer column-group gutters bottom-padding">
  <div class="column all-20 medium-25 small-100 tiny-100">
    {include file='instituicao/view-sidebar.tpl'}
  </div>
  <div class="column all-80 medium-75 small-100 tiny-100 half-vertical-padding">
  	{include file='common/messages.tpl'}
    <div class="column-group message">
      {include file='instituicao/view-information.tpl'}
    </div>
    <div class="column-group half-vertical-space">
      {include file='instituicao/view-questions.tpl'}
    </div>
  </div>
</div>
{/block}