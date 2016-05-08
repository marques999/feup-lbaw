{extends file='common/header.tpl'}
{block name=navigation}
{/block}
{block name=content}
<div class="ink-grid push-center all-100 xlarge-55 large-75 medium-95">
<div class="column-group half-gutters">
<div class="column horizontal-padding half-vertical-space">
  <div class="all-75 push-center">
    <img src="{$BASE_URL}images/assets/header.png" alt="">
  </div>
</div>
<form action="{$BASE_URL}actions/utilizador/register.php" method="post" enctype="multipart/form-data" class="ink-form medium ink-formvalidator" data-lang="pt_PT">
  <fieldset>
    <legend class="align-center">Registar Conta</legend>
    <div class="control-group column-group half-gutters required">
      <label for="username" class="align-right all-15 small-20 tiny-20">Username:</label>
      <div class="control append-symbol all-80">
        <span>
          <input name="username" id="username" type="text" data-rules="required|alpha_numeric" placeholder="Por favor introduza um username válido">
          <i class="fa fa-user"></i>
        </span>
      </div>
    </div>
    <div class="control-group column-group half-gutters required">
      <label for="password" class="align-right all-15 small-20 tiny-20">Password:</label>
      <div class="control append-symbol all-80">
        <span>
          <input name="password" id="password" type="password" data-rules="required|text[false,true]|min_length[8]" placeholder="Por favor introduza uma palavra-passe">
          <i class="fa fa-key"></i>
        </span>
      </div>
    </div>
    <div class="control-group column-group half-gutters required">
      <label for="primeiro-nome" class="align-right all-15 small-20 tiny-20">Nome:</label>
      <div class="control all-40">
        <input name="primeiro-nome" id="primeiro-nome" type="text" data-rules="required|alpha" placeholder="(não pode conter espaços)">
        <p class="tip">Primeiro nome</p>
      </div>
      <div class="control all-40">
        <input name="ultimo-nome" id="ultimo-nome" type="text" data-rules="required|alpha" placeholder="(não pode conter espaços)">
        <p class="tip">Último nome</p>
      </div>
    </div>
    <div class="control-group column-group half-gutters required">
      <label for="email" class="align-right all-15 small-20 tiny-20">E-mail:</label>
      <div class="control append-symbol all-80">
        <span>
          <input name="email" id="email" type="text" data-rules="required|email" placeholder="Por favor introduza um endereço de e-mail válido">
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
            <option label="{$instituicao.nome}" value="{$instituicao.idinstituicao}">{$instituicao.nome}</option>
            {/foreach}
          </select>
          <i class="fa fa-institution"></i>
        </span>
      </div>
    </div>
    <div class="control-group column-group half-gutters">
      <label for="localidade" class="align-right all-15 small-20 tiny-20">Localidade:</label>
      <div class="control all-40">
        <input name="localidade" id="localidade" type="text" data-rules="text[true,false]" placeholder="Por favor introduza a sua cidade de residência">
        <p class="tip">Cidade</p>
      </div>
      <div class="control all-40">
        <select name="codigo-pais" id="codigo-pais">
          <option label="(nenhum)" value="null">(nenhum)</option>
          {foreach from=$paises item=nomepais key=codigopais}
          <option label="{$nomepais}" value="{$codigopais}">{$nomepais}</option>
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
        <div class="ink-alert basic">
          <p class="medium">
            <strong>NOTA:</strong>
            <span>tamanho da imagem não deve exceder 200KB!</span>
          </p>
        </div>
      </div>
    </div>
    <div class="control-group column-group half-gutters align-center">
      <button class="ink-button" type="submit">Submeter</button>
      <button class="ink-button" type="reset">Limpar</button>
    </div>
  </fieldset>
</form>
</div>
</div>
{/block}
{block name=footer}
{/block}