<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 16:30:11
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/lista_instituicoes.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1061869229570910d9b29032-19911494%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '466f4f118f1b30953c0d5424548c6fdc9ed3161f' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/lista_instituicoes.tpl',
      1 => 1460212043,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1061869229570910d9b29032-19911494',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_570910d9c74365_83294444',
  'variables' => 
  array (
    'BASE_DIR' => 0,
    'instituicoes' => 0,
    'instituicao' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_570910d9c74365_83294444')) {function content_570910d9c74365_83294444($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ('common/navigation.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<div class="ink-grid">
<div class="column-group top-padding">
  <div class="column all-66 large-50 medium-40 small-40 tiny-100">
    <h3 class="condensed">Instituições
      <span class="fw-300 medium">(8)</span>
    </h3>
  </div>
  <div class="column all-33 large-50 medium-60 small-60 tiny-100">
    <nav class="ink-navigation medium push-right">
      <ul class="pagination pills">
        <li><a href="<?php echo $_smarty_tpl->tpl_vars['BASE_DIR']->value;?>
category/browse/">por categoria</a></li>
        <li class="active"><a href="<?php echo $_smarty_tpl->tpl_vars['BASE_DIR']->value;?>
hub/browse/">por instituição</a></li>
      </ul>
    </nav>
  </div>
</div>
<div class="all-100">
  <hr class="no-margin half-bottom-padding">
</div>
<div class="column-group half-gutters">
  <?php  $_smarty_tpl->tpl_vars['instituicao'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['instituicao']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['instituicoes']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['instituicao']->key => $_smarty_tpl->tpl_vars['instituicao']->value) {
$_smarty_tpl->tpl_vars['instituicao']->_loop = true;
?>
  <div class="column all-25 large-33 medium-50 small-100 tiny-100">
    <div class="message">
      <img class="all-100" src="<?php echo $_smarty_tpl->tpl_vars['instituicao']->value['sigla'];?>
.jpg" alt="">
      <div class="quarter-vertical-padding">
        <b class="no-margin">
          <a class="black" href="<?php echo $_smarty_tpl->tpl_vars['BASE_DIR']->value;?>
pages/<?php echo $_smarty_tpl->tpl_vars['instituicao']->value['sigla'];?>
"><?php echo $_smarty_tpl->tpl_vars['instituicao']->value['nome'];?>
</a>
          <small><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['instituicao']->value['sigla'], 'UTF-8');?>
</small>
        </b>
        <p class="no-margin">
          <small><i class="fa fa-user"></i>&nbsp;<?php echo $_smarty_tpl->tpl_vars['instituicao']->value['numeroMembros'];?>
 membros</small>
        </p>
        <p class="no-margin">
          <small><i class="fa fa-question-circle"></i>&nbsp;24 perguntas</small>
        </p>
        <p class="no-margin">
          <small><i class="fa fa-eye"></i>&nbsp;500 visualizações</small>
        </p>
      </div>
    </div>
  </div>
  <?php } ?>
</div>
<?php echo $_smarty_tpl->getSubTemplate ('common/footer-empty.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
