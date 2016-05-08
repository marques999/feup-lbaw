{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid">
  <div class="message all-100 half-vertical-space">
    <h5 class="slab no-margin">
      <i class="fa fa-user fa-fw"></i>
      <a href="{$BASE_URL}pages/utilizador/profile.php" class="black">Utilizador</a>
      &nbsp;<i class="fa fa-angle-right"></i>&nbsp;
      <a href="{$BASE_URL}pages/conversa/list.php" class="black">Mensagens Privadas</a>
    </h5>
  </div>
  <table class="ink-table alternating hover">
    <thead>
      <th style="width:25%">Conversa</th>
      <th>Mensagens</th>
      <th>Última Mensagem</th>
      <th style="width:20%">Autor</th>
    </thead>
    <tbody>
    {foreach $conversas as $conversa}
    <tr>
      <td class="fw-700">
        <img class="avatar-medium push-left quarter-padding"
             src="{$conversa.iddestinatario|utilizador_getAvatar}"
             alt="{$conversa.nomedestinatario}">
        <div class="half-vertical-padding all-50 medium-20 small-30">
          <p class="no-margin">
          {strip}
            <a href="{$BASE_URL}pages/conversa/view.php?id={$conversa.idconversa}">
              {$conversa.nomedestinatario}
            </a>
          {/strip}
          </p>
          <note class="medium">{$conversa.sigla|upper}</note>
        </div>
      </td>
      <td class="align-center fw-700">{$conversa.numeromensagens}</td>
      <td class="medium">
      {strip}
        <p class="half-vertical-space">
          <strong>{$conversa.titulo}</strong>
          {if $conversa.dataHora >= $conversa.ultimoAcesso}
          <span class="ink-badge black">novas mensagens!</span>
          {/if}
        </p>
        {if $conversa.dataHora < $conversa.ultimoAcesso}
        <p class="quarter-vertical-space">{$conversa.descricao|strip_tags}</p>
        {else}
        <p class="quarter-vertical-space">
          <strong>{$conversa.descricao|strip_tags}</strong>
        </p>
        {/if}
      {/strip}
      </td>
      <td class="fw-700">
        <i class="fa fa-user"></i>
        {if $conversa.removido}
          {$conversa.nomeautor}
        {else}
          {strip}
          <a href="{$BASE_URL}pages/utilizador/profile.php?id={$conversa.idautor}">
            {$conversa.nomeautor}
          </a>
          {/strip}
        {/if}
        <p>
          <small>{$conversa.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
        </p>
      </td>
    </tr>
    {/foreach}
    </tbody>
  </table>
</div>
{/block}