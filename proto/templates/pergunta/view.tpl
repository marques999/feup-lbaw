{extends file='common/header.tpl'}
{block name=navigation}
  {include file='pergunta/view-mobile.tpl'}
{/block}
{block name=content}
<div class="ink-grid content-drawer column-group half-bottom-padding medium-gutters large-gutters xlarge-gutters">
  <div class="column all-20 medium-25 small-100 tiny-100 hide-small hide-tiny">
    {include file='pergunta/view-sidebar.tpl'}
  </div>
  <div class="column all-80 medium-75 small-100 tiny-100 half-bottom-padding">
    {include file='common/messages.tpl'}
    <section id="question-{$pergunta.idpergunta}" class="half-vertical-padding question-section">
      {include file='pergunta/view-pergunta.tpl'}
    </section>
    <b class="no-margin">Respostas ({$respostas|@count})</b>
    <hr class="quarter-vertical-space">
    {if $respostas|@count gt 0}
    <section id="answers">
      {include file='pergunta/view-respostas.tpl'}
    </section>
    {/if}
    {if not $pergunta.ativa}
    <small class="no-margin">
      <strong>Não pode responder a esta pergunta porque se encontra fechada.</strong>
    </small>
    {elseif not $USERID}
    <small class="no-margin">
      <strong>Deve encontrar-se autenticado para responder a esta pergunta!</strong>
    </small>
    {elseif $respostas|@count eq 0}
    <small class="no-margin">
      <strong>Ainda não foram publicadas respostas a esta pergunta :(</strong>
    </small>    
    {/if}
    {include file='pergunta/view-responder.tpl'}
  </div>
</div>
<script type="text/javascript" src="{$BASE_URL}javascript/pergunta.js"></script>
{/block}