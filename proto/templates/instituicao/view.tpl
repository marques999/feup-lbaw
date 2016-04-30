{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid column-group push-center gutters half-bottom-padding">
  {include file='instituicao/blocks/sidebar.tpl'}
  <div class="column half-top-padding all-80 medium-75 small-100 tiny-100">
    <div class="column-group quarter-gutters message half-bottom-space">
      <div class="column all-75 medium-65 quarter-vertical-padding">
        <h4 class="quarter-vertical-space slab">{$instituicao.nome}</h4>
        <p class="condensed">
          <i class="fa fa-institution"></i>
          {$categorias_count}
          {if $categorias_count eq 1} categoria
          {else} categorias
          {/if}
          &nbsp;
          <i class="fa fa-question-circle"></i>
          {$perguntas_count}
          {if $perguntas_count eq 1} pergunta
          {else} perguntas
          {/if}
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
    </div>
    <div class="column-group quarter-gutters">
    {include file='instituicao/blocks/perguntas.tpl'}
    </div>
  </div>
</div>
{/block}