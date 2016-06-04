{foreach $mensagens as $mensagem}
<div class="message column-group half-vertical-space">
  <div class="column all-15 medium-20 small-25 tiny-25">
    {if $mensagem.removido}
    <strong>{$mensagem.username}</strong>
    {else}
    {strip}
    <strong>
      <a href="{$BASE_URL}pages/utilizador/profile.php?id={$mensagem.idutilizador}">
        {$mensagem.username}
      </a>
    </strong>
    {/strip}
    {/if}
    <p class="medium no-margin">{$mensagem.sigla|upper}</p>
    <img class="avatar-medium half-vertical-space"
      src="{$mensagem.idutilizador|utilizador_getAvatar}"
      alt="{$mensagem.username}">
  </div>
  <div class="column all-85 medium-80 small-75 tiny-75">
    <div class="message-header">
      {if $mensagem@index gt 0}
      <b>RE: {$conversa.titulo}</b>
      {else}
      <b>{$conversa.titulo}</b>
      {/if}
      <p class="slab">
        <small>
          <i class="fa fa-calendar"></i>
          <span>{$mensagem.datahora|date_format:"%A, %e %B %Y %H:%M"}</span>
        </small>
      </p>
    </div>
    <div class="message-content medium half-bottom-space">
      {$mensagem.descricao}
    </div>
    <div class="message-buttons condensed medium quarter-vertical-padding align-right">
      {if $mensagem.idutilizador neq $USERID and not $mensagem.removido}
        <a href="#reply-form" class="ink-button reply-button black">
          <i class="fa fa-pencil fa-fw"></i>
          <span>Responder</span>
        </a>
        <a href="#reply-form" class="ink-button quote-button black">
          <i class="fa fa-quote-right fa-fw"></i>
          <span>Citar</span>
        </a>
      {/if}
    </div>
  </div>
</div>
{/foreach}