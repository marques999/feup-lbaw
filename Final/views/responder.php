<?
  require_once(__DIR__ . '/template/header.php');
  require_once(__DIR__ . '/template/navigation.php');
?>

<div class="ink-grid bottom-padding push-center all-100 xlarge-66 large-80 medium-90">


<!-- PERGUNTA: título -->
<article id="question">
<h3 class="slab quarter-vertical-space half-top-padding">Porque é o Linux parece ser mais rápido que o Windows?</h3>


<!-- RESPOSTA 1: autor -->
<div class="author-panel quarter-vertical-space">
  <img class="img-circle push-left quarter-padding" src="holder.js/64x64/auto/ink" alt="">
  <div class="half-padding">
    <p class="no-margin">
      <strong><a href="view_profile.php">Diogo Marques</a></strong>
      <span class="small condensed">Estudante, Entusiasta Retrogaming</span>
    </p>
    <p class="medium no-margin">FEUP</p>
  </div>
</div>


<!-- PERGUNTA: conteúdo -->
<p class="medium no-margin align-justify">
Desta maneira, a percepção das dificuldades promove a alavancagem do sistema de participação geral. O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais. O incentivo ao avanço tecnológico, assim como a execução dos pontos do programa representa uma abertura para a melhoria das novas proposições. Neste sentido, a expansão dos mercados mundiais estimula a padronização das condições inegavelmente apropriadas?
</p>


<!-- PERGUNTA: informações -->
<p class="condensed quarter-vertical-space">
  <small>Enviada Terça-feira, 1 de Março de 2016&nbsp;|&nbsp;</small>
  <a class="ink-toggle medium" data-target="#question-comments">
    <strong>5</strong>&nbsp;Comentários
  </a>
</p>


<!-- PERGUNTA: comentários -->
<div id="question-comments" class="message half-vertical-space medium hide-all">
  <div class="column half-vertical-space">
    <img class="push-left all-5 img-circle quarter-right-space" src="holder.js/64x64/auto/ink" alt="">
    <a href="view_profile.php">Pedro Melo</a>
    <small>Thursday, 10/03/2016 17:34</small>
    <p class="fw-medium">Lorem</p>
  </div>
  <div class="column half-vertical-space">
    <img class="push-left all-5 img-circle quarter-right-space" src="holder.js/64x64/auto/ink" alt="">
    <a href="view_profile.php">Diogo Marques</a>
    <small>Thursday, 10/03/2016 17:42</small>
    <p class="fw-medium">Lorem ipsum</p>
  </div>
  <div class="column half-vertical-space">
    <img class="push-left all-5 img-circle quarter-right-space" src="holder.js/64x64/auto/ink" alt="">
    <a href="view_profile.php">Diogo Marques</a>
    <small>Thursday, 10/03/2016 17:44</small>
    <p class="fw-medium">Lorem ipsum dolor</p>
  </div>
  <div class="column half-vertical-space">
    <img class="push-left all-5 img-circle quarter-right-space" src="holder.js/64x64/auto/ink" alt="">
    <a href="view_profile.php">Vitor Esteves</a>
    <small>Thursday, 10/03/2016 17:59</small>
    <p class="fw-medium">Lorem ipsum dolor sit</p>
  </div>
  <div class="column half-vertical-space no-margin">
    <img class="push-left all-5 img-circle quarter-right-space" src="holder.js/64x64/auto/ink" alt="">
    <a href="view_profile.php">Diogo Marques</a>
    <small>Thursday, 10/03/2016 18:03</small>
    <p class="fw-medium">Lorem ipsum dolor sit amet</p>
  </div>
</div>
</article>


<!-- RESPOSTA formulário -->
<section id="reply-form" class="push-center half-vertical-space all-85 small-100 tiny-100">
<form action="actions/action_create_event.php" method="post" enctype="multipart/form-data" class="ink-form ink-formvalidator">
<fieldset>
<legend class="align-center">Responder</legend>


<!-- RESPOSTA: mensagem -->
<div class="control-group column-group quarter-gutters">
  <div class="control">
    <textarea name="text" id="text" rows="8" cols="60">
    </textarea>
  </div>
</div>


<!-- RESPOSTA: button group -->
<div class="control-group column-group quarter-gutters">
  <div class="align-center">
    <button class="ink-button medium black" type="submit">
      <i class="fa fa-check"></i>&nbsp;Submeter
    </button>
    <button class="ink-button medium black" type="reset">
      <i class="fa fa-eraser"></i>&nbsp;Limpar
    </button>
  </div>
</div>
</fieldset>
</form>
</section>
</div>

<?
  include('templates/footer.php');
?>