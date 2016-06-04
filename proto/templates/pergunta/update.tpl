{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer column-group gutters">
  <div class="column all-20 medium-25 small-100 tiny-100">
    {include file='pergunta/update-sidebar.tpl'}
  </div>
  <div class="column all-80 medium-75 small-100 tiny-100 half-bottom-padding">
    <form action="{$BASE_URL}actions/pergunta/update.php" 
          class="ink-form ink-formvalidator"
          method="post"
          data-lang="pt_PT">
      {include file='pergunta/update-formulario.tpl'}
    </form>
    {if $USERID}
    <b class="no-margin">Respostas ({$respostas|@count})</b>
    {else}
    <b>Respostas ({$respostas|@count})</b>
    {/if}
    <hr class="quarter-vertical-space">
    {if $respostas|@count gt 0}
      {include file='pergunta/view-respostas.tpl'}
    {else}
      <p>
        <small>
        {if not $USERID}
          <strong>Deve encontrar-se autenticado para responder a esta pergunta!</strong>
        {else}
          <strong>Ainda não foram publicadas respostas a esta pergunta :(</strong>
        {/if}
        </small>
      </p>
    {/if}
  </div>
</div>
<script type="text/javascript" src="{$BASE_URL}ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/pergunta.js"></script>
{/block}