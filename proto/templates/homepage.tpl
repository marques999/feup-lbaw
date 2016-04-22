{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid column-group push-center gutters half-bottom-padding">
  {include file='sidebar.tpl'}
  <div class="column half-top-padding all-80 medium-75 small-100 tiny-100">
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