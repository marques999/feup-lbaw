<?
  include('templates/header_login.php');
?>
<div class="ink-grid overlay half-vertical-padding push-center xlarge-45 large-60 medium-80 all-100">
  <div class="column double-horizontal-padding half-vertical-space">
    <img src="img/header.png" alt="">
  </div>
  <form action="index_user.php" method="post" class="ink-form ink-formvalidator">
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
      <div class="column-group half-horizontal-gutters">
        <div class="control-group all-15 small-5 tiny-5">
        </div>
        <div class="control-group all-25 small-30 tiny-30">
          <div class="control append-symbol">
            <span>
              <input class="ink-button black" type="submit" id="submit" name="submit" value="Validar">
              <i class="fa fa-check"></i>
            </span>
          </div>
        </div>
        <div class="control-group all-45 small-60 tiny-60">
          <div class="control append-symbol">
            <span>
              <input class="ink-button black" type="button" id="reset" name="reset" value="Recuperar Password">
              <i class="fa fa-exclamation-triangle"></i>
              </span>
            </span>
          </div>
        </div>
      </div>
      <div class="control-group column-group">
        <p class="align-center no-margin">Não se encontra registado?
          <a href="user_register.php">Registe-se aqui!</a>
        </p>
      </div>
    </fieldset>
  </form>
</div>
<?
  include('templates/footer_empty.php');
?>