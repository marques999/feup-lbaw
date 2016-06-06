<tr>
  <td class="fw-700">
    <img class="avatar-medium push-left quarter-padding"
         src="{$conversa.iddestinatario|utilizador_getAvatar}"
         alt="{$conversa.nomedestinatario}">
    <div class="half-vertical-padding all-50 medium-20 small-30">
      <p class="no-margin">
        <a href="{$BASE_URL}pages/conversa/view.php?id={$conversa.idconversa}">{$conversa.nomedestinatario}</a>
      </p>
      <note class="medium">{$conversa.sigla|upper}</note>
    </div>
  </td>
  <td class="align-center fw-700">
    {$conversa.numeromensagens}
  </td>
  <td class="medium">
  {strip}
    <p class="half-vertical-space">
      <strong>{$conversa.titulo}</strong>
    </p>
    <p class="quarter-vertical-space">
      {$conversa.descricao|strip_tags}
    </p>
  {/strip}
  </td>
  <td class="fw-700">
    <i class="fa fa-user"></i>
    {if $conversa.removido}
      {$conversa.nomeautor}
    {else}
      <a href="{$BASE_URL}pages/utilizador/profile.php?id={$conversa.idutilizador}">{$conversa.nomeautor}</a>
    {/if}
    <p>
      <small>{$conversa.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
    </p>
  </td>
</tr>