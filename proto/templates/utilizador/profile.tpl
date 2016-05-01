{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid column-group half-gutters">
  <div class="column half-padding all-30 large-40 medium-40 small-100 tiny-100">
    <div class="half-padding push-right">
      <img src="{$BASE_URL}images/flags/{$utilizador.codigopais}.png" alt="">
    </div>
    <div>
      <h2 class="slab no-margin">{$utilizador.username}</h2>
      <p class="no-margin">{$utilizador.nomeutilizador}</p>
      <a href="{$BASE_URL}pages/user/update.php?field=5">
      <img class="half-vertical-space"
        src="{$utilizador.idutilizador|utilizador_getAvatar}"
        alt="{$utilizador.username}">
      </a>
    </div>
    <p class="no-margin">
      {if $USERID eq $utilizador.idutilizador}
      <a class="ink-tooltip" href="#" data-tip-text="Alterar instituição" data-tip-color="black">
        <i class="fa fa-plus-circle"></i>
      </a>
      {else}
      <i class="fa fa-institution"></i>
      {/if}
      <strong>Instituição:</strong>
      <a href="{$BASE_URL}pages/instituicao/view.php?id={$utilizador.sigla}">{$utilizador.sigla|upper}</a>
      <a href="{$utilizador.website}"><i class="fa fa-external-link"></i></a>
    </p>
    <p class="no-margin">
      {if $USERID eq $utilizador.idutilizador}
      <a class="ink-tooltip" id="update-password" href="#" data-tip-text="Alterar endereço de e-mail" data-tip-color="black">
        <i class="fa fa-plus-circle"></i>
      </a>
      {else}
      <i class="fa fa-envelope"></i>
      {/if}
      <strong>E-mail:</strong>
      {mailto address=$utilizador.email}
    </p>
    <p class="no-margin">
      {if $USERID eq $utilizador.idutilizador}
      <a class="ink-tooltip" href="#" data-tip-text="Alterar localização" data-tip-color="black">
        <i class="fa fa-plus-circle"></i>
      </a>
      {else}
      <i class="fa fa-globe"></i>
      {/if}
      <strong>Localização:</strong>
      {$utilizador.localidade}, {$utilizador.codigopais|utilizador_getCountry}
    </p>
    {if $USERID eq $utilizador.idutilizador}
      {include file='utilizador/update_password.tpl'}
    {/if}
  </div>
  <div class="column half-padding all-70 large-60 medium-60 small-100 tiny-100 top">
    <h4 class="slab half-vertical-space">Perfil</h4>
    <div class="column-group half-gutters">
      <div class="column align-left all-20">
        <p class="quarter-vertical-space">
          <strong>Grupo &gt;</strong>
        </p>
        <p class="quarter-vertical-space">
          <strong>Membro desde &gt;</strong>
        </p>
        <p class="quarter-vertical-space">
          <strong>Última sessão &gt;</strong>
        </p>
      </div>
      <div class="column all-80">
        <p class="quarter-vertical-space">{$grupo}</p>
        <p class="quarter-vertical-space">{$utilizador.dataregisto|date_format:"%A, %e %B %Y %H:%M"}</p>
        <p class="quarter-vertical-space">{$utilizador.ultimasessao|date_format:"%A, %e %B %Y %H:%M"}</p>
      </div>
    </div>
    {include file='utilizador/blocks/perguntas.tpl'}
    {include file='utilizador/blocks/respostas.tpl'}
  </div>
</div>
{/block}