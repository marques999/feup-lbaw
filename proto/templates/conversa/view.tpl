{extends file='common/header-editor.tpl'}
{block name=content}
<div class="ink-grid push-center all-100 xlarge-75 large-90 half-bottom-padding">
  <div class="message all-100 half-vertical-space">
    <h5 class="slab no-margin">
      <i class="fa fa-envelope fa-fw"></i>
      <a href="{$BASE_URL}pages/conversa/list.php" class="black">Mensagens Privadas</a>
      <strong>&gt;</strong>
      <a href="{$BASE_URL}pages/conversa/view.php?id={$conversa.idconversa}" class="black">{$conversa.titulo}</a>
    </h5>
  </div>
  {foreach $mensagens as $mensagem}
  <div class="message column-group half-vertical-space">
    <div class="column all-15 medium-20 small-25 tiny-25">
      <b class="no-margin"><a href="{$BASE_URL}pages/utilizador/profile.php?id={$mensagem.idutilizador}">{$mensagem.username}</a></b>
      <p class="medium no-margin">{$mensagem.sigla|upper}</p>
      <img class="avatar-medium half-vertical-space"
        src="{$mensagem.idutilizador|utilizador_getAvatar}"
        alt="{$mensagem.username}">
    </div>
    <div class="column all-85 medium-80 small-75 tiny-75">
      <div class="message-header">
        <b>{$mensagem.titulo}</b>
        <p class="slab">
          <small>
            <i class="fa fa-calendar"></i>
            {$mensagem.datahora|date_format:"%A, %e %B %Y %H:%M"}
          </small>
        </p>
      </div>
      <div class="message-content half-bottom-space">
        <p class="medium half-vertical-space">{$mensagem.descricao}</p>
      </div>
      <div class="message-buttons quarter-vertical-padding align-right">
        <small>
          <a href="#" class="ink-button black"><i class="fa fa-pencil"></i>&nbsp;Responder</a>
        </small>
        <small>
          <a href="#" class="ink-button black"><i class="fa fa-quote-right"></i>&nbsp;Citação</a>
        </small>
      </div>
    </div>
  </div>
  {/foreach}
  <div class="message half-vertical-space">
    <h5 class="slab no-margin">
      Responder
      <span class="push-right">
        <i class="fa fa-arrow-up fa-fw"></i>
      </span>
    </h5>
    <form action="actions/conversa/reply.php" method="post" class="ink-form ink-formvalidator quarter-gutters">
      <div class="control-group required half-vertical-space">
        <div class="control all-100">
          <textarea name="descricao" id="descricao" rows="8" cols="60" data-rules="required" placeholder="Por favor escreva aqui a sua mensagem..."></textarea>
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
</div>
{/block}
{block name=footer}
{/block}