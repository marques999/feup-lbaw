<fieldset>
  <legend class="quarter-vertical-padding quarter-vertical-space slab align-center">
    <i class="fa fa-user fa-fw"></i>
    <span>Editar perfil:</span>
    <small>{$utilizador.username}</small>
  </legend>
  <input name="idUtilizador" id="idUtilizador" type="hidden" value="{$utilizador.idutilizador}">
  <div class="column-group half-gutters">
    <div class="control-group all-50 required">
      <label for="primeiro-nome" class="condensed">
        <strong>Nome</strong>
      </label>
      <div class="control">
        <input name="primeiro-nome" id="primeiro-nome" type="text" value="{$utilizador.primeironome}" data-rules="required|alpha" placeholder="(não pode conter espaços)">
      </div>
    </div>
    <div class="control-group all-50">
      <label for="ultimo-nome" class="condensed">
        <strong>&nbsp;</strong>
      </label>
      <div class="control">
        <input name="ultimo-nome" id="ultimo-nome" type="text" value="{$utilizador.ultimonome}" data-rules="required|alpha" placeholder="(não pode conter espaços)">
      </div>
    </div>
  </div>
  <div class="control-group half-gutters required">
    <label for="email" class="condensed">
      <strong>E-mail</strong>
    </label>
    <div class="control medium append-symbol">
      <span>
        <input name="email" id="email" type="text" value="{$utilizador.email}" data-rules="required|email" placeholder="Por favor introduza um endereço de e-mail válido">
        <i class="fa fa-envelope-o"></i>
      </span>
    </div>
  </div>
  <div class="control-group half-gutters required">
    <label for="instituicao" class="condensed">
      <strong>Instituição</strong>
    </label>
    <div class="control medium">
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
  <div class="column-group half-gutters">
    <div class="control-group all-50">
      <label for="localidade" class="condensed">
        <strong>Localidade</strong>
      </label>
      <div class="control medium">
        <input type="text" id="localidade" name="localidade" value="{$utilizador.localidade}" data-rules="text[true,false]" placeholder="Por favor introduza a sua cidade de residência">
      </div>
    </div>
    <div class="control-group all-50">
      <label for="codigo-pais" class="condensed">
        <strong>País</strong>
      </label>
      <div class="control medium">
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
      </div>
    </div>
  </div>
  <div class="control-group quarter-vertical-space push-right">
    <div class="button-group">
      <button class="ink-button medium green" type="submit">
        <i class="fa fa-check"></i>
        <span>Submeter</span>
      </button>
      <button class="ink-button medium red" onclick="history.go(-1)" type="reset">
        <i class="fa fa-close"></i>
        <span>Cancelar</span>
      </button>
    </div>
  </div>
</fieldset>