<article class="question">
  <h4 class="slab quarter-vertical-space">
  <a class="black" href="view/1">{$question.title}</a>
  {if not $question.active}
    <span class="ink-badge black small"><i class="fa fa-check"></i>fechada</span>
  {/if}
</h4>
<div class="align-center quarter-padding push-right">
  {if $question.score gt 0}
    <h3 class="quarter-vertical-space positive-score">
  {elseif $question.score lt 0}
    <h3 class="quarter-vertical-space negative-score">
  {else}
    <h3 class="quarter-vertical-space">
  {/if}
  {$question.score}
  </h3>
  <p class="medium">(
  {$question.votosPositivos}
  <i class="fa fa-thumbs-up"></i>
  {$question.votosNegativos}
  <i class="fa fa-thumbs-down"></i>
  )</p>
</div>
<div class="author-panel quarter-vertical-space">
  <img class="img-circle push-left quarter-padding" src="holder.js/64x64/auto/ink" alt="">
  <div class="half-padding">
    <p class="no-margin">
      <a href="profile/2"><strong>{$question.idAutor}</strong></a>
      <span class="small">FEUP</span>
    </p>
    <p class="medium no-margin">
      <small>Terça-feira, 1 de Março de 2016</small>
      &bull;
      <span class="medium">
        <strong>{$question.numberAnswers}</strong>&nbsp;Respostas
      </span>
    </p>
  </div>
</div>
{$question.content}
<div class="button-toolbar quarter-top-padding">
  <div class="button-group small">
    <a class="ink-button black" href="reply.php#reply-form">
      <i class="fa fa-pencil"></i>&nbsp;Responder
    </a>
    <button class="ink-button black">
      <i class="fa fa-feed"></i>&nbsp;Seguir&nbsp;
      <strong>{$question.numberFollowers}</strong>
    </button>
  </div>
  <div class="button-group small">
    <button class="ink-button black">
      <i class="fa fa-thumbs-up"></i>&nbsp;Gosto&nbsp;
      <strong>{$question.votosPositivos}</strong>
    </button>
    <button class="ink-button black">
      <i class="fa fa-thumbs-down"></i>&nbsp;Não gosto&nbsp;
      <strong>{$question.votosNegativos}</strong>
    </button>
  </div>
</div>
</article>
{if not $question@last}
  <hr>
{/if}