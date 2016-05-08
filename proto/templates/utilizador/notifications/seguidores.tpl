{foreach $seguidores as $seguidor}
<tr class="notification-row">
  <td class="medium">
    <b>
      {strip}
      <a class="black" href="{$BASE_URL}pages/pergunta/view.php?id={$seguidor.idpergunta}">
        {$seguidor.titulo}
      </a>
      <span class="ink-badge black">novo seguidor!</span>
      {/strip}
    </b>
    <p class="quarter-vertical-space">
      <strong>{$seguidor.nomeutilizador} seguiu:</strong>
      <span>{$seguidor.descricao|strip_tags}</span>
    </p>
  </td>
  <td class="align-center">
    <i class="fa fa-user"></i>
    {strip}
    {if $seguidor.removido}
      {$seguidor.username}
    {else}
    <a href="{$BASE_URL}pages/utilizador/profile.php?id={$seguidor.idutilizador}">
      {$seguidor.username}
    </a>
    {/if}
    {/strip}
    <p>
      <small>{$seguidor.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
    </p>
  </td>
  <td>
    <div class="button-group">
      <a href="{$BASE_URL}pages/pergunta/view.php?id={$seguidor.idpergunta}"
         class="all-50 ink-button ink-tooltip medium"
         data-tip-text="Ver pergunta"
         data-tip-color="black">
        <i class="fa fa-external-link fa-fw"></i>
        <span class="hide-tiny hide-small hide-medium">Ver</span>
      </a>
      <a href="{$BASE_URL}actions/pergunta/unfollow.php?id={$seguidor.idpergunta}"
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