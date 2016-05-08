{foreach $comentarios as $comentario}
<tr class="notification-row">
  <td class="medium">
    <b>
      {strip}
      <a class="black" href="{$BASE_URL}pages/pergunta/view.php?id={$comentario.idpergunta}">
        {$comentario.titulo}
      </a>
      <span class="ink-badge black">novo comentário!</span>
      {/strip}
    </b>
    <p class="quarter-vertical-space">
      <strong>{$comentario.nomeutilizador} comentou:</strong>
      <span>{$comentario.descricao|strip_tags}</span>
    </p>
  </td>
  <td class="align-center">
    <i class="fa fa-user"></i>
    {strip}
    {if $comentario.removido}
      {$comentario.username}
    {else}
    <a href="{$BASE_URL}pages/utilizador/profile.php?id={$comentario.idutilizador}">
      {$comentario.username}
    </a>
    {/if}
    {/strip}
    <p>
      <small>{$comentario.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
    </p>
  </td>
  <td>
    <div class="button-group">
      <a href="{$BASE_URL}pages/pergunta/view.php?id={$comentario.idpergunta}"
         class="all-50 ink-button ink-tooltip medium"
         data-tip-text="Ver pergunta"
         data-tip-color="black">
        <i class="fa fa-external-link fa-fw"></i>
        <span class="hide-tiny hide-small hide-medium">Ver</span>
      </a>
      <a href="{$BASE_URL}actions/pergunta/unfollow.php?id={$comentario.idpergunta}"
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