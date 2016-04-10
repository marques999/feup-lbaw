<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 15:59:00
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/admin/utilizadores.tpl" */ ?>
<?php /*%%SmartyHeaderCode:114943319557090aa48858a0-52191008%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f3ed2ab1d6d88e296981d4fa650ca0adb97e8e68' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/admin/utilizadores.tpl',
      1 => 1460201859,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '114943319557090aa48858a0-52191008',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'users' => 0,
    'user' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_57090aa49ce657_79321822',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_57090aa49ce657_79321822')) {function content_57090aa49ce657_79321822($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('common/header-admin.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ('common/navigation-admin.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<h3 class="condensed all-75">Utilizadores Activos
  <span class="fw-300 medium">(4)</span>
</h3>
<form class="ink-form medium all-25">
  <div class="column-group horizontal-gutters">
    <div class="control-group">
      <div class="control append-symbol">
      <span>
        <input type="text" name="search" placeholder="Pesquisar utilizador...">
        <i class="fa fa-search"></i>
      </span>
      </div>
    </div>
  </div>
</form>
<table class="ink-table alternating hover">
  <thead>
    <tr>
      <th>Username</th>
      <th>E-mail</th>
      <th>Pontuação</th>
      <th>Perguntas</th>
      <th>Atividade</th>
    </tr>
  </thead>
  <tbody class="align-center">
  <?php  $_smarty_tpl->tpl_vars['user'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['user']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['users']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['user']->key => $_smarty_tpl->tpl_vars['user']->value) {
$_smarty_tpl->tpl_vars['user']->_loop = true;
?>
    <?php if ($_smarty_tpl->tpl_vars['user']->value['ativo']) {?>
    <tr>
      <td class="align-left">
        <i class="fa fa-user"></i>
        <a href="view_profile.html"><?php echo $_smarty_tpl->tpl_vars['user']->value['primeiroNome'];?>
 <?php echo $_smarty_tpl->tpl_vars['user']->value['ultimoNome'];?>
</a>
        <small>(<?php echo $_smarty_tpl->tpl_vars['user']->value['username'];?>
)</small>
      </td>
      <td>
        <small><?php echo $_smarty_tpl->tpl_vars['user']->value['email'];?>
</small>
      </td>
      <td class="medium fw-700 positive-score"><?php echo $_smarty_tpl->tpl_vars['user']->value['pontuacao'];?>
</td>
      <td class="medium"><?php echo $_smarty_tpl->tpl_vars['user']->value['numeroPerguntas'];?>
</td>
      <td>
        <small><?php echo $_smarty_tpl->tpl_vars['user']->value['ultimoAcesso'];?>
</small>
      </td>
    </tr>
    <?php }?>
  <?php } ?>
  </tbody>
</table>
<div class="top-space">
<h3 class="condensed all-75">Utilizadores Banidos
  <span class="fw-300 medium">(1)</span>
</h3>
<form class="ink-form medium all-25">
  <div class="column-group horizontal-gutters">
    <div class="control-group">
      <div class="control append-symbol">
      <span>
        <input type="text" name="search" placeholder="Pesquisar utilizador...">
        <i class="fa fa-search"></i>
      </span>
      </div>
    </div>
  </div>
</form>
</div>
<table class="ink-table alternating hover">
  <thead>
    <tr>
      <th>Username</th>
      <th>E-mail</th>
      <th>Pontuação</th>
      <th>Perguntas</th>
      <th style="width:25%">Acções</th>
    </tr>
  </thead>
  <tbody>
  <?php  $_smarty_tpl->tpl_vars['user'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['user']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['users']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['user']->key => $_smarty_tpl->tpl_vars['user']->value) {
$_smarty_tpl->tpl_vars['user']->_loop = true;
?>
    <?php if (!$_smarty_tpl->tpl_vars['user']->value['ativo']) {?>
    <tr class="align-center">
      <td class="align-left">
        <i class="fa fa-user"></i>
        <a href="view_profile.html"><?php echo $_smarty_tpl->tpl_vars['user']->value['primeiroNome'];?>
 <?php echo $_smarty_tpl->tpl_vars['user']->value['ultimoNome'];?>
</a>
        <small>(<?php echo $_smarty_tpl->tpl_vars['user']->value['username'];?>
)</small>
      </td>
      <td>
        <small><?php echo $_smarty_tpl->tpl_vars['user']->value['email'];?>
</small>
      </td>
      <td class="medium fw-700 negative-score"><?php echo $_smarty_tpl->tpl_vars['user']->value['pontuacao'];?>
</td>
      <td class="medium"><?php echo $_smarty_tpl->tpl_vars['user']->value['numeroPerguntas'];?>
</td>
      <td>
        <small>
          <button class="ink-button">
            <i class="fa fa-check"></i>
            <span>Activar</span>
          </button>
        </small>
        <small>
          <button class="ink-button">
            <i class="fa fa-user-times"></i>
            <span>Apagar</span>
          </button>
        </small>
      </td>
    </tr>
    <?php }?>
  <?php } ?>
  </tbody>
</table>
<?php echo $_smarty_tpl->getSubTemplate ('common/footer-empty.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
