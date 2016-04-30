{foreach $perguntas as $pergunta}
<div class="message half-vertical-space">
  <h5 class="slab quarter-vertical-space">
  <a class="black" href="{$BASE_URL}pages/pergunta/view.php?id={$pergunta.idpergunta}">{$pergunta.titulo}</a>
  {if not $pergunta.ativa}
  <span class="ink-badge black small">
    <i class="fa fa-check"></i>
    <span>fechada</span>
  </span>
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
        <a href="{$BASE_URL}pages/utilizador/profile.php?id={$pergunta.idutilizador}">{$pergunta.nomeutilizador}</a>
      {/if}
      </strong>
      <span class="small">({$pergunta.username})</span>
    </p>
    <p class="medium no-margin">
      <small>{$pergunta.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
      &bull;
      <span class="medium">
        <strong>{$pergunta.numerorespostas}</strong>
        {if $pergunta.numerorespostas eq 1}
        <span>Resposta</span>
        {else}
        <span>Respostas</span>
        {/if}
      </span>
    </p>
  </div>
  {if $pergunta.descricao}
  <div class="column all-100 medium align-justify">
    {$pergunta.descricao}
  </div>
  {/if}
  {if $USERID and $pergunta.ativa}
  <div class="button-toolbar quarter-vertical-space">
    <div class="button-group small">
      <a class="ink-button black" href="reply.php#reply-form">
        <i class="fa fa-pencil fa-fw"></i>
        <span>Responder</span>
      </a>
      <button class="ink-button black">
        <i class="fa fa-feed fa-fw"></i>
        <span>Seguir</span>
      </button>
    </div>
    <div class="button-group small">
      <button class="ink-button black">
        <i class="fa fa-thumbs-up fa-fw"></i>
        <span>Gosto&nbsp;</span>
        <strong>{$pergunta.votospositivos}</strong>
      </button>
      <button class="ink-button black">
        <i class="fa fa-thumbs-down fa-fw"></i>
        <span>Não gosto&nbsp;</span>
        <strong>{$pergunta.votosnegativos}</strong>
      </button>
    </div>
  </div>
  {/if}
</div>
{foreachelse}
<p class="condensed fw-600">Ainda não foram publicadas perguntas nesta instituição :(</p>
{/foreach}