{extends file='admin/common/pagina.tpl'}
{block name=content}
{if $ativos_count gt 0}
<h3 class="condensed all-75">Utilizadores Activos
  <span class="fw-300 medium">({$ativos_count})</span>
</h3>
<form class="ink-form medium all-25">
  <div class="column-group horizontal-gutters">
    <div class="control-group">
      <div class="control append-symbol">
      <span>
        <input type="text" name="search" placeholder="Pesquisar utilizador...">
        <i class="fa fa-search"></i>
      </span>
      </div>
    </div>
  </div>
</form>
<table class="ink-table alternating hover"> 
  <thead>
    <tr>
      <th data-sortable="true">Username</th>
      <th data-sortable="true">E-mail</th>
      <th data-sortable="true">Perguntas</th>
      <th data-sortable="true">Respostas</th>
      <th data-sortable="true">Atividade</th>
    </tr>
  </thead>
  <tbody class="align-center">
  {foreach $ativos as $utilizador}
    <tr>
      <td class="align-left">
        <i class="fa fa-user"></i>
         <a href="{$BASE_URL}pages/utilizador/profile.php?id={$utilizador.idutilizador}">{$utilizador.nomeutilizador}</a>
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
    </tr>
  {/foreach}
  </tbody>
</table>
{/if}
{if $inativos_count gt 0}
<h3 class="condensed all-75">Utilizadores Inativos
  <span class="fw-300 medium">({$inativos_count})</span>
</h3>
<form class="ink-form medium all-25">
  <div class="column-group horizontal-gutters">
    <div class="control-group">
      <div class="control append-symbol">
      <span>
        <input type="text" name="search" placeholder="Pesquisar utilizador...">
        <i class="fa fa-search"></i>
      </span>
      </div>
    </div>
  </div>
</form>
<table class="ink-table alternating hover"> 
  <thead>
    <tr>
      <th data-sortable="true">Username</th>
      <th data-sortable="true">E-mail</th>
      <th data-sortable="true">Perguntas</th>
      <th data-sortable="true">Respostas</th>
      <th data-sortable="true">Atividade</th>
    </tr>
  </thead>
  <tbody class="align-center">
  {foreach $inativos as $utilizador}
    <tr>
      <td class="align-left">
        <i class="fa fa-user"></i>
        <a href="{$BASE_URL}pages/utilizador/profile.php?id={$utilizador.idutilizador}">{$utilizador.nomeutilizador}</a>
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
    </tr>
  {/foreach}
  </tbody>
</table>
{/if}
{if $banidos_count gt 0}
<div class="top-space">
<h3 class="condensed all-75">Utilizadores Banidos
  <span class="fw-300 medium">({$banidos_count})</span>
</h3>
<form class="ink-form medium all-25">
  <div class="column-group horizontal-gutters">
    <div class="control-group">
      <div class="control append-symbol">
      <span>
        <input type="text" name="search" placeholder="Pesquisar utilizador...">
        <i class="fa fa-search"></i>
      </span>
      </div>
    </div>
  </div>
</form>
</div>
<table class="ink-table alternating hover">
  <thead>
    <tr>
      <th>Username</th>
      <th>E-mail</th>
      <th>Perguntas</th>
      <th>Respostas</th>
      <th style="width:25%">Acções</th>
    </tr>
  </thead>
  <tbody>
  {foreach $banidos as $utilizador}
    <tr class="align-center">
      <td class="align-left">
        <i class="fa fa-user"></i>
        <a href="{$BASE_URL}pages/utilizador/profile.php?id={$utilizador.idutilizador}">{$utilizador.nomeutilizador}</a>
        <small>({$utilizador.username})</small>
      </td>
      <td>
        <small>{$utilizador.email}</small>
      </td>
      <td class="medium">{$utilizador.numeroperguntas}</td>
      <td class="medium">{$utilizador.numerorespostas}</td>
      <td>
        <small>
          <button class="ink-button">
            <i class="fa fa-check"></i>
            <span>Activar</span>
          </button>
        </small>
        <small>
          <button class="ink-button">
            <i class="fa fa-user-times"></i>
            <span>Apagar</span>
          </button>
        </small>
      </td>
    </tr>
  {/foreach}
  </tbody>
</table>
{/if}
{/block}