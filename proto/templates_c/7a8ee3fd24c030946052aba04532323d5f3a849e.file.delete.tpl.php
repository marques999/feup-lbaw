<?php /* Smarty version Smarty-3.1.15, created on 2016-04-09 16:02:57
         compiled from "/usr/users2/mieic2013/up201305642/public_html/proto/templates/users/delete.tpl" */ ?>
<?php /*%%SmartyHeaderCode:113850570457090b918f21f5-69413563%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '7a8ee3fd24c030946052aba04532323d5f3a849e' => 
    array (
      0 => '/usr/users2/mieic2013/up201305642/public_html/proto/templates/users/delete.tpl',
      1 => 1460210439,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '113850570457090b918f21f5-69413563',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_57090b919c46f7_90501904',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_57090b919c46f7_90501904')) {function content_57090b919c46f7_90501904($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<?php echo $_smarty_tpl->getSubTemplate ('common/navigation.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<div class="ink-grid push-center all-50 large-70 medium-80 small-100 tiny-100">
<div class="column all-100 ink-alert block error">
	<h4>Eliminar Conta</h4>
	<p>Tem a certeza que deseja eliminar a sua conta <strong>marques999</strong>?</p>
	<p><strong>ATENÇÃO:&nbsp;</strong>Todas as suas perguntas, respostas, comentários e mensagens enviadas serão apagadas automaticamente e a sua sessão terminará imediatamente...</p>
	<form action="actions/action_delete_user.php" method="post" class="ink-form">
		<div class="control-group column-group half-gutters">
			<div class="control all-25">
			</div>
			<div class="control all-25">
			 <input type="button" class="ink-button" value="Sim">
			</div>
			<div class="control all-25">
			 <input type="button" class="ink-button" value="Não">
			</div>
		</div>
	</form>
</div>
</div>
<?php echo $_smarty_tpl->getSubTemplate ('common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
