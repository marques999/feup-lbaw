{extends file='common/header.tpl'}
{block name=navigation}
  {include file='homepage-mobile.tpl'}
{/block}
{block name=content}
<div class="ink-grid content-drawer column-group bottom-padding medium-gutters large-gutters xlarge-gutters">
  <div class="column all-20 medium-25 small-100 tiny-100 hide-small hide-tiny">
    {include file='homepage-sidebar.tpl'}
  </div>
  <div class="column all-80 medium-75 small-100 tiny-100 half-vertical-padding">
    {include file='common/messages.tpl'}
    <div id="content">
    </div>
  </div>
</div>
<script type="text/javascript" src="{$BASE_URL}javascript/pesquisa.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/homepage.js"></script>
{/block}