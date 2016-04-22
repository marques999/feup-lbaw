{extends file='common/header.tpl'}
{block name=content}
  <div class="column-group half-top-space">
    <div class="column all-66 large-50 medium-40 small-40 tiny-100">
      <h3 class="condensed">Instituições
        <span class="fw-300 medium">(8)</span>
      </h3>
    </div>
    <div class="column all-33 large-50 medium-60 small-60 tiny-100">
      <nav class="ink-navigation medium push-right">
        <ul class="pagination pills">
          <li><a href="{$BASE_URL}pages/lista_categorias.php">por categoria</a></li>
          <li class="active"><a href="{$BASE_URL}pages/lista_instituicoes.php">por instituição</a></li>
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
        <img class="all-100" src="{$BASE_URL}images/hubs/{$instituicao.sigla}.jpg" alt="">
        <div class="quarter-vertical-padding">
          <b class="no-margin">
            <a class="black" href="{$BASE_URL}pages/instituicao/view.php?id={$instituicao.sigla}">{$instituicao.nome}</a>
            <small>{$instituicao.sigla|upper}</small>
          </b>
          <p class="no-margin">
            <small><i class="fa fa-user"></i>&nbsp;{$instituicao.numeroutilizadores} membros</small>
          </p>
          <p class="no-margin">
            <small><i class="fa fa-question-circle"></i>&nbsp;{$instituicao.numeroperguntas} perguntas</small>
          </p>
          <p class="no-margin">
            <small><i class="fa fa-eye"></i>&nbsp;{$instituicao.numerocategorias} categorias</small>
          </p>
        </div>
      </div>
    </div>
    {/foreach}
  </div>
{/block}