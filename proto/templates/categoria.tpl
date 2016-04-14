{include file='common/header.tpl'}
{include file='common/navigation.tpl'}
{include file='common/page-fullscreen.php'}
{include file='common/sidebar-subject.php'}
<div class="column half-top-padding all-80 medium-75 small-100 tiny-100">
  <div class="column-group quarter-gutters message half-bottom-space">
    <div class="column all-75 medium-65 quarter-vertical-padding">
      <h4 class="quarter-vertical-space slab">Engenharia Informática</h4>
      <p><i class="fa fa-institution"></i>&nbsp;FCUP&nbsp;&bull;&nbsp;FEUP</p>
      <p class="medium quarter-vertical-space">
  O ensino da Engenharia Informática e Computação foi concebido na FEUP como requerendo um ciclo de formação e aprendizagem completo de cinco anos integrados, correspondendo aos 1º e 2º ciclos da implementação do Processo de Bolonha e conferindo de imediato o grau de Mestre.
      </p>
    </div>
    <div class="column all-25 medium-35 quarter-padding">
      <img src="img/question-marks.png" alt="">
    </div>
  </div>
  {foreach $questions as $question}
    {include file='questions/list.tpl'}
  {/foreach}
  </div>
</div>
{include file='common/footer.tpl'}