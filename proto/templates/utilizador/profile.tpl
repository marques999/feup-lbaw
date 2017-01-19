{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer column-group half-gutters half-bottom-padding">
  <div class="column half-padding all-100 xlarge-30 large-40 medium-40">
    {include file='utilizador/profile-sidebar.tpl'}
  </div>
  <div class="column half-padding all-100 xlarge-70 large-60 medium-60">
    {include file='utilizador/profile-information.tpl'}
    {include file='utilizador/profile-questions.tpl'}
    {include file='utilizador/profile-answers.tpl'}
  </div>
</div>
{/block}