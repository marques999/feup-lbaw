{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid content-drawer column-group gutters">
  <div class="column all-20 medium-25 small-100 tiny-100">
    {include file='pergunta/view-sidebar.tpl'}
  </div>
  <div class="column all-80 medium-75 small-100 tiny-100 half-bottom-padding">
    {include file='common/messages.tpl'}
    <section id="question-{$pergunta.idpergunta}" class="half-vertical-padding">
      {include file='pergunta/view-pergunta.tpl'}
    </section>
    {if $USERID}
    <b class="no-margin">Respostas ({$respostas|@count})</b>
    {else}
    <b>Respostas ({$respostas|@count})</b>
    {/if}
    <hr class="quarter-vertical-space">
    {if $respostas|@count gt 0}
    <section id="answers" class="half-bottom-padding">
      {include file='pergunta/view-respostas.tpl'}
    </section>
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
    {if $USERID and $USERID neq $pergunta.idutilizador}
      {if $pergunta.ativa}
        {include file='pergunta/view-responder.tpl'}  
      {else}
        <strong>Não pode responder a esta pergunta porque se encontra fechada.</strong>
      {/if}
    {/if}
  </div>
</div>
<script type="text/javascript" src="{$BASE_URL}ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="{$BASE_URL}javascript/pergunta.js"></script>
{/block}