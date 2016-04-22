<div class="column all-20 medium-25 small-100 tiny-100">
  <nav class="ink-navigation medium vertical-padding">
    <h5 class="slab half-vertical-space">
      <i class="fa fa-institution"></i>&nbsp;FEUP
    </h5>
    <ul class="menu vertical white">
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
      {if $categorias@count gt 5}
        <li class="heading"><a href="hub.php">ver mais...</a></li>
      {/if}
    </ul>
    <h5 class="slab half-vertical-space">
      <i class="fa fa-exchange"></i>&nbsp;Relacionadas
    </h5>
    <ul class="menu vertical white">
      <li>
        <a href="{$BASE_URL}pages/pergunta/view.php?id=1">"Que país tem a pior gastronomia na vossa opinião?" --
          <small>mellus</small>
        </a>
      </li>
      <li>  
        <a href="{$BASE_URL}pages/pergunta/view.php?id=2">"Qual foi o comentário mais hilariante que encontraram em código?" --
          <small>darklord</small>
        </a>
      </li>
      <li><a href="view/1">"Quem é considerado o melhor programador de todos os tempos?" -- <small>marques999</small></a></li>
    </ul>
    {if $USERID eq $pergunta.idutilizador}
      <h5 class="slab half-vertical-space">
        <i class="fa fa-cog"></i>&nbsp;Gestão
      </h5>
      <ul class="menu vertical white">
        <li>
          <a href="{$BASE_URL}pages/pergunta/edit.php">
            <strong><sup>(OP)</sup></strong>
            <span>Editar pergunta</span>
          </a>
        </li>
        <li>
          <a href="{$BASE_URL}pages/pergunta/delete.php">
            <strong><sup>(OP)</sup></strong>
            <span>Apagar pergunta</span>
          </a>
        </li>
      </ul>
    {/if}
  </nav>
</div>