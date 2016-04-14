<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 16:39:40
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/admin/navigation.tpl" */ ?>
<?php /*%%SmartyHeaderCode:16458484835709142cc46989-33245056%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '93a026be84f1b70188ccf90692cea12e88c7fc87' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/admin/navigation.tpl',
      1 => 1460212448,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '16458484835709142cc46989-33245056',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'BASE_URL' => 0,
    'titulo' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5709142cc76645_39280852',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5709142cc76645_39280852')) {function content_5709142cc76645_39280852($_smarty_tpl) {?><body>
<div class="ink-grid push-center">
<div class="column-group half-top-space quarter-bottom-space">
  <div class="column all-20 large-25 medium-33 small-50 tiny-50">
    <a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/index.php">
      <img src="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
images/assets/header-256px.png" alt="">
    </a>
  </div>
  <div class="column all-80 large-75 medium-66 small-50 tiny-50 quarter-padding">
    <h5 class="quarter-vertical-space">KnowUP! - Collaborative Q&A</h5>
    <p>segunda-feira, 21 de Março de 2016</p>
  </div>
  <div class="message all-100 half-bottom-space">
    <h5 class="slab no-margin">
      <i class="fa-cog fa"></i>
      <a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/admin/homepage.php" class="black">Administração</a>
      <strong>&gt;</strong>
      <a href="<?php echo $_SERVER['REQUEST_URI'];?>
" class="black"><?php echo $_smarty_tpl->tpl_vars['titulo']->value;?>
</a>
   </h5>
  </div>
</div><?php }} ?>
