<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 14:17:02
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/common/footer.tpl" */ ?>
<?php /*%%SmartyHeaderCode:7580646755708f2be5dcc73-83031890%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'bb41a92e7710b9bea6e2ae6d5c1391570fab625c' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/common/footer.tpl',
      1 => 1458144207,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '7580646755708f2be5dcc73-83031890',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5708f2be5e6be2_07432462',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5708f2be5e6be2_07432462')) {function content_5708f2be5e6be2_07432462($_smarty_tpl) {?><script>
  $(function() {
    $("ul#footer-links").hide();
    $("#footer").hover(function() {
      $("ul#footer-links").stop(!0, !0).slideToggle("fast");
    })
  });
</script>
<footer id="footer" class="clearfix medium fixed">
  <div class="ink-grid">
    <ul id="footer-links" class="unstyled medium inline quarter-vertical-space">
      <li><a href="about.php">About</a></li>
      <li><a href="sitemap.php">Sitemap</a></li>
      <li><a href="contacts.php">Contacts</a></li>
    </ul>
    <p class="note medium no-margin half-vertical-padding">
       <i class="fa fa-copyright"></i>
       2016 KnowUp! - Collaborative Q&A
    </p>
  </div>
</footer>
</body>
</html><?php }} ?>
