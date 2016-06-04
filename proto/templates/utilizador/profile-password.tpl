<div class="ink-shade fade">
  <div id="update-password-modal" class="ink-modal" data-trigger="#update-password"
      data-width="800px"
      data-height="28%"
      data-responsive="true"
      data-close-on-click="true">
    <div class="modal-body">
      <form action="{$BASE_URL}actions/utilizador/update_password.php" method="post" class="ink-form ink-formvalidator medium push-center" data-lang="pt_PT">
      <input name="idUtilizador" id="idUtilizador" type="hidden" value="{$utilizador.idutilizador}">
      <div class="control-group column-group half-gutters required">
        <label for="current-password" class="align-right all-25 small-45 tiny-45">Old Password:</label>
        <div class="control append-symbol all-75 small-55 tiny-55">
          <span>
            <input name="current-password" id="current-password" type="password" data-rules="required" placeholder="Please enter your current password">
            <i class="fa fa-key"></i>
          </span>
        </div>
      </div>
      <div class="control-group column-group half-gutters required">
        <label for="new-password" class="align-right all-25 small-45 tiny-45">New Password:</label>
        <div class="control append-symbol all-75 small-55 tiny-55">
          <span>
            <input name="new-password" id="new-password" type="password" data-rules="required|min_length[8]" placeholder="Please enter your new password">
            <i class="fa fa-key"></i>
          </span>
        </div>
      </div>
      <div class="control-group column-group half-gutters required">
        <label for="confirm-password" class="align-right all-25 small-45 tiny-45">Confirm Password:</label>
        <div class="control append-symbol all-75 small-55 tiny-55">
          <span>
            <input name="confirm-password" id="confirm-password" type="password" data-rules="required|min_length[8]" placeholder="Please confirm your new password">
            <i class="fa fa-key"></i>
          </span>
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
    </form>
    </div>
  </div>
</div>