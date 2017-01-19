<div class="column all-75 medium-65 quarter-vertical-padding">
  <h4 class="quarter-vertical-space slab">{$instituicao.nome}</h4>
  <p class="condensed">
    <i class="fa fa-institution"></i>
    {if $categorias_count eq 1}
    <span>{$categorias_count} categoria</span>
    {else}
    <span>{$categorias_count} categorias</span>
    {/if}
    &nbsp;
    <i class="fa fa-question-circle"></i>
    {if $perguntas_count eq 1}
    <span>{$perguntas_count} pergunta</span>
    {else}
    <span>{$perguntas_count} perguntas</span>
    {/if}
  </p>
  {if $instituicao.morada}
  <p class="medium quarter-vertical-space">
    <strong>Morada:</strong>
    <addr>{$instituicao.morada}</addr>
  </p>
  {/if}
  {if $instituicao.contacto}
  <p class="medium quarter-vertical-space">
    <strong>Contacto:</strong>
    <span>{$instituicao.contacto}</span>
  </p>
  {/if}
</div>
<div class="column all-25 medium-35 quarter-padding">
  <img src="{$instituicao.sigla|instituicao_getImagem}" alt="{$instituicao.nome}">
</div>