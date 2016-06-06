{extends file='other/header.tpl'}
{block name='content'}
<h3 class="slab align-center">Administração</h3>
<hr>
<div class="column-group hide-small hide-tiny half-vertical-space">
  <a href="{$BASE_URL}pages/admin/categorias.php">
    <div class="column ink-button black all-33">
      <div class="huge-button">
        <i class="fa fa-database"></i>
      </div>
      <h4 class="condensed half-vertical-space">Gerir Categorias</h4>
    </div>
  </a>
  <a href="{$BASE_URL}pages/admin/instituicoes.php">
    <div class="column ink-button black all-33">
      <div class="huge-button">
        <i class="fa fa-institution"></i>
      </div>
      <h4 class="condensed half-vertical-space">Gerir Instituições</h4>
    </div>
  </a>
  <a href="{$BASE_URL}pages/admin/utilizadores.php">
    <div class="column ink-button black all-33">
      <div class="huge-button">
        <i class="fa fa-users"></i>
      </div>
      <h4 class="condensed half-vertical-space">Gerir Utilizadores</h4>
    </div>
  </a>
</div>
<div class="column-group hide-all show-small show-tiny half-vertical-space">
  <a href="{$BASE_URL}pages/admin/categorias.php">
    <div class="column all-100 ink-button black">
      <div class="huge-button all-25 push-left">
        <i class="fa fa-database"></i>
      </div>
      <h2 class="condensed all-75 vertical-space">Gerir Categorias</h2>
    </div>
  </a>
  <a href="{$BASE_URL}pages/admin/instituicoes.php">
    <div class="column all-100 ink-button black">
      <div class="huge-button all-25 push-left">
        <i class="fa fa-institution"></i>
      </div>
      <h2 class="condensed all-75 vertical-space">Gerir Instituições</h2>
    </div>
  </a>
  <a href="{$BASE_URL}pages/admin/utilizadores.php">
    <div class="column all-100 ink-button black">
      <div class="huge-button all-25 push-left">
        <i class="fa fa-users"></i>
      </div>
      <h2 class="condensed all-75 vertical-space">Gerir Utilizadores</h2>
    </div>
  </a>
</div>
<hr>
<h4 class="condensed align-center no-margin">Utilizador:
  <a href="{$BASE_URL}pages/utilizador/profile.php?id={$USERID}">{$USERNAME}</a>
</h4>
{/block}