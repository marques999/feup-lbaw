{extends file='admin/utilizadores-table.tpl'}
{block name=rows}
{foreach $banidos as $utilizador}
<tr>
  <td class="align-left">
    <i class="fa fa-user"></i>
    {strip}
    <a href="{$BASE_URL}pages/utilizador/profile.php?id={$utilizador.idutilizador}">
      {$utilizador.nomeutilizador}
    </a>
    {/strip}
    <small>({$utilizador.username})</small>
  </td>
  <td>
    <small>{$utilizador.email}</small>
  </td>
  <td class="medium">{$utilizador.numeroperguntas}</td>
  <td class="medium">{$utilizador.numerorespostas}</td>
  <td>
    <small>{$utilizador.ultimasessao|date_format:"%d/%m/%Y %H:%M"}</small>
  </td>
  <td class="medium">
    <button class="ink-button medium" disabled>banir</button>
    <a href="{$BASE_URL}pages/utilizador/delete.php?id={$utilizador.idutilizador}"
       class="ink-button medium">apagar</a>
  </td>
</tr>
{/foreach}
{/block}