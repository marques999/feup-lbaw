<input name="location" id="location" type="hidden" value="{$location}">
<fieldset>
  <legend class="slab align-center">Autenticação</legend>
  <div class="control-group column-group half-gutters">
    <label for="username" class="all-20 align-right">Username:</label>
    <div class="control append-symbol all-75">
      <span>
        <input name="username" id="username" type="text" data-rules="required|alpha_numeric" placeholder="Por favor introduza o seu username">
        <i class="fa fa-user"></i>
      </span>
    </div>
  </div>
  <div class="control-group column-group half-gutters">
    <label for="password" class="all-20 align-right">Password:</label>
    <div class="control append-symbol all-75">
      <span>
        <input name="password" id="password" type="password" data-rules="required|text[true,false]" placeholder="Por favor introduza a sua palavra-passe">
        <i class="fa fa-key"></i>
      </span>
    </div>
  </div>
  <div class="control-group column-group half-gutters">
    <div class="control all-15">
    </div>
    <div class="control all-25">
      <input class="ink-button black" id="submit" name="submit" type="submit" value="Validar">
    </div>
    <div class="control all-45">
      <input class="ink-button black" id="reset" name="reset" type="button" value="Recuperar Password">
    </div>
  </div>
  <div class="control-group column-group half-gutters">
    <p class="align-center no-margin">Não se encontra registado?
      <a href="{$BASE_URL}pages/utilizador/register.php">Registe-se aqui!</a>
    </p>
  </div>
</fieldset>