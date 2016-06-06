<fieldset>
  <legend class="quarter-vertical-padding quarter-vertical-space slab align-center">
    <i class="fa fa-user fa-fw"></i>
    <span>Editar perfil:</span>
    <small>{$utilizador.username}</small>
  </legend>
  {include file='common/messages.tpl'}
  <input name="idUtilizador" id="idUtilizador" type="hidden" value="{$utilizador.idutilizador}">
  <div class="column-group half-gutters">
    <div class="control-group all-50 required">
      <label for="primeiro_nome" class="condensed">
        <strong>Nome</strong>
      </label>
      <div class="control medium">
        {if $FORM_VALUES.primeiro_nome}
        <input name="primeiro_nome" id="primeiro_nome" type="text"
               value="{$FORM_VALUES.primeiro_nome}"
               data-rules="required|alpha"
               placeholder="(não pode conter espaços)">
        {else}
        <input name="primeiro_nome" id="primeiro_nome" type="text"
               value="{$utilizador.primeironome}"
               data-rules="required|alpha"
               placeholder="(não pode conter espaços)">
        {/if}
      </div>
    </div>
    <div class="control-group all-50">
      <label for="ultimo_nome" class="condensed">
        <strong>&nbsp;</strong>
      </label>
      <div class="control medium">
        {if $FORM_VALUES.ultimo_nome}
        <input name="ultimo_nome" id="ultimo_nome" type="text"
               value="{$FORM_VALUES.ultimo_nome}"
               data-rules="required|alpha"
               placeholder="(não pode conter espaços)">
        {else}
        <input name="ultimo_nome" id="ultimo_nome" type="text"
               value="{$utilizador.ultimonome}"
               data-rules="required|alpha"
               placeholder="(não pode conter espaços)">
        {/if}
      </div>
    </div>
  </div>
  <div class="control-group half-gutters required">
    <label for="email" class="condensed">
      <strong>E-mail</strong>
    </label>
    <div class="control medium append-symbol">
      <span>
        {if $FORM_VALUES.email}
        <input name="email" id="email" type="text"
               value="{$FORM_VALUES.email}"
               data-rules="required|email"
               placeholder="Por favor introduza um endereço de e-mail válido">
        {else}
        <input name="email" id="email" type="text"
               value="{$utilizador.email}"
               data-rules="required|email"
               placeholder="Por favor introduza um endereço de e-mail válido">
        {/if}
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
          {if ($instituicao.idinstituicao eq $FORM_VALUES.codigo_pais) or ($instituicao.idinstituicao eq $utilizador.idinstituicao)}
          <option label="{$instituicao.nome}"
                  value="{$instituicao.idinstituicao}" selected>{$instituicao.nome}</option>
          {else}
          <option label="{$instituicao.nome}"
                  value="{$instituicao.idinstituicao}">{$instituicao.nome}</option>
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
        {if $FORM_VALUES.localidade}
        <input id="localidade" name="localidade" type="text"
               value="{$FORM_VALUES.localidade}"
               data-rules="text[true,false]"
               placeholder="Por favor introduza a sua cidade de residência">
        {else}
        <input id="localidade" name="localidade" type="text"
               value="{$utilizador.localidade}"
               data-rules="text[true,false]"
               placeholder="Por favor introduza a sua cidade de residência">
        {/if}
      </div>
    </div>
    <div class="control-group all-50">
      <label for="codigo_pais" class="condensed">
        <strong>País</strong>
      </label>
      <div class="control medium">
        <select name="codigo_pais" id="codigo_pais">
          <option label="(nenhum)" value="null">(nenhum)</option>
          {foreach from=$paises item=nomepais key=codigopais}
            {if ($codigopais eq $FORM_VALUES.codigo_pais) or ($codigopais eq $utilizador.codigopais)}
            <option label="{$nomepais}" value="{$codigopais}" selected>{$nomepais}</option>
            {else}
            <option label="{$nomepais}" value="{$codigopais}">{$nomepais}</option>
            {/if}
          {/foreach}
        </select>
      </div>
    </div>
  </div>
  <div class="control-group half-gutters">
    <label for="avatar" class="condensed">
      <strong>Avatar</strong>
    </label>
    <div class="control medium">
      <div class="input-file">
        <input name="avatar" id="avatar" type="file">
      </div>
    </div>
  </div>
  <div class="control-group quarter-vertical-space push-right">
    <div class="button-group">
      <button class="ink-button medium green" type="submit">
        <i class="fa fa-check"></i>
        <span>Submeter</span>
      </button>
      <button class="ink-button medium red" onclick="history.go(-1)">
        <i class="fa fa-close"></i>
        <span>Cancelar</span>
      </button>
    </div>
  </div>
</fieldset>