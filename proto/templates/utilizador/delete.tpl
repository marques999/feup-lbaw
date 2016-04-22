{extends file='other/header.tpl'}
{block name=content}
<div class="align-center">
  <h1 class="slab">Eliminar Conta</h1>
  <p>Tem a certeza que deseja eliminar a sua conta <strong>{$USERNAME}</strong>?</p>
  <p><strong>ATENÇÃO:&nbsp;</strong>Todas as suas publicações serão apagadas automaticamente e a sua sessão terminará a partir deste momento!</p>
  <form action="actions/utilizador/delete.php" method="post" class="ink-form half-top-padding">
    <input type="hidden" name="idUtilizador" value="{$USERID}">
    <div class="control-group column-group half-gutters">
      <div class="control all-25">
      </div>
      <div class="control all-25">
        <input type="submit" class="ink-button black" value="Sim">
      </div>
      <div class="control all-25">
       <input type="button" class="ink-button black" onclick="history.back(-1);" value="Não">
      </div>
    </div>
  </form>
</div>
{/block}