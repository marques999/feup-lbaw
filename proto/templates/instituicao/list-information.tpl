{foreach $instituicoes as $instituicao}
  <div class="column all-25 large-33 medium-50 small-100 tiny-100">
    <div class="message hoverable">
      <img src="{$BASE_URL}images/instituicao/{$instituicao.sigla}.jpg" alt="">
      <div class="quarter-vertical-padding">
        <b class="no-margin">
          <a class="black" href="{$BASE_URL}pages/instituicao/view.php?id={$instituicao.sigla}">{$instituicao.nome}</a>
          <small>{$instituicao.sigla|upper}</small>
        </b>
        <p class="no-margin">
          <small>
            <i class="fa fa-fw fa-cube"></i>
            {if $instituicao.numerocategorias eq 1}
            <span>{$instituicao.numerocategorias} categoria</span>
            {else}
            <span>{$instituicao.numerocategorias} categorias</span>
            {/if}
          </small>
        </p>
        <p class="no-margin">
          <small>
            <i class="fa fa-fw fa-question-circle"></i>
            {if $instituicao.numeroperguntas eq 1}
            <span>{$instituicao.numeroperguntas} pergunta</span>
            {else}
            <span>{$instituicao.numeroperguntas} perguntas</span>
            {/if}
          </small>
        </p>
        <p class="half-bottom-space">
          <small>
            <i class="fa fa-fw fa-user"></i>
            {if $instituicao.numeroutilizadores eq 1}
            <span>{$instituicao.numeroutilizadores} membro</span>
            {else}
            <span>{$instituicao.numeroutilizadores} membros</span>
            {/if}
          </small>
        </p>
      </div>
    </div>
  </div>
{/foreach}