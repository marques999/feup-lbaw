{extends file='other/header.tpl'}
{block name=content}
<form action="{$BASE_URL}actions/utilizador/login.php" method="post" class="ink-form ink-formvalidator">
  <fieldset>
    <legend class="slab align-center">Autenticação</legend>
    <div class="control-group column-group half-gutters">
      <label for="username" class="all-25 align-right">Username:</label>
      <div class="control append-symbol all-75">
        <span>
          <input name="username" id="username" type="text" data-rules="required" placeholder="Por favor introduza aqui o seu username...">
          <i class="fa fa-user"></i>
        </span>
      </div>
    </div>
    <div class="control-group column-group half-gutters">
      <label for="password" class="all-25 align-right">Password:</label>
      <div class="control append-symbol all-75">
        <span>
          <input name="password" id="password" type="password" data-rules="required" placeholder="Por favor introduza aqui a sua password...">
          <i class="fa fa-key"></i>
        </span>
      </div>
    </div>
    <div class="column-group half-gutters">
      <div class="control-group all-15 small-5 tiny-5">
      </div>
      <div class="control-group all-25 small-30 tiny-30">
        <div class="control">
          <input class="ink-button black" type="submit" id="submit" name="submit" value="Validar">
        </div>
      </div>
      <div class="control-group all-50 small-60 tiny-60">
        <div class="control">
          <input class="ink-button black" type="button" id="reset" name="reset" value="Recuperar Password">
        </div>
      </div>
    </div>
    <div class="control-group column-group">
      <p class="align-center no-margin">Não se encontra registado?
        <a href="{$BASE_URL}pages/utilizador/register.php">Registe-se aqui!</a>
      </p>
    </div>
  </fieldset>
</form>
{/block}