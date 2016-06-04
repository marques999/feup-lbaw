<div id="category-panel" class="column all-75 medium-65 quarter-top-padding">
  <h4 class="quarter-vertical-space slab">{$categoria.nome}</h4>
  <p class="condensed">
    <i class="fa fa-institution"></i>
    {$instituicoes_count}
    {if $instituicoes_count eq 1} instituição
    {else} instituições
    {/if}
    &nbsp;
    <i class="fa fa-question-circle"></i>
    {$perguntas_count}
    {if $perguntas_count eq 1} pergunta
    {else} perguntas
    {/if}
  </p>
  {if $descricao}
  <p id="category-description" class="no-margin medium">
    <span>{$descricao}</span>
    <a class="black fw-700" href="https://pt.wikipedia.org/wiki/{$categoria.nome}">ver mais</a>
    <i class="fa fa-arrow-circle-right"></i>
  </p>
  <p class="quarter-vertical-space">
    <small>
      <strong>Fonte:</strong>
      <span>Wikipédia</span>
    </small>
  </p>
  {else}
  <p class="quarter-vertical-space medium">
    Nenhuma descrição disponível na Wikipédia para esta categoria.
  </p>
  {/if}
  <p class="no-margin quarter-vertical-padding">
    <a class="ink-button black medium" href="{$BASE_URL}pages/pergunta/ask.php?id={$categoria.idcategoria}">
      <i class="fa fa-plus"></i>
      <span>&nbsp;Fazer pergunta</span>
    </a>
  </p>
</div>
<div class="column all-25 medium-35 quarter-padding">
  <img src="{$BASE_URL}images/assets/question-marks.png" alt="">
</div>