<li class="heading">
  <i class="fa fa-institution"></i>
  <span>Categorias</span>
</li>
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
<li class="heading">
  <i class="fa fa-exchange"></i>
  <span>Relacionadas</span>
</li>
{foreach $relacionadas as $relacionada}
<li>
  <a href="{$BASE_URL}pages/pergunta/view.php?id={$relacionada.idpergunta}">"{$relacionada.titulo|strip_tags}" --
    <small>{$relacionada.username}</small>
  </a>
</li>
{/foreach}
{if $ADMINISTRADOR or $MODERADOR or $USERID eq $pergunta.idutilizador}
  <li class="heading">
    <i class="fa fa-cog"></i>
    <span>Gestão</span>
  </li>
  {if $pergunta.ativa}
  <li>
    <a href="{$BASE_URL}pages/pergunta/update.php?id={$pergunta.idpergunta}">
      <span>Editar pergunta</span>
    </a>
  </li>
  <li>
    <a href="{$BASE_URL}actions/pergunta/close.php?id={$pergunta.idpergunta}">
      <span>Fechar pergunta</span>
    </a>
  </li>
  {else}
  <li>
    <a href="{$BASE_URL}actions/pergunta/enable.php?id={$pergunta.idpergunta}">
      <span>Activar pergunta</span>
    </a>
  </li>
  {/if}
  {if $ADMINISTRADOR OR $USERID eq $pergunta.idutilizador}
  <li>
    <a href="{$BASE_URL}pages/pergunta/delete.php?id={$pergunta.idpergunta}">
      <span>Apagar pergunta</span>
    </a>
  </li>
  {/if}
{/if}