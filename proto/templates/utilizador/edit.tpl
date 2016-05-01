{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid">
<div class="message all-100 half-vertical-space">
<h5 class="slab no-margin">
  <i class="fa fa-user fa-fw"></i>
  <a class="black" href="{$BASE_URL}pages/utilizador/profile.php">Utilizador</a>
  &nbsp;<i class="fa fa-angle-right"></i>&nbsp;
  <a class="black" href="{$BASE_URL}pages/utilizador/edit.php">Editar perfil</a>
</h5>
</div>
<form action="{$BASE_URL}actions/utilizador/update.php" method="post" class="ink-form ink-formvalidator half-vertical-padding medium all-60 push-center">
    

<!-- FORM: identificador do utilizador -->
<input type="hidden" id="utilizador-id" name="utilizador-id" value="{$utilizador.idutilizador}">
    
    
<!-- FORM: primeiro nome, último nome -->
<div class="control-group required column-group half-gutters">
  <label for="primeiro-nome" class="all-15 align-right">Nome:</label>
  <div class="control all-40">
    <input type="text" id="primeiro-nome" name="primeiro-nome" value="{$utilizador.primeironome}" data-rules="required">
    <p class="tip">Primeiro nome</p>
  </div>
  <div class="control all-40">
    <input type="text" id="ultimo-nome" name="ultimo-nome" value="{$utilizador.ultimonome}" data-rules="required">
    <p class="tip">Último nome</p>
  </div>
</div>
    

<!-- FORM: endereço de e-mail -->
<div class="control-group required column-group half-gutters">
  <label for="email" class="all-15 align-right">E-mail:</label>
  <div class="control all-80 append-symbol">
    <span>
    <input type="text" id="email" name="email" value="{$utilizador.email}" data-rules="required|email">
    <i class="fa fa-envelope-o"></i>
    </span>
  </div>
</div>

<!-- FORM: nome da instituição -->
<div class="control-group required column-group half-gutters">
  <label for="instituicao" class="align-right all-15 small-45 tiny-45">Instituição: </label>
  <div class="control all-80">
    <select id="instituicao" name="instituicao">
      <option label="(nenhuma)" value="0">(nenhuma)</option>
      {foreach $instituicoes as $instituicao}
      {if $instituicao.idinstituicao eq $utilizador.idinstituicao}
      <option label="{$instituicao.nome}" value="{$instituicao.idinstituicao}" selected>{$instituicao.nome}</option>
      {else}
      <option label="{$instituicao.nome}" value="{$instituicao.idinstituicao}">{$instituicao.nome}</option>
      {/if}
      {/foreach}
    </select>
  </div>
</div>

<!-- FORM: localidade, país -->
<div class="control-group column-group half-gutters">
  <label for="localidade" class="all-15 align-right">Localidade:</label>
  <div class="control all-40">
    <input type="text" id="localidade" name="localidade" value="{$utilizador.localidade}">
    <p class="tip">Cidade</p>
  </div>
  <div class="control all-40">
    <select name="codigo-pais" id="codigo-pais">
      <option label="(nenhum)" value="null">(nenhum)</option>
      {foreach from=$paises item=nomepais key=codigopais}
      {if $codigopais eq $utilizador.codigopais}
      <option label="{$nomepais}" value="{$codigopais}" selected>{$nomepais}</option>
      {else}
      <option label="{$nomepais}" value="{$codigopais}">{$nomepais}</option>
      {/if}
      {/foreach}
    </select>
    <p class="tip">País</p>
  </div>
</div>

<!-- FORM:button group -->
<div class="column control align-center all-100">
  <button class="ink-button" type="submit">Submeter</button>
  <button class="ink-button" onclick="history.go(-1)" type="reset">Cancelar</button>
</div>
</form>
</div>
{/block}
{block name=footer}
{/block}