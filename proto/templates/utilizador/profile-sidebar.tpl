{if $USERID and $utilizador.codigopais}
<div class="half-padding push-right">
  <img src="{$BASE_URL}images/flags/{$utilizador.codigopais}.png" alt="">
</div>
{/if}
<div>
  <h2 class="slab no-margin">{$utilizador.username}</h2>
  <p class="no-margin">
    {if $USERID eq $utilizador.idutilizador}
    <a class="ink-tooltip"
       href="{$BASE_URL}pages/utilizador/update.php"
       data-tip-text="Alterar nome"
       data-tip-color="black">
      <i class="fa fa-plus-circle"></i>
    </a>
    {elseif $ADMINISTRADOR}
    <a class="ink-tooltip"
       href="{$BASE_URL}pages/utilizador/update.php?id={$utilizador.idutilizador}"
       data-tip-text="Alterar nome"
       data-tip-color="black">
      <i class="fa fa-plus-circle"></i>
    </a>
    {/if}
    {$utilizador.nomeutilizador}
  </p>
  <div class="align-center quarter-vertical-space">
    {if $USERID eq $utilizador.idutilizador}
    <a href="{$BASE_URL}pages/utilizador/update.php">
      <img class="half-vertical-space"
           src="{$utilizador.idutilizador|utilizador_getAvatar}"
           alt="{$utilizador.username}">
    </a>
    {elseif $ADMINISTRADOR}
    <a href="{$BASE_URL}pages/utilizador/update.php?id={$utilizador.idutilizador}">
      <img class="half-vertical-space"
           src="{$utilizador.idutilizador|utilizador_getAvatar}"
           alt="{$utilizador.username}">
    </a>
    {else}
    <img class="half-vertical-space"
         src="{$utilizador.idutilizador|utilizador_getAvatar}"
         alt="{$utilizador.username}">
    {/if}
  </div>
</div>
<p class="no-margin">
  {if $USERID eq $utilizador.idutilizador}
  <a class="ink-tooltip"
     href="{$BASE_URL}pages/utilizador/update.php"
     data-tip-text="Alterar instituição"
     data-tip-color="black">
    <i class="fa fa-plus-circle"></i>
  </a>
  {elseif $ADMINISTRADOR}
  <a class="ink-tooltip"
     href="{$BASE_URL}pages/utilizador/update.php?id={$utilizador.idutilizador}"
     data-tip-text="Alterar instituição"
     data-tip-color="black">
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
  <a class="ink-tooltip"
     href="{$BASE_URL}pages/utilizador/update.php"
     data-tip-text="Alterar endereço de e-mail"
     data-tip-color="black">
    <i class="fa fa-plus-circle"></i>
  </a>
  {elseif $ADMINISTRADOR}
  <a class="ink-tooltip"
     href="{$BASE_URL}pages/utilizador/update.php?id={$utilizador.idutilizador}"
     data-tip-text="Alterar endereço de e-mail"
     data-tip-color="black">
    <i class="fa fa-plus-circle"></i>
  </a>
  {else}
  <i class="fa fa-envelope"></i>
  {/if}
  <strong>E-mail:</strong>
  {mailto address=$utilizador.email}
</p>
{if $USERID}
<p class="no-margin">
  {if $USERID eq $utilizador.idutilizador}
  <a class="ink-tooltip"
     href="{$BASE_URL}pages/utilizador/update.php"
     data-tip-text="Alterar localização"
     data-tip-color="black">
    <i class="fa fa-plus-circle"></i>
  </a>
  {elseif $ADMINISTRADOR}
  <a class="ink-tooltip"
     href="{$BASE_URL}pages/utilizador/update.php?id={$utilizador.idutilizador}"
     data-tip-text="Alterar localização"
     data-tip-color="black">
    <i class="fa fa-plus-circle"></i>
  </a>
  {else}
  <i class="fa fa-globe"></i>
  {/if}
  {if $utilizador.localidade or $utilizador.codigopais}
  <strong>Localização:</strong>
  {/if}
  {strip}
    {if $utilizador.localidade}
      {$utilizador.localidade}
    {/if}
    {if $utilizador.codigopais}
      , {$utilizador.codigopais|utilizador_getCountry}
    {/if}
  {/strip}
</p>
{/if}