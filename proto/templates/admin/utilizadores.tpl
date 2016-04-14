{include file='admin/header.tpl'}
{include file='admin/navigation.tpl'}
<h3 class="condensed all-75">Utilizadores Activos
  <span class="fw-300 medium">(4)</span>
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
      <th>Username</th>
      <th>E-mail</th>
      <th>Pontuação</th>
      <th>Perguntas</th>
      <th>Atividade</th>
    </tr>
  </thead>
  <tbody class="align-center">
  {foreach $users as $user}
    {if $user.ativo}
    <tr>
      <td class="align-left">
        <i class="fa fa-user"></i>
        <a href="view_profile.html">{$user.primeiroNome} {$user.ultimoNome}</a>
        <small>({$user.username})</small>
      </td>
      <td>
        <small>{$user.email}</small>
      </td>
      <td class="medium fw-700 positive-score">{$user.pontuacao}</td>
      <td class="medium">{$user.numeroPerguntas}</td>
      <td>
        <small>{$user.ultimoAcesso}</small>
      </td>
    </tr>
    {/if}
  {/foreach}
  </tbody>
</table>
<div class="top-space">
<h3 class="condensed all-75">Utilizadores Banidos
  <span class="fw-300 medium">(1)</span>
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
      <th>Pontuação</th>
      <th>Perguntas</th>
      <th style="width:25%">Acções</th>
    </tr>
  </thead>
  <tbody>
  {foreach $users as $user}
    {if not $user.ativo}
    <tr class="align-center">
      <td class="align-left">
        <i class="fa fa-user"></i>
        <a href="view_profile.html">{$user.primeiroNome} {$user.ultimoNome}</a>
        <small>({$user.username})</small>
      </td>
      <td>
        <small>{$user.email}</small>
      </td>
      <td class="medium fw-700 negative-score">{$user.pontuacao}</td>
      <td class="medium">{$user.numeroPerguntas}</td>
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
    {/if}
  {/foreach}
  </tbody>
</table>
{include file='admin/footer.tpl'}