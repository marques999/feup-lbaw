<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 14:17:02
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/common/navigation.tpl" */ ?>
<?php /*%%SmartyHeaderCode:6693748025708f2be492a62-45410342%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'dc6f5cf0df9f664238c122148493cc57bcd1bacf' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/common/navigation.tpl',
      1 => 1460203007,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '6693748025708f2be492a62-45410342',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'USERNAME' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5708f2be4b7835_36755194',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5708f2be4b7835_36755194')) {function content_5708f2be4b7835_36755194($_smarty_tpl) {?><?php if ($_smarty_tpl->tpl_vars['USERNAME']->value) {?>
  <?php echo $_smarty_tpl->getSubTemplate ('common/navigation-user.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php } else { ?>
  <?php echo $_smarty_tpl->getSubTemplate ('common/navigation-guest.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php }?><?php }} ?>
