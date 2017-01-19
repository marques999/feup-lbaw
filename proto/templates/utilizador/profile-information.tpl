{include file='common/messages.tpl'}
<h4 class="slab half-vertical-space">Perfil</h4>
<table class="ink-table collapse fixed">
  <tbody>
    <tr>
      <td class="align-left">Grupo</td>
      <td>
        <small>{$grupo}</small>
      </td>
    </tr>
    {if $USERID eq $utilizador.idutilizador}
    <tr>
      <td class="align-left">Palavra-passe</td>
      <td>
        <small>* * * * * * * *</small>
        <a class="medium" href="{$BASE_URL}pages/utilizador/password.php">(alterar)</a>
      </td>
    </tr>
    {/if}
    <tr>
      <td class="align-left">Membro desde</td>
      <td>
        <small>{$utilizador.dataregisto|date_format:"%A, %e %B %Y %H:%M"}</small>
      </td>
    </tr>
    <tr>
      <td class="align-left">Última sessão</td>
      <td>
        <small>{$utilizador.ultimasessao|date_format:"%A, %e %B %Y %H:%M"}</small>
      </td>
    </tr>
  </tbody>
</table>