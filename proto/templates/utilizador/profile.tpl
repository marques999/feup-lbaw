{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid column-group half-gutters">
  <div class="column half-padding all-30 large-40 medium-40 small-100 tiny-100">
    <div class="half-padding push-right">
      <img src="{$BASE_URL}images/flags/{$utilizador.codigopais}.png" alt="">
    </div>
    <div>
      <h2 class="slab no-margin">{$utilizador.username}</h2>
      <p class="no-margin">
        {if $USERID eq $utilizador.idutilizador}
        <a class="ink-tooltip" href="{$BASE_URL}pages/utilizador/edit.php" data-tip-text="Alterar nome" data-tip-color="black">
          <i class="fa fa-plus-circle"></i>
        </a>
        {/if}
        {$utilizador.nomeutilizador}
      </p>
      <div class="align-center quarter-vertical-space">
        <a href="{$BASE_URL}pages/user/update_photo.php?id={$utilizador.idutilizador}">
          <img class="half-vertical-space" src="{$utilizador.idutilizador|utilizador_getAvatar}" alt="{$utilizador.username}">
        </a>
      </div>
    </div>
    <p class="no-margin">
      {if $USERID eq $utilizador.idutilizador}
      <a class="ink-tooltip" href="{$BASE_URL}pages/utilizador/edit.php" data-tip-text="Alterar instituição" data-tip-color="black">
        <i class="fa fa-plus-circle"></i>
      </a>
      {else}
      <i class="fa fa-institution"></i>
      {/if}
      <strong>Instituição:</strong>
      {if $utilizador.sigla}
      <a href="{$BASE_URL}pages/instituicao/view.php?id={$utilizador.sigla}">{$utilizador.sigla|upper}</a>
      <a href="{$utilizador.website}"><i class="fa fa-external-link"></i></a>
      {else}
      N/A
      {/if}
    </p>
    <p class="no-margin">
      {if $USERID eq $utilizador.idutilizador}
      <a class="ink-tooltip" href="{$BASE_URL}pages/utilizador/edit.php" data-tip-text="Alterar endereço de e-mail" data-tip-color="black">
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
      <a class="ink-tooltip" href="{$BASE_URL}pages/utilizador/edit.php" data-tip-text="Alterar localização" data-tip-color="black">
        <i class="fa fa-plus-circle"></i>
      </a>
      {else}
      <i class="fa fa-globe"></i>
      {/if}
      {if $utilizador.localidade or $utilizador.codigopais}
      <strong>Localização:</strong>
      {/if}
      {if $utilizador.localidade}
        {$utilizador.localidade},
      {/if}
      {if $utilizador.codigopais}
        {$utilizador.codigopais|utilizador_getCountry}
      {/if}
    </p>
    {if $USERID eq $utilizador.idutilizador}
      {include file='utilizador/update_password.tpl'}
    {/if}
  </div>
  <div class="column half-padding all-70 large-60 medium-60 small-100 tiny-100 top">
    {include file='utilizador/profile/informacoes.tpl'}
    {include file='utilizador/profile/perguntas.tpl'}
    {include file='utilizador/profile/respostas.tpl'}
  </div>
</div>
{/block}