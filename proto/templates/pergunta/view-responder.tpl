<b class="no-margin">Responder</b>
<hr class="quarter-vertical-space">
<section id="reply-form" class="push-center half-vertical-space">
  <form action="{$BASE_URL}actions/resposta/submit.php" method="post" enctype="multipart/form-data" class="ink-form ink-formvalidator">
    <input type="hidden" name="idPergunta" id="idPergunta" value="{$pergunta.idpergunta}">
    <div class="control-group column-group quarter-gutters">
      <div class="control">
        <textarea name="descricao" id="descricao" rows="8" cols="60">
        </textarea>
      </div>
    </div>
    <div class="control-group column-group quarter-gutters">
      <div class="align-center">
        <button class="ink-button medium black" type="submit">
          <i class="fa fa-check"></i>
          <span>Submeter</span>
        </button>
        <button class="ink-button medium black" type="reset">
          <i class="fa fa-eraser"></i>
          <span>Limpar</span>
        </button>
      </div>
    </div>
  </form>
</section>