<fieldset>
  <legend class="quarter-vertical-padding slab align-center">
    <i class="fa fa-user fa-fw"></i>
    <span>Registar utilizador</span>
  </legend>
  {include file='common/messages.tpl'}
  <div class="control-group column-group half-gutters required">
    <label for="username" class="align-right all-15 small-20 tiny-20">Username:</label>
    <div class="control append-symbol all-80">
      <span>
        {if $FORM_VALUES.username}
        <input name="username" id="username" type="text"
               value="{$FORM_VALUES.username}"
               data-rules="required|alpha_numeric"
               placeholder="Por favor introduza um username válido">
        {else}
        <input name="username" id="username" type="text"
               data-rules="required|alpha_numeric"
               placeholder="Por favor introduza um username válido">
        {/if}
        <i class="fa fa-user"></i>
      </span>
    </div>
  </div>
  <div class="control-group column-group half-gutters required">
    <label for="password" class="align-right all-15 small-20 tiny-20">Password:</label>
    <div class="control append-symbol all-80">
      <span>
        <input name="password" id="password" type="password"
               data-rules="required|text[false,true]|min_length[8]"
               placeholder="Por favor introduza uma palavra-passe">
        <i class="fa fa-key"></i>
      </span>
    </div>
  </div>
  <div class="control-group column-group half-gutters required">
    <label for="primeiro_nome" class="align-right all-15 small-20 tiny-20">Nome:</label>
    <div class="control all-40">
      {if $FORM_VALUES.primeiro_nome}
      <input name="primeiro_nome" id="primeiro_nome" type="text"
             value="{$FORM_VALUES.primeiro_nome"
             data-rules="required|alpha"
             placeholder="(não pode conter espaços)">
      {else}
      <input name="primeiro_nome" id="primeiro_nome" type="text"
             data-rules="required|alpha"
             placeholder="(não pode conter espaços)">
      {/if}
      <p class="tip">Primeiro nome</p>
    </div>
    <div class="control all-40">
      {if $FORM_VALUES.ultimo_nome}
      <input name="ultimo_nome" id="ultimo_nome" type="text"
             value="{$FORM_VALUES.ultimo_nome}"
             data-rules="required|alpha"
             placeholder="(não pode conter espaços)">
      {else}
      <input name="ultimo_nome" id="ultimo_nome" type="text"
             data-rules="required|alpha"
             placeholder="(não pode conter espaços)">
      {/if}
      <p class="tip">Último nome</p>
    </div>
  </div>
  <div class="control-group column-group half-gutters required">
    <label for="email" class="align-right all-15 small-20 tiny-20">E-mail:</label>
    <div class="control append-symbol all-80">
      <span>
        {if $FORM_VALUES.email}
        <input name="email" id="email" type="text"
               value="{$FORM_VALUES.email}"
               data-rules="required|email"
               placeholder="Por favor introduza um endereço de e-mail válido">
        {else}
        <input name="email" id="email" type="text"
               data-rules="required|email"
               placeholder="Por favor introduza um endereço de e-mail válido">
        {/if}
        <i class="fa fa-envelope-o"></i>
      </span>
    </div>
  </div>
  <div class="control-group column-group half-gutters required">
    <label for="instituicao" class="align-right all-15 small-20 tiny-20">Instituição:</label>
    <div class="control prepend-symbol all-80">
      <span>
        <select name="instituicao" id="instituicao">
          <option label="(nenhuma)" value="0">(nenhuma)</option>
          {foreach $instituicoes as $instituicao}
            {if $instituicao.idinstituicao eq $FORM_VALUES.codigo_pais}
            <option label="{$instituicao.nome}"
                    value="{$instituicao.idinstituicao}" selected>{$instituicao.nome}</option>
            {else}
            <option label="{$instituicao.nome}"
                    value="{$instituicao.idinstituicao}">{$instituicao.nome}</option>
            {/if}
          {/foreach}
        </select>
        <i class="fa fa-institution"></i>
      </span>
    </div>
  </div>
  <div class="control-group column-group half-gutters">
    <label for="localidade" class="align-right all-15 small-20 tiny-20">Localidade:</label>
    <div class="control all-40">
      {if $FORM_VALUES.localidade}
      <input name="localidade" id="localidade" type="text"
             value="{$FORM_VALUES.localidade}"
             data-rules="text[true,false]">
      {else}
      <input name="localidade" id="localidade" type="text"
             data-rules="text[true,false]">
      {/if}
      <p class="tip">Cidade</p>
    </div>
    <div class="control all-40">
      <select name="codigo_pais" id="codigo_pais">
        <option label="(nenhum)" value="null">(nenhum)</option>
        {foreach from=$paises item=nomepais key=codigopais}
          {if $codigopais eq $FORM_VALUES.codigo_pais}
          <option label="{$nomepais}" value="{$codigopais}" selected>{$nomepais}</option>
          {else}
          <option label="{$nomepais}" value="{$codigopais}">{$nomepais}</option>
          {/if}
        {/foreach}
      </select>
      <p class="tip">País</p>
    </div>
  </div>
  <div class="control-group column-group half-gutters">
    <label for="avatar" class="align-right all-15 small-20 tiny-20">Avatar:</label>
    <div class="control all-85 small-80 tiny-80 no-margin">
      <div class="input-file">
        <input name="avatar" id="avatar" type="file">
      </div>
    </div>
  </div>
  <div class="control-group align-center">
    <button class="ink-button medium green" type="submit">
      <i class="fa fa-check fa-fw"></i>
      <span>Submeter</span>
    </button>
    <button class="ink-button medium red" type="reset">
      <i class="fa fa-close fa-fw"></i>
      <span>Limpar</span>
    </button>
  </div>
</fieldset>