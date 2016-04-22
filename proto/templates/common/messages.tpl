<div id="error_messages">
  {foreach $ERROR_MESSAGES as $error}
    <div class="column ink-alert basic error">
      <button class="ink-dismiss">&times;</button>
      <p>{$error}</p>
    </div>
  {/foreach}
</div>
<div id="success_messages">
  {foreach $SUCCESS_MESSAGES as $success}
  <div class="column ink-alert basic success">
    <button class="ink-dismiss">&times;</button>
    <p>{$success}</p>
  </div>
  {/foreach}
</div>