<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 16:44:50
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/users/login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:89200552857090b9a81afe6-81825913%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '183797b148d1b6c098f96cc1c36997080f6a6116' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/users/login.tpl',
      1 => 1460213051,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '89200552857090b9a81afe6-81825913',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_57090b9a8d01b9_93021653',
  'variables' => 
  array (
    'BASE_DIR' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_57090b9a8d01b9_93021653')) {function content_57090b9a8d01b9_93021653($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('others/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<form action="index_user.php" method="post" class="ink-form ink-formvalidator">
  <fieldset>
    <legend class="slab align-center">Autenticação</legend>
    <div class="control-group column-group half-gutters">
      <label for="username" class="all-25 align-right">Username:</label>
      <div class="control append-symbol all-75">
        <span>
          <input name="username" id="username" type="text" data-rules="required" placeholder="Por favor introduza aqui o seu username...">
          <i class="fa fa-user"></i>
        </span>
      </div>
    </div>
    <div class="control-group column-group half-gutters">
      <label for="password" class="all-25 align-right">Password:</label>
      <div class="control append-symbol all-75">
        <span>
          <input name="password" id="password" type="password" data-rules="required" placeholder="Por favor introduza aqui a sua password...">
          <i class="fa fa-key"></i>
        </span>
      </div>
    </div>
    <div class="column-group half-horizontal-gutters">
      <div class="control-group all-15 small-5 tiny-5">
      </div>
      <div class="control-group all-25 small-30 tiny-30">
        <div class="control append-symbol">
          <span>
            <input class="ink-button black" type="submit" id="submit" name="submit" value="Validar">
            <i class="fa fa-check"></i>
          </span>
        </div>
      </div>
      <div class="control-group all-45 small-60 tiny-60">
        <div class="control append-symbol">
          <span>
            <input class="ink-button black" type="button" id="reset" name="reset" value="Recuperar Password">
            <i class="fa fa-exclamation-triangle"></i>
            </span>
          </span>
        </div>
      </div>
    </div>
    <div class="control-group column-group">
      <p class="align-center no-margin">Não se encontra registado?
        <a href="<?php echo $_smarty_tpl->tpl_vars['BASE_DIR']->value;?>
pages/users/register.php">Registe-se aqui!</a>
      </p>
    </div>
  </fieldset>
</form>
<?php echo $_smarty_tpl->getSubTemplate ('others/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
