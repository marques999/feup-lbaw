{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid column-group push-center gutters half-bottom-padding">
  {include file='categoria/blocks/sidebar.tpl'}
  <div class="column half-top-padding all-80 medium-75 small-100 tiny-100">
    <div class="column-group quarter-gutters message half-bottom-space">
      <div class="column all-75 medium-65 quarter-vertical-padding">
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
        <p class="medium half-vertical-space">
    O ensino da Engenharia Informática e Computação foi concebido na FEUP como requerendo um ciclo de formação e aprendizagem completo de cinco anos integrados, correspondendo aos 1º e 2º ciclos da implementação do Processo de Bolonha e conferindo de imediato o grau de Mestre.
        </p>
        <a class="ink-button black medium" href="{$BASE_URL}pages/pergunta/ask.php">
          <i class="fa fa-plus"></i>
          <span>&nbsp;Fazer pergunta</span>
        </a>
      </div>
      <div class="column all-25 medium-35 quarter-padding">
        <img src="{$BASE_URL}images/assets/question-marks.png" alt="">
      </div>
    </div>
    <div class="column-group quarter-gutters">
    {include file='categoria/blocks/perguntas.tpl'}
    </div>
  </div>
</div>
{/block}