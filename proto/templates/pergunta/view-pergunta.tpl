<h3 class="slab quarter-vertical-space">
  {strip}
    {$pergunta.titulo}
  {if not $pergunta.ativa}
  <span class="ink-badge black small">
    <i class="fa fa-check"></i>
  {/strip}
    <span class="medium">fechada</span>
  </span>
  {/if}
</h3>
<div class="column all-100">
  {if not $pergunta.removido}
  <div class="ink-dropdown"
       data-target="#question-dropdown"
       data-hover-open="0.2"
       data-dismiss-after="0.2">
  {/if}
    <img class="avatar-medium push-left quarter-padding"
        src="{$pergunta.idutilizador|utilizador_getAvatar}"
        alt="{$pergunta.username}">
    {if not $pergunta.removido}
    <ul id="question-dropdown" class="dropdown-menu vertical-space">
      <li class="heading">
        {$pergunta.username}
      </li>
      <li class="separator-above">
        <a href="{$BASE_URL}pages/utilizador/profile.php?id={$pergunta.idutilizador}">
          <i class="fa fa-user fa-fw"></i>
          <span>Ver Perfil</span>
        </a>
      </li>
      {if $moderador}
      <li>
        <a href="{$BASE_URL}pages/utilizador/report.php?id={$pergunta.idutilizador}">
          <i class="fa fa-flag fa-fw"></i>
          <span>Denunciar</span>
        </a>
      </li>
      {else}
      <li class="disabled">
        <a href="#">
          <i class="fa fa-flag fa-fw"></i>
          <span>Denunciar</span>
        </a>
      </li>
      {/if}
      {if not $USERID or $USERID eq $pergunta.idutilizador}
      <li class="disabled">
        <a href="#">
         <i class="fa fa-envelope fa-fw"></i>
          <span>Enviar Mensagem</span>
        </a>
      </li>
      {else}
      <li>
        <a href="{$BASE_URL}pages/conversa/view.php?id={$pergunta.idutilizador}">
          <i class="fa fa-envelope fa-fw"></i>
          <span>Enviar Mensagem</span>
        </a>
      </li>
      {/if}
    </ul>
  </div>
  {/if}
  <div class="half-horizontal-padding quarter-vertical-padding">
    <p class="no-margin">
      <strong>
      {strip}
        {if $pergunta.removido}
          {$pergunta.nomeutilizador}
        {else}
          <a href="{$BASE_URL}pages/utilizador/profile.php?id={$pergunta.idutilizador}">
            {$pergunta.nomeutilizador}
          </a>
        {/if}
      {/strip}
      </strong>
      <small class="small">({$pergunta.username})</small>
    <p class="medium no-margin">
      {$pergunta.sigla|upper}
    </p>
  </div>
</div>
<div class="column all-100 quarter-vertical-space">
  {if $pergunta.descricao}
  <div class="medium quarter-vertical-padding align-justify">
    {$pergunta.descricao}
  </div>
  {/if}
  <p class="condensed no-margin">
    <small>Enviada {$pergunta.datahora|date_format:"%A, %e %B %Y %H:%M"}&nbsp;&nbsp;|&nbsp;</small>
    <a id="show-comments" class="ink-toggle medium" data-target="#question-comments">
      <strong>{$comentarios|@count}</strong>
      <span>Comentários</span>
    </a>
  </p>
</div>
<div id="question-comments" class="message medium half-vertical-space hide-all">
  {if $USERID and $pergunta.ativa}
  <form action="#" method="POST" class="ink-form ink-formvalidation medium question-comments-form">
    <div class="control-group">
      <input type="hidden" name="idPergunta" value="{$pergunta.idpergunta}">
      <div class="control all-80 small-70 tiny-60">
        <input type="text" name="descricao" id="descricao" placeholder="Escreva um comentário...">
      </div>
      <div class="control all-20 small-30 tiny-40">
         <button type="submit" id="submit" name="submit" class="ink-button black all-100">Submeter</button>
      </div>
    </div>
  </form>
  {/if}
  {foreach $comentarios as $comentario}
  <div class="column quarter-vertical-space">
    <img class="avatar-small push-left quarter-right-space"
         src="{$comentario.idutilizador|utilizador_getAvatar}"
         alt="{$comentario.nomeutilizador}">
    {strip}
      {if $comentario.removido}
        {$comentario.nomeutilizador}
      {else}
      <a href="{$BASE_URL}pages/utilizador/profile.php?id={$comentario.idutilizador}">
        {$comentario.nomeutilizador}
      </a>
      {/if}
    {/strip}
    <small>
      {$comentario.datahora|date_format:"%A, %e %B %Y %H:%M"}
    </small>
    <p class="fw-medium">
      {$comentario.descricao}
    </p>
  </div>
  {foreachelse}
  <small>
    <span>Ainda não foram publicados comentários a esta pergunta :(</span>
  </small>
  {/foreach}
</div>
{if $USERID and $pergunta.ativa}
<div class="button-toolbar">
  <div class="button-group question-action-buttons">
    <a href="#reply-form" class="ink-button medium black">
      <i class="fa fa-pencil fa-fw"></i>
      <span>Responder</span>
    </a>
    {if $utilizador.idseguidor}
    <button class="ink-button follow-button medium black active">
      <i class="fa fa-check fa-fw"></i>
      <span>Following&nbsp;</span>
    {else}
    <button class="ink-button follow-button medium black">
      <i class="fa fa-feed fa-fw"></i>
      <span>Follow&nbsp;</span>
    {/if}
      <strong>{$pergunta.numeroseguidores}</strong>
    </button>
  </div>
  <div class="button-group question-vote-buttons">
  {if $USERID and $USERID eq $pergunta.idutilizador}
    <button class="ink-button medium black">
      <i class="fa fa-thumbs-up fa-fw"></i>
      <span>Gostos&nbsp;</span>
      <strong>{$pergunta.votospositivos}</strong>
    </button>
    <button class="ink-button medium black">
      <i class="fa fa-thumbs-down fa-fw"></i>
      <span>Não gostos&nbsp;</span>
      <strong>{$pergunta.votosnegativos}</strong>
    </button>
  {else}
    {if $utilizador.valor eq 1}
    <button class="vote-positive ink-button medium black active">
      <i class="fa fa-thumbs-up fa-fw"></i>
      <span>Gostei&nbsp;</span>
      <strong>{$pergunta.votospositivos}</strong>
    </button>
    {else}
    <button class="vote-positive ink-button medium black">
      <i class="fa fa-thumbs-up fa-fw"></i>
      <span>Gosto&nbsp;</span>
      <strong>{$pergunta.votospositivos}</strong>
    </button>
    {/if}
    {if $utilizador.valor eq -1}
    <button class="vote-negative ink-button medium black active">
      <i class="fa fa-thumbs-down fa-fw"></i>
      <span>Não gostei&nbsp;</span>
      <strong>{$pergunta.votosnegativos}</strong>
    </button>
    {else}
    <button class="vote-negative ink-button medium black">
      <i class="fa fa-thumbs-down fa-fw"></i>
      <span>Não gosto&nbsp;</span>
      <strong>{$pergunta.votosnegativos}</strong>
    </button>    
    {/if}
  {/if}
  </div>
</div>
{/if}