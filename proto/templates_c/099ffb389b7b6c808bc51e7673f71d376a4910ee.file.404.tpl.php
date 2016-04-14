<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 16:45:30
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/404.tpl" */ ?>
<?php /*%%SmartyHeaderCode:17627152735709158a2e4593-26233559%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '099ffb389b7b6c808bc51e7673f71d376a4910ee' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/404.tpl',
      1 => 1460213069,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '17627152735709158a2e4593-26233559',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5709158a397a92_75062650',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5709158a397a92_75062650')) {function content_5709158a397a92_75062650($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('others/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<div class="align-center half-top-padding double-bottom-padding">
  <h1 class="slab">Página não encontrada</h1>
  <p>Pedimos desculpa, mas a página que tentou visualizar não existe.</p>
  <form class="ink-form medium half-top-padding" action="#" method="get">
    <div class="control-group all-15">
    </div>
    <div class="control-group all-70">
      <div class="control append-button" role="search">
        <span>
          <input type="text" name="name" id="name">
        </span>
        <button class="ink-button black">Pesquisar</button>
      </div>
    </div>
  </form>
</div>
<?php echo $_smarty_tpl->getSubTemplate ('others/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
