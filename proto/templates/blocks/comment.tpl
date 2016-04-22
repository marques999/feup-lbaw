<div class="column half-vertical-space">
  {assign var='avatar' value=$comentario.idutilizador|utilizador_getAvatar}
  <img class="push-left avatar-small img-circle quarter-right-space" src="{$avatar}" alt="">
  <a href="{$BASE_URL}pages/utilizador/profile.php?id={$comentario.idutilizador}">{$comentario.nomeutilizador}</a>
  <small>{$comentario.datahora|date_format:"%A, %e %B %Y %H:%M"}</small>
  <p class="fw-medium">{$comentario.descricao}</p>
</div>