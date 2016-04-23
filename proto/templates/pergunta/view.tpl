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
    {if $pergunta.ativa and $USERID neq $pergunta.idutilizador}
      {include file='pergunta/blocks/formulario.tpl'}
    {/if}
  </div>
  <script type="text/javascript" src="{$BASE_URL}javascript/pergunta.js"></script>
  <script>
  $(function() {
    $("#answers a.ink-toggle").click(function() {  
      fetchAnswerComments(
        $(this).data('id'),
        $(this));
    });
    $(".question-action-buttons .follow-button").click(function() {
      followPergunta(
        $(this), 
        $(this.parentNode.parentNode.parentNode).get(0).id);
    });
    $(".question-vote-buttons .vote-positive").click(function() {
      registarVotoPergunta(
        $(this), 
        $(this.parentNode.parentNode.parentNode).get(0).id,
        1);
    });
    $(".question-vote-buttons .vote-negative").click(function() {
      registarVotoPergunta(
        $(this), 
        $(this.parentNode.parentNode.parentNode).get(0).id,
        -1);
    });
    $(".reply-buttons .vote-positive").click(function() {
      registarVotoResposta(
        $(this), 
        $(this.parentNode.parentNode.parentNode).get(0).id,
         1);
    });
    $(".reply-buttons .vote-negative").click(function() {
      registarVotoResposta(
        $(this), 
        $(this.parentNode.parentNode.parentNode).get(0).id,
        -1);
    });
    $('.question-comments-form').submit(function(event) {
      submeterComentarioPergunta($(this));
      event.preventDefault();
    });
    $('.answer-comments-form').submit(function(event) {
      submeterComentarioResposta($(this));
      event.preventDefault();
    });
  });
  </script>
{/block}