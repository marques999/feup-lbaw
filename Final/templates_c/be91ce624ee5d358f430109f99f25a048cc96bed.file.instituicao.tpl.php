<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 16:22:45
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/instituicao.tpl" */ ?>
<?php /*%%SmartyHeaderCode:52383816557090f7b4a4933-81574493%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'be91ce624ee5d358f430109f99f25a048cc96bed' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/instituicao.tpl',
      1 => 1460211763,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '52383816557090f7b4a4933-81574493',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_57090f7b5e9c86_40622766',
  'variables' => 
  array (
    'instituicao' => 0,
    'BASE_DIR' => 0,
    'questions' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_57090f7b5e9c86_40622766')) {function content_57090f7b5e9c86_40622766($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ('common/navigation.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ('common/page-fullscreen.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ('common/sidebar-hub.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<div class="column half-top-padding all-80 medium-75 small-100 tiny-100">
  <div class="column-group quarter-gutters message half-bottom-space">
    <div class="column all-75 medium-65 quarter-padding-padding">
      <h4 class="quarter-vertical-space slab"><?php echo $_smarty_tpl->tpl_vars['instituicao']->value['nome'];?>
</h4>
      <p><i class="fa fa-institution"></i>
        <?php echo mb_strtoupper($_smarty_tpl->tpl_vars['instituicao']->value['sigla'], 'UTF-8');?>

      </p>
      <p class="medium quarter-vertical-space">
        <strong>Morada:</strong>
        <addr><?php echo $_smarty_tpl->tpl_vars['instituicao']->value['morada'];?>
</addr>
      </p>
      <p class="medium quarter-vertical-space">
        <strong>Telefone:</strong>
        <?php echo $_smarty_tpl->tpl_vars['instituicao']->value['contacto'];?>

      </p>
    </div>
      <div class="column all-25 medium-35 quarter-padding">
      <img src="<?php echo $_smarty_tpl->tpl_vars['BASE_DIR']->value;?>
images/hub/<?php echo $_smarty_tpl->tpl_vars['instituicao']->value['sigla'];?>
.jpg" alt="">
    </div>
  </div>
  <?php  $_smarty_tpl->tpl_vars['question'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['question']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['questions']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['question']->key => $_smarty_tpl->tpl_vars['question']->value) {
$_smarty_tpl->tpl_vars['question']->_loop = true;
?>
    <?php echo $_smarty_tpl->getSubTemplate ('questions/list.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

  <?php } ?>
</div>
<?php echo $_smarty_tpl->getSubTemplate ('common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
