{extends file='common/header.tpl'}
{block name=content}
  {include file='common/page-fullscreen.tpl'}
  {include file='pergunta/blocks/sidebar.tpl'}
  <div class="column all-80 medium-75 small-100 tiny-100">
    <section id="question-{$pergunta.idpergunta}" class="half-vertical-padding">
    {include file='pergunta/blocks/pergunta.tpl'}
    </section>
    {if $USERID}
    <b class="no-margin">Respostas ({$respostas|@count})</b>
    {else}
    <b>Respostas ({$respostas|@count})</b>
    {/if}
    <hr class="quarter-vertical-space">
    <section id="answers" class="push-center all-90 small-100 tiny-100">
    {include file='pergunta/blocks/respostas.tpl'}
    </section>
  </div>
  <script type="text/javascript" src="{$BASE_URL}javascript/pergunta.js"></script>
{/block}