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
<form action="{$BASE_URL}actions/utilizador/update.php" method="post" class="ink-form ink-formvalidator half-vertical-padding medium all-60 push-center" data-lang="pt_PT">
  <input name="idUtilizador" id="idUtilizador" type="hidden" value="{$utilizador.idutilizador}">
  <div class="control-group column-group half-gutters required">
    <label for="primeiro-nome" class="align-right all-15 small-20 tiny-20">Nome:</label>
    <div class="control all-40">
      <input name="primeiro-nome" id="primeiro-nome" type="text" value="{$utilizador.primeironome}" data-rules="required|alpha" placeholder="(não pode conter espaços)">
      <p class="tip">Primeiro nome</p>
    </div>
    <div class="control all-40">
      <input name="ultimo-nome" id="ultimo-nome" type="text" value="{$utilizador.ultimonome}" data-rules="required|alpha" placeholder="(não pode conter espaços)">
      <p class="tip">Último nome</p>
    </div>
  </div>
  <div class="control-group column-group half-gutters required">
    <label for="email" class="align-right all-15 small-20 tiny-20">E-mail:</label>
    <div class="control all-80 append-symbol">
      <span>
        <input name="email" id="email" type="text" value="{$utilizador.email}" data-rules="required|email" placeholder="Por favor introduza um endereço de e-mail válido">
        <i class="fa fa-envelope-o"></i>
      </span>
    </div>
  </div>
  <div class="control-group column-group half-gutters required">
    <label for="instituicao" class="align-right all-15 small-20 tiny-20">Instituição:</label>
    <div class="control all-80">
      <select name="instituicao" id="instituicao">
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
  <div class="control-group column-group half-gutters">
    <label for="localidade" class="align-right all-15 small-20 tiny-20">Localidade:</label>
    <div class="control all-40">
      <input type="text" id="localidade" name="localidade" value="{$utilizador.localidade}" data-rules="text[true,false]" placeholder="Por favor introduza a sua cidade de residência">
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
  <div class="control-group column-group half-gutters align-center">
    <button class="ink-button" type="submit">Submeter</button>
    <button class="ink-button" onclick="history.go(-1)" type="reset">Cancelar</button>
  </div>
</form>
</div>
{/block}
{block name=footer}
{/block}