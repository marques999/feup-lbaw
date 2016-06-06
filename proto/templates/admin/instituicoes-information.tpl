<div class="message hoverable">
  <img class="all-100" src="{$BASE_URL}images/instituicao/{$instituicao.sigla}.jpg" alt="">
  <div class="quarter-vertical-padding">
    <b class="no-margin">
      <a class="black"
         href="{$BASE_URL}pages/instituicao/view.php?id={$instituicao.sigla}">{$instituicao.nome}</a>
      <small>{$instituicao.sigla|upper}</small>
    </b>
    <p class="no-margin">
      <small>
        <i class="fa fa-fw fa-eye"></i>
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
    <p class="no-margin align-center">
      <small>
        <a class="ink-button" href="{$BASE_URL}pages/instituicao/update.php?id={$instituicao.sigla}">
          <i class="fa fa-pencil-square-o"></i>
          <span>Editar</span>
        </a>
        <a class="ink-button" href="{$BASE_URL}pages/instituicao/delete.php?id={$instituicao.sigla}">
          <i class="fa fa-close"></i>
          <span>Apagar</span>
        </a>
      </small>
    </p>
  </div>
</div>