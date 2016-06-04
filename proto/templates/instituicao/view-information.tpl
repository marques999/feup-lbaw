<div class="column all-75 medium-65 quarter-vertical-padding">
  <h4 class="quarter-vertical-space slab">{$instituicao.nome}</h4>
  <p class="condensed">
    <i class="fa fa-institution"></i>
    {strip}
    <span>
    {$categorias_count}
    {if $categorias_count eq 1} categoria
    {else} categorias
    {/if}
    </span>
    {/strip}
    &nbsp;
    <i class="fa fa-question-circle"></i>
    {strip}
    <span>
    {$perguntas_count}
    {if $perguntas_count eq 1} pergunta
    {else} perguntas
    {/if}
    </span>
    {/strip}
  </p>
  <p class="medium quarter-vertical-space">
    <strong>Morada:</strong>
    <addr>{$instituicao.morada}</addr>
  </p>
  <p class="medium quarter-vertical-space">
    <strong>Telefone:</strong>
    <span>{$instituicao.contacto}</span>
  </p>
</div>
<div class="column all-25 medium-35 quarter-padding">
  <img src="{$BASE_URL}images/instituicao/{$instituicao.sigla}.jpg" alt="">
</div>