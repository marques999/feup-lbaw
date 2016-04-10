<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 16:39:44
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/admin/categorias.tpl" */ ?>
<?php /*%%SmartyHeaderCode:98202724657090a8d39bb95-14303401%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '236d865b3c2230692b6ac1d73260f242f4fce9e2' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/admin/categorias.tpl',
      1 => 1460212761,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '98202724657090a8d39bb95-14303401',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_57090a8d4d3260_25764351',
  'variables' => 
  array (
    'instituicoes' => 0,
    'BASE_DIR' => 0,
    'instituicao' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_57090a8d4d3260_25764351')) {function content_57090a8d4d3260_25764351($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('admin/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ('admin/navigation.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<div class="column-group">
  <div class="column all-80 medium-70 small-60 tiny-50">
    <h3 class="condensed">Instituições
      <span class="fw-300 medium">(8)</span>
    </h3>
  </div>
  <div class="column all-20 medium-30 small-40 tiny-50 align-right">
   <a href="#" class="ink-button medium"><i class="fa fa-plus"></i>&nbsp;Adicionar instituição</a>
  </div>
</div>
<div class="column-group half-gutters">
  <?php  $_smarty_tpl->tpl_vars['instituicao'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['instituicao']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['instituicoes']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['instituicao']->key => $_smarty_tpl->tpl_vars['instituicao']->value) {
$_smarty_tpl->tpl_vars['instituicao']->_loop = true;
?>
  <div class="column all-25 large-33 medium-50 small-100 tiny-100">
    <div class="message">
      <img class="all-100" src="<<?php ?>?=$thisHub->getImagem()?<?php ?>>" alt="">
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
        <p class="half-bottom-space">
          <small><i class="fa fa-eye"></i>&nbsp;500 visualizações</small>
        </p>
        <p class="no-margin align-center">
           <small><button class="ink-button"><i class="fa fa-pencil-square-o"></i>&nbsp;Editar</button></small>
           <small><button class="ink-button"><i class="fa fa-close"></i>&nbsp;Apagar</button></small>
        </p>
      </div>
    </div>
  </div>
  <?php } ?>
</div>
<?php echo $_smarty_tpl->getSubTemplate ('common/footer-empty.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
