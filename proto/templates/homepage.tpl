{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer column-group gutters">
  {include file='sidebar.tpl'}
  <div class="column half-vertical-padding all-80 medium-75 small-100 tiny-100">
	{include file='common/messages.tpl'}
    <nav class="ink-navigation medium push-right">
      <ul id="sidebar-order" class="pagination pills">
        <li id="order-ascending"><a href="#">ascendente</a></li>
        <li id="order-dscending"><a href="#">descendente</a></li>
      </ul>
    </nav>
    <div id="content">
    </div>
  </div>
</div>
<script type="text/javascript" src="{$BASE_URL}javascript/homepage.js"></script>
{/block}