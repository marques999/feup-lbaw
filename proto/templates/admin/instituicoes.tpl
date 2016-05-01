{extends file='admin/common/pagina.tpl'}
{block name=content}
<div class="column-group">
  <div class="column all-80 medium-70 small-60 tiny-50">
    <h3 class="condensed">Instituições
      <span class="fw-300 medium">({$instituicoes|count})</span>
    </h3>
  </div>
  <div class="column all-20 medium-30 small-40 tiny-50 align-right">
    <a href="{$BASE_URL}pages/instituicao/create.php" class="ink-button medium">
      <i class="fa fa-plus"></i>
      <span>Adicionar instituição</span>
    </a>
  </div>
</div>
<div class="column-group half-gutters">
  {foreach $instituicoes as $instituicao}
  <div class="column all-25 large-33 medium-50 small-100 tiny-100">
    <div class="message">
      <img class="all-100" src="{$BASE_URL}images/instituicao/{$instituicao.sigla}.jpg" alt="">
      <div class="quarter-vertical-padding">
        <b class="no-margin">
          <a class="black" href="{$BASE_URL}pages/instituicao/view.php?id={$instituicao.sigla}">{$instituicao.nome}</a>
          <small>{$instituicao.sigla|upper}</small>
        </b>
        <p class="no-margin">
          <small>
            <i class="fa fa-eye fa-fw"></i>
            <span>{$instituicao.numerocategorias} categorias</span>
          </small>
        </p>
        <p class="no-margin">
          <small>
            <i class="fa fa-question-circle fa-fw"></i>
            <span>{$instituicao.numeroperguntas} perguntas</span>
          </small>
        </p>
        <p class="half-bottom-space">
          <small>
            <i class="fa fa-user fa-fw"></i>
            <span>{$instituicao.numeroutilizadores} membros</span>
          </small>
        </p>
        <p class="no-margin align-center">
           <small>
             <a class="ink-button" href="{$BASE_URL}pages/instituicao/edit.php?id={$instituicao.sigla}">
               <i class="fa fa-pencil-square-o"></i>
               <span>Editar</span>
            </a>
           </small>
           <small>
            <a class="ink-button" href="{$BASE_URL}pages/instituicao/delete.php?id={$instituicao.sigla}">
              <i class="fa fa-close"></i>
              <span>Apagar</span>
            </a>
          </small>
        </p>
      </div>
    </div>
  </div>
  {/foreach}
</div>
{/block}