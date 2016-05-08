<h4 class="slab half-vertical-space">Perfil</h4>
<table class="ink-table collapse fixed">
  <tbody>
    <tr>
      <td class="align-right">Grupo</td>
      <td>
        <small>{$grupo}<small>
      </td>
    </tr>
    {if $USERID eq $utilizador.idutilizador}
    <tr>
      <td class="align-right">Palavra-passe</td>
      <td>
        <small>* * * * * * * *</small>
        <a class="medium" id="update-password">(alterar)</a>
      </td>
    </tr>
    {/if}
    <tr>
      <td class="align-right">Membro desde</td>
      <td>
        <small>{$utilizador.dataregisto|date_format:"%A, %e %B %Y %H:%M"}</small>
      </td>
    </tr>
    <tr>
      <td class="align-right">Última sessão</td>
      <td>
        <small>{$utilizador.ultimasessao|date_format:"%A, %e %B %Y %H:%M"}</small>
      </td>
    </tr>
  </tbody>
</table>