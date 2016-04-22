{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid column-group push-center gutters half-bottom-padding">
  {include file='pesquisa/sidebar.tpl'}
  <div class="column all-80 medium-75 small-100 tiny-100">
  <h3 class="slab half-top-padding">Resultados da pesquisa</h3>
  {foreach $perguntas as $pergunta}
    <article class="question">
    <h5 class="slab quarter-vertical-space">
      <a class="black" href="view_question.html">{$pergunta.titulo}</a>
    </h5>
    <div class="condensed author-panel quarter-vertical-space">
      <div>
        <p class="no-margin">
          <a class="medium" href="view_profile.html">{$pergunta.nomeutilizador}</a>
          &bull;
          <small>{$pergunta.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
          &bull;
          <span class="medium">
            <strong>{$pergunta.numerorespostas}</strong>&nbsp;respostas
          </span>
          &bull;
          <span class="medium">
            <strong class="positive-score">{$pergunta.pontuacao}</strong>&nbsp;pontos
          </span>
        </p>
      </div>
    </div>
    <p class="medium no-margin align-justify">
      {$pergunta.descricao}
      <a class="black fw-700" href="view_question.html">ver mais <i class="fa fa-arrow-circle-right"></i></a>
    </p>
    </article>
    {if not $pergunta@last}
    <hr>
    {/if}
  {/foreach}
  </div>
</div>
{/block}