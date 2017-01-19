{foreach $perguntas as $pergunta}
<div class="message half-vertical-space">
  <h5 class="slab quarter-vertical-space">
  <a class="black" href="{$BASE_URL}pages/pergunta/view.php?id={$pergunta.idpergunta}">{$pergunta.titulo}</a>
  {if not $pergunta.ativa}
  <div class="push-right condensed">
    <i class="fa fa-check"></i>
    <strong>fechada</strong>
  </div>
  {/if}
  </h5>
  <div class="align-center quarter-horizontal-padding push-right">
    {if $pergunta.pontuacao gt 0}
    <h3 class="positive-score no-margin">
      {$pergunta.pontuacao}
    </h3>
    {elseif $pergunta.pontuacao lt 0}
    <h3 class="negative-score no-margin">
      {$pergunta.pontuacao}
    </h3>
    {else}
    <h3 class="no-margin">
      {$pergunta.pontuacao}
    </h3>
    {/if}
    <p class="medium quarter-vertical-space">(
      {$pergunta.votospositivos}
      <i class="fa fa-thumbs-up"></i>&nbsp;
      {$pergunta.votosnegativos}
      <i class="fa fa-thumbs-down"></i>
    )</p>
  </div>
  <div class="half-vertical-space">
    <img class="avatar-small push-left quarter-horizontal-space"
         src="{$pergunta.idutilizador|utilizador_getAvatar}"
         alt="{$pergunta.username}">
    <p class="no-margin">
      <strong>
      {if $pergunta.removido}
        {$pergunta.nomeutilizador}
      {else}
        {strip}
        <a href="{$BASE_URL}pages/utilizador/profile.php?id={$pergunta.idutilizador}">
          {$pergunta.nomeutilizador}
        </a>
        {/strip}
      {/if}
      </strong>
      <span class="small">({$pergunta.username})</span>
    </p>
    <p class="medium no-margin">
      <small>{$pergunta.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
      &bull;
      <span class="medium">
        <strong>{$pergunta.respostas}</strong>
        {if $pergunta.respostas eq 1}
        <span>Resposta</span>
        {else}
        <span>Respostas</span>
        {/if}
      </span>
    </p>
  </div>
  {if $pergunta.descricao}
  <div class="column medium align-justify">
    {$pergunta.descricao}
  </div>
  {else}
  <div class="column align-justify">
    <small>Nenhuma descrição disponível.</small>
  </div>
  {/if}
</div>
{foreachelse}
<p class="condensed fw-600">Ainda não foram publicadas perguntas nesta categoria :(</p>
{/foreach}