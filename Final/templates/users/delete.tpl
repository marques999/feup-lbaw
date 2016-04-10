{include file='common/header.tpl'}
{include file='common/navigation.tpl'}
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
{include file='common/footer.tpl'}