{foreach $respostas as $resposta}
<article id="reply-{$resposta.idresposta}">
  <div class="column all-100">
    {if not $resposta.removido}
    <div class="ink-dropdown quarter-vertical-space"
         data-target="#answer{$resposta.idresposta}-dropdown"
         data-hover-open="0.2"
         data-dismiss-after="0.2">
    {/if}
      <img class="avatar-medium push-left quarter-padding"
           src="{$resposta.idutilizador|utilizador_getAvatar}"
           alt="{$resposta.username}">
      {if not $resposta.removido}
      <ul id="answer{$resposta.idresposta}-dropdown" class="dropdown-menu vertical-space">
        <li class="heading">
          {$resposta.username}
        </li>
        <li class="separator-above">
          <a href="{$BASE_URL}pages/utilizador/profile.php?id={$resposta.idutilizador}">
            <i class="fa fa-user fa-fw"></i>
            <span>Ver Perfil</span>
          </a>
        </li>
        {if $moderador}
        <li>
          <a href="{$BASE_URL}pages/utilizador/report.php?id={$resposta.idutilizador}">
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
          <a href="{$BASE_URL}pages/conversa/view.php?id={$resposta.idutilizador}">
            <i class="fa fa-envelope fa-fw"></i>
            <span>Enviar Mensagem</span>
          </a>
        </li>
        {/if}
      </ul>
    </div>
    {/if}
    <div class="horizontal-padding quarter-vertical-padding">
      <p class="no-margin">
        <strong>
          {if $resposta.removido}
            {$resposta.nomeutilizador}
          {else}
          <a href="{$BASE_URL}pages/utilizador/profile.php?id={$resposta.idutilizador}">{$resposta.nomeutilizador}</a>
          {/if}
        </strong>
        <small class="small">
          ({$resposta.username})
        </small>
      </p>
      <p class="medium no-margin">
        {$resposta.sigla|upper}
      </p>
    </div>
  </div>
  <div class="column all-100">
    <div class="medium quarter-vertical-padding align-justify">
      {$resposta.descricao}
    </div>
    <p class="condensed quarter-bottom-space">
      <small>Enviada {$resposta.datahora|date_format:"%A, %e %B %Y %H:%M"}&nbsp;&nbsp;|&nbsp;</small>
      <a class="ink-toggle medium show-comments"
         data-id="{$resposta.idresposta}"
         data-target="#reply{$resposta.idresposta}-comments">
        <strong>{$resposta.numerocomentarios}</strong>
        <span>Comentários</span>
      </a>
    </p>
  </div>
  <div id="reply{$resposta.idresposta}-comments" class="message half-vertical-space medium hide-all">
    {if $USERID and $pergunta.ativa}
    <form action="#" method="POST" class="ink-form answer-comments-form ink-formvalidation medium">
      <div class="control-group">
        <input type="hidden" name="idResposta" value="{$resposta.idresposta}">
        <div class="control all-80 small-70 tiny-60">
          <input type="text" name="descricao" id="descricao" placeholder="Escreva um comentário...">
        </div>
        <div class="control all-20 small-30 tiny-40">
           <button type="submit" id="submit" name="submit" class="ink-button black all-100">Submeter</button>
        </div>
      </div>
    </form>
    {/if}
    <small>Ainda não foram publicados comentários a esta resposta :(</small>
  </div>
  {if $USERID and $pergunta.ativa}
  <div class="medium no-margin button-toolbar">
    {if $USERID eq $pergunta.idutilizador}
    <div class="button-group">
      <button class="ink-button black">
        <i class="fa fa-heart fa-fw"></i>
        <span>Destacar</span>
      </button>
    </div>
    {/if}
    <div class="reply-buttons button-group">
      <button class="vote-positive ink-button black">
        <i class="fa fa-thumbs-up fa-fw"></i>
        <span>Gosto&nbsp;</span>
        <strong>{$resposta.votospositivos}</strong>
      </button>
      <button class="vote-negative ink-button black">
        <i class="fa fa-thumbs-down fa-fw"></i>
        <span>Não gosto&nbsp;</span>
        <strong>{$resposta.votosnegativos}</strong>
      </button>
    </div>
  </div>
  {/if}
{if not $resposta@last}
<hr class="half-vertical-space">
{/if}
</article>
{foreachelse}
<strong>Seja um dos primeiros a responder a esta pergunta!</strong>
{/foreach}