{include file='common/header.tpl'}
{include file='common/navigation.tpl'}
<div class="ink-grid">
<div class="column-group top-padding">
  <div class="column all-66 large-50 medium-40 small-40 tiny-100">
    <h3 class="condensed">Instituições
      <span class="fw-300 medium">(8)</span>
    </h3>
  </div>
  <div class="column all-33 large-50 medium-60 small-60 tiny-100">
    <nav class="ink-navigation medium push-right">
      <ul class="pagination pills">
        <li><a href="{$BASE_DIR}category/browse/">por categoria</a></li>
        <li class="active"><a href="{$BASE_DIR}hub/browse/">por instituição</a></li>
      </ul>
    </nav>
  </div>
</div>
<div class="all-100">
  <hr class="no-margin half-bottom-padding">
</div>
<div class="column-group half-gutters">
  {foreach $instituicoes as $instituicao}
  <div class="column all-25 large-33 medium-50 small-100 tiny-100">
    <div class="message">
      <img class="all-100" src="{$instituicao.sigla}.jpg" alt="">
      <div class="quarter-vertical-padding">
        <b class="no-margin">
          <a class="black" href="{$BASE_DIR}pages/{$instituicao.sigla}">{$instituicao.nome}</a>
          <small>{$instituicao.sigla|upper}</small>
        </b>
        <p class="no-margin">
          <small><i class="fa fa-user"></i>&nbsp;{$instituicao.numeroMembros} membros</small>
        </p>
        <p class="no-margin">
          <small><i class="fa fa-question-circle"></i>&nbsp;24 perguntas</small>
        </p>
        <p class="no-margin">
          <small><i class="fa fa-eye"></i>&nbsp;500 visualizações</small>
        </p>
      </div>
    </div>
  </div>
  {/foreach}
</div>
{include file='common/footer-empty.tpl'}