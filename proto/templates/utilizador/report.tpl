{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid">
  <div class="message half-vertical-space">
    <h5 class="slab no-margin">
      <i class="fa fa-user fa-fw"></i>
      <a class="black" href="{$BASE_URL}pages/utilizador/profile.php">Utilizador</a>
      &nbsp;<i class="fa fa-angle-right"></i>&nbsp;
      <a class="black" href="{$BASE_URL}pages/utilizador/report.php">Denunciar utilizador</a>
    </h5>
  </div>
  <form action="{$BASE_URL}actions/utilizador/report.php" method="post" class="ink-form ink-formvalidator half-vertical-padding medium push-center" data-lang="pt_PT">
    <input name="idUtilizador" id="idUtilizador" type="hidden" value="{$utilizador.idutilizador}">
    <div class="control-group column-group half-gutters">
      <label for="moderador" class="align-right all-15 small-20 tiny-20">Cabeçalho:</label>
      <div class="control all-40">
        <input name="moderador" id="moderador" type="text" value="{$USERNAME}" placeholder="(não pode conter espaços)" disabled>
        <p class="tip">Moderador</p>
      </div>
      <div class="control all-40">
        <input name="utilizador-reportado" id="utilizador-reportado" type="text" value="{$utilizador.username}" placeholder="(não pode conter espaços)" disabled>
        <p class="tip">Utilizador reportado</p>
      </div>
    </div>
    <div class="control-group column-group half-gutters required">
      <label for="email" class="align-right all-15 small-20 tiny-20">Mensagem:</label>
      <div class="control all-80">
         <textarea name="descricao" id="descricao" type="text" data-rules="required|text[true,true]" rows="10" placeholder="Por favor escreva um texto sucinto onde indique as razões pelas quais está a denunciar este membro..."></textarea>
      </div>
    </div>
    <div class="control-group column-group half-gutters align-center">
      <button class="ink-button" type="submit">Submeter</button>
      <button class="ink-button" onclick="history.go(-1)" type="reset">Cancelar</button>
    </div>
  </form>
</div>
{/block}
{block name=footer}
{/block}