{if {$ERROR_MESSAGES|count} gt 0}
<div class="no-margin column-group" id="error-messages">
  {foreach $ERROR_MESSAGES as $error}
    <div class="column ink-alert basic error">
      <button class="ink-dismiss">&times;</button>
      <p>{$error}</p>
    </div>
  {/foreach}
</div>
{/if}
{if {$SUCCESS_MESSAGES|count} gt 0}
<div class="column-group" id="success-messages">
  {foreach $SUCCESS_MESSAGES as $success}
  <div class="column ink-alert basic success">
    <button class="ink-dismiss">&times;</button>
    <p>{$success}</p>
  </div>
  {/foreach}
</div>
{/if}