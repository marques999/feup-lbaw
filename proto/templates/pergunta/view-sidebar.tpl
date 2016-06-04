<nav class="ink-navigation medium vertical-padding">
  <h5 class="slab half-vertical-space">
    <i class="fa fa-institution"></i>
    <span>Categorias</span>
  </h5>
  <ul class="menu vertical white">
  {strip}
    {foreach $categorias as $categoria}
      {if $categoria.idcategoria eq $pergunta.idcategoria}
      <li class="active">
        <a href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a>
      </li>
      {else}
      <li>
        <a href="{$BASE_URL}pages/categoria/view.php?id={$categoria.idcategoria}">{$categoria.nome}</a>
      </li>
      {/if}
    {/foreach}
  {/strip}
  </ul>
  <h5 class="slab half-vertical-space">
    <i class="fa fa-exchange"></i>
    <span>Relacionadas</span>
  </h5>
  <ul class="menu vertical white">
  {foreach $relacionadas as $relacionada}
    <li><a href="{$BASE_URL}pages/pergunta/view.php?id={$relacionada.idpergunta}">"{$relacionada.titulo|strip_tags}" --
      <small>{$relacionada.username}</small>
    </a></li>
  {/foreach}
  </ul>
  {if $administrador or $moderador or $USERID eq $pergunta.idutilizador}
  <h5 class="slab half-vertical-space">
    <i class="fa fa-cog"></i>
    <span>Gestão</span>
  </h5>
  <ul class="menu vertical white">
    <li><a href="{$BASE_URL}pages/pergunta/update.php?id={$pergunta.idpergunta}">
      <strong><sup>({$privileges})</sup></strong>
      <span>Editar pergunta</span>
    </a></li>
    <li><a href="{$BASE_URL}pages/pergunta/close.php?id={$pergunta.idpergunta}">
      <strong><sup>({$privileges})</sup></strong>
      <span>Fechar pergunta</span>
    </a></li>
    {if $administrador OR $USERID eq $pergunta.idutilizador}
    <li><a href="{$BASE_URL}pages/pergunta/delete.php?id={$pergunta.idpergunta}">
      <strong><sup>({$privileges})</sup></strong>
      <span>Apagar pergunta</span>
    </a></li>
    {/if}
  </ul>
  {/if}
</nav>