{extends file='other/header.tpl'}
{block name=content}
<div class="align-center">
  <h1 class="slab">Eliminar Instituição</h1>
  <p>Tem a certeza que deseja eliminar a instituição <strong>{$idInstituicao|upper}</strong>?</p>
  <p><strong>ATENÇÃO:&nbsp;</strong>Todas as categorias associadas apenas a esta instituição serão apagadas automaticamente, apagando também as respetivas perguntas.</p>
  <form action="{$BASE_URL}actions/instituicao/delete.php" method="post" class="ink-form half-top-padding">
    <input type="hidden" name="idInstituicao" value="{$idInstituicao}">
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