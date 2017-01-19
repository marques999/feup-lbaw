<thead>
  <tr>
    <th style="width:50%">Evento</th>
    <th style="width:25%">Autor</th>
    <th style="width:25%">Acções</th>
  </tr>
</thead>
<tbody>
  {foreach $notificacoes as $notificacao}
  <tr class="notification-row">
    <td class="medium">
      <b>
        {strip}
        <a class="black" href="{$BASE_URL}pages/pergunta/view.php?id={$notificacao.idpergunta}">
          {$notificacao.titulo}
        </a>
        <span class="ink-badge black">{$notificacao.accao1}</span>
        {/strip}
      </b>
      <p class="quarter-vertical-space">
        <strong>{$notificacao.nomeutilizador} {$notificacao.accao2}:</strong>
        <span>{$notificacao.descricao|strip_tags}</span>
      </p>
    </td>
    <td class="align-center">
      <i class="fa fa-user"></i>
      {if $notificacao.removido}
        {$notificacao.username}
      {else}
      <a href="{$BASE_URL}pages/utilizador/profile.php?id={$notificacao.idutilizador}">{$notificacao.username}</a>
      {/if}
      <p>
        <small>{$notificacao.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
      </p>
    </td>
    <td>
      <div class="button-group">
        {if $notificacao.idresposta}
        <a href="{$BASE_URL}pages/pergunta/view.php?id={$notificacao.idpergunta}#reply-{$notificacao.idresposta}"
           class="all-50 ink-button ink-tooltip medium"
           data-tip-text="Ver resposta"
           data-tip-color="black">
        {else}
        <a href="{$BASE_URL}pages/pergunta/view.php?id={$notificacao.idpergunta}"
           class="all-50 ink-button ink-tooltip medium"
           data-tip-text="Ver pergunta"
           data-tip-color="black">
        {/if}
          <i class="fa fa-external-link fa-fw"></i>
          <span class="hide-tiny hide-small hide-medium">Ver</span>
        </a>
        <a href="{$BASE_URL}actions/pergunta/unfollow.php?id={$notificacao.idpergunta}"
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
</tbody>