{extends file='common/header.tpl'}
{block name=content}
<div class="ink-grid">
  <div class="column-group half-top-space">
    <div class="column all-66 large-50 medium-40 small-40 tiny-100">
      <h3 class="condensed">Instituições
        <span class="fw-300 medium">({$instituicoes|count})</span>
      </h3>
    </div>
    <div class="column all-33 large-50 medium-60 small-60 tiny-100">
      <nav class="ink-navigation medium push-right">
        <ul class="pagination pills">
          <li><a href="{$BASE_URL}pages/categoria/list.php">por categoria</a></li>
          <li class="active"><a href="{$BASE_URL}pages/instituicao/list.php">por instituição</a></li>
        </ul>
      </nav>
    </div>
  </div>
  <hr class="no-margin half-bottom-padding">
  <div class="column-group half-gutters">
    {foreach $instituicoes as $instituicao}
    <div class="column all-25 large-33 medium-50 small-100 tiny-100">
      <div class="message">
        <img src="{$BASE_URL}images/instituicao/{$instituicao.sigla}.jpg" alt="">
        <div class="quarter-vertical-padding">
          <b class="no-margin">
            <a class="black" href="{$BASE_URL}pages/instituicao/view.php?id={$instituicao.sigla}">{$instituicao.nome}</a>
            <small>{$instituicao.sigla|upper}</small>
          </b>
          <p class="no-margin">
            <small><i class="fa fa-user fa-fw"></i>&nbsp;{$instituicao.numeroutilizadores} membros</small>
          </p>
          <p class="no-margin">
            <small><i class="fa fa-question-circle fa-fw"></i>&nbsp;{$instituicao.numeroperguntas} perguntas</small>
          </p>
          <p class="no-margin">
            <small><i class="fa fa-eye fa-fw"></i>&nbsp;{$instituicao.numerocategorias} categorias</small>
          </p>
        </div>
      </div>
    </div>
    {/foreach}
  </div>
</div>
{/block}
{block name=footer}
{/block}