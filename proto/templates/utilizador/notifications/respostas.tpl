{foreach $respostas as $resposta}
<tr class="notification-row">
  <td class="medium">
    <b>
      {strip}
      <a class="black" href="{$BASE_URL}pages/pergunta/view.php?id={$resposta.idpergunta}">
        {$resposta.titulo}
      </a>
      <span class="ink-badge black">nova resposta!</span>
      {/strip}
    </b>
    <p class="quarter-vertical-space">
      <strong>{$resposta.nomeutilizador} respondeu:</strong>
      <span>{$resposta.descricao|strip_tags}</span>
    </p>
  </td>
  <td class="align-center">
    <i class="fa fa-user"></i>
    {strip}
    {if $resposta.removido}
      {$resposta.username}
    {else}
    <a href="{$BASE_URL}pages/utilizador/profile.php?id={$resposta.idutilizador}">
      {$resposta.username}
    </a>
    {/if}
    {/strip}
    <p>
      <small>{$resposta.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
    </p>
  </td>
  <td>
    <div class="button-group">
      <a href="{$BASE_URL}pages/pergunta/view.php?id={$resposta.idpergunta}#reply-{$resposta.idresposta}"
         class="all-50 ink-button ink-tooltip medium"
         data-tip-text="Ver resposta"
         data-tip-color="black">
        <i class="fa fa-external-link fa-fw"></i>
        <span class="hide-tiny hide-small hide-medium">Ver</span>
      </a>
      <a href="{$BASE_URL}actions/pergunta/unfollow.php?id={$resposta.idpergunta}"
         class="all-50 ink-button ink-tooltip medium dismiss"
         data-tip-text="Unfollow pergunta"
         data-tip-color="black">
        <i class="fa fa-close fa-fw"></i>
        <span class="hide-tiny hide-small hide-medium">Unfollow</span>
      </a>
    </div>
  </td>
</tr>
{/foreach}