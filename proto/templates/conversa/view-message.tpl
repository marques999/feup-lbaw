{foreach $mensagens as $mensagem}
<div class="message column-group half-vertical-space">
  <div class="column all-15 medium-20 small-25 tiny-25">
    {if $mensagem.removido}
    <strong>{$mensagem.username}</strong>
    {else}
    <strong>
      <a href="{$BASE_URL}pages/utilizador/profile.php?id={$mensagem.idutilizador}">{$mensagem.username}</a>
    </strong>
    {/if}
    <p class="medium no-margin">{$mensagem.sigla|upper}</p>
    <img class="avatar-medium half-vertical-space"
      src="{$mensagem.idutilizador|utilizador_getAvatar}"
      alt="{$mensagem.username}">
  </div>
  <div class="column all-85 medium-80 small-75 tiny-75">
    <div>
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
    <div class="medium">{$mensagem.descricao}</div>
  </div>
</div>
{/foreach}