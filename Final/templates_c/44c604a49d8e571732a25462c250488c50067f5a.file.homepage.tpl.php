<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 15:58:59
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/admin/homepage.tpl" */ ?>
<?php /*%%SmartyHeaderCode:171443530457090a48c80767-19018958%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '44c604a49d8e571732a25462c250488c50067f5a' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/admin/homepage.tpl',
      1 => 1460210338,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '171443530457090a48c80767-19018958',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_57090a48d803c7_63175751',
  'variables' => 
  array (
    'BASE_URL' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_57090a48d803c7_63175751')) {function content_57090a48d803c7_63175751($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('common/header-login.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<h3 class="slab align-center">Administração</h3>
<hr>
<div class="column-group hide-small hide-tiny half-vertical-space">
  <a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/admin/categorias.php">
    <div class="column ink-button black all-33">
      <div class="huge-button">
        <i class="fa fa-database"></i>
      </div>
      <h4 class="condensed half-vertical-space">Gerir Categorias</h4>
    </div>
  </a>
  <a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/admin/estatisticas.php">
    <div class="column ink-button black all-33">
      <div class="huge-button">
        <i class="fa fa-line-chart"></i>
      </div>
      <h4 class="condensed half-vertical-space">Estatísticas</h4>
    </div>
  </a>
  <a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/admin/utilizadores.php">
    <div class="column ink-button black all-33">
      <div class="huge-button">
        <i class="fa fa-users"></i>
      </div>
        <h4 class="condensed half-vertical-space">Gerir Utilizadores</h4>
    </div>
  </a>
</div>
<div class="column-group hide-all show-small show-tiny half-vertical-space">
  <a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/admin/categorias.php">
    <div class="column all-100 ink-button black">
      <div class="huge-button all-25 push-left">
        <i class="fa fa-institution"></i>
      </div>
      <h2 class="condensed all-75 vertical-space">Gerir Categorias</h2>
    </div>
  </a>
  <a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/admin/estatisticas.php">
    <div class="column all-100 ink-button black">
      <div class="huge-button all-25 push-left">
        <i class="fa fa-line-chart"></i>
      </div>
      <h2 class="condensed all-75 vertical-space">Estatísticas</h2>
    </div>
  </a>
  <a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/admin/utilizadores.php">
    <div class="column all-100 ink-button black">
      <div class="huge-button all-25 push-left">
        <i class="fa fa-users"></i>
      </div>
      <h2 class="condensed all-75 vertical-space">Gerir Utilizadores</h2>
    </div>
  </a>
</div>
<hr>
<h4 class="condensed align-center no-margin">Utilizador:
  <a href="view_profile.html">admin</a>
</h4>
<?php echo $_smarty_tpl->getSubTemplate ('common/footer-empty.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
