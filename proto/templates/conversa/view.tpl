{extends file='common/header-editor.tpl'}
{block name=content}
<div class="ink-grid push-center all-100 xlarge-75 large-90 half-bottom-padding">
  <div class="message all-100 half-vertical-space">
    <h5 class="slab no-margin">
      <i class="fa fa-envelope fa-fw"></i>
      {strip}
      <a href="{$BASE_URL}pages/conversa/list.php" class="black">
        <span>Mensagens Privadas</span>
      </a>
      {/strip}
      <i class="fa fa-angle-right"></i>
      {strip}
      <a href="{$BASE_URL}pages/conversa/view.php?id={$conversa.idconversa}" class="black">
        <span>{$conversa.titulo}</span>
      </a>
      {/strip}
    </h5>
  </div>
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
            {$mensagem.datahora|date_format:"%A, %e %B %Y %H:%M"}
          </small>
        </p>
      </div>
      <div class="message-content medium half-bottom-space">
        {$mensagem.descricao}
      </div>
      <div class="message-buttons quarter-vertical-padding align-right">
        {if $mensagem.idutilizador neq $USERID and not $mensagem.removido}
        <small>
          <a href="#reply-form" class="ink-button reply-button black">
            <i class="fa fa-pencil fa-fw"></i>
            <span>Responder</span>
          </a>
        </small>
        <small>
          <a href="#reply-form" class="ink-button quote-button black">
            <i class="fa fa-quote-right fa-fw"></i>
            <span>Citar</span>
          </a>
        </small>
        {/if}
      </div>
    </div>
  </div>
  {/foreach}
  <div id="reply-form" class="message half-vertical-space">
    <h5 class="slab no-margin">
      <span>Responder</span>
      <span class="push-right">
        <i class="fa fa-arrow-up fa-fw"></i>
      </span>
    </h5>
    {if $conversa.remetenteremovido or $conversa.destinatarioremovido}
    <p class="condensed half-vertical-space">Não pode responder a esta conversa :(</p>
    {else}
    <form action="{$BASE_URL}actions/conversa/reply.php" method="post" class="ink-form quarter-gutters">
      <input name="idConversa" id="idConversa" type="hidden" value="{$conversa.idconversa}">
      <div class="control-group half-vertical-space">
        <div class="control all-100">
          <textarea name="descricao" id="descricao" rows="8" cols="60">
          </textarea>
        </div>
      </div>
      <div class="control-group">
        <div class="align-center">
          <button class="ink-button small black" type="submit">
            <i class="fa fa-pencil fa-fw"></i>
            <span>Responder</span>
          </button>
          <button class="ink-button small black" type="reset">
            <i class="fa fa-eraser fa-fw"></i>
            <span>Limpar</span>
          </button>
        </div>
      </div>
    </form>
  </div>
  {/if}
</div>
<script type="text/javascript" src="{$BASE_URL}javascript/conversa.js"></script>
{/block}
{block name=footer}
{/block}