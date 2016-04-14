<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 14:30:09
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/categoria.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2632866875708f2be2cf3d6-40149407%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e56e97a052407c04fb9ba6bf48ec27f506e14e8f' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/categoria.tpl',
      1 => 1460205009,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2632866875708f2be2cf3d6-40149407',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5708f2be3bb9a8_29583617',
  'variables' => 
  array (
    'questions' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5708f2be3bb9a8_29583617')) {function content_5708f2be3bb9a8_29583617($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ('common/navigation.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ('common/page-fullscreen.php', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ('common/sidebar-subject.php', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<div class="column half-top-padding all-80 medium-75 small-100 tiny-100">
  <div class="column-group quarter-gutters message half-bottom-space">
    <div class="column all-75 medium-65 quarter-vertical-padding">
      <h4 class="quarter-vertical-space slab">Engenharia Informática</h4>
      <p><i class="fa fa-institution"></i>&nbsp;FCUP&nbsp;&bull;&nbsp;FEUP</p>
      <p class="medium quarter-vertical-space">
  O ensino da Engenharia Informática e Computação foi concebido na FEUP como requerendo um ciclo de formação e aprendizagem completo de cinco anos integrados, correspondendo aos 1º e 2º ciclos da implementação do Processo de Bolonha e conferindo de imediato o grau de Mestre.
      </p>
    </div>
    <div class="column all-25 medium-35 quarter-padding">
      <img src="img/question-marks.png" alt="">
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
</div>
<?php echo $_smarty_tpl->getSubTemplate ('common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
