<?
  include('templates/header_editor.php');
  include('templates/navigation.php');
?>


<!-- PÁGINA -->
<div class="ink-grid bottom-padding push-center all-75 large-85 medium-95 small-100 tiny-100">
<h5 class="slab half-top-padding">
  <a href="view_messages.php">Mensagens Privadas</a>&nbsp;&gt;&nbsp;mellus
</h5>


<!-- MENSAGEM 1 -->
<div class="message column-group half-vertical-space">


<!-- MENSAGEM 1: painel esquerdo (informações autor) -->
<div class="column all-15 medium-20 small-25 tiny-25">
  <b class="no-margin"><a href="view_profile.php">marques999</a></b>
  <p class="medium no-margin">FEUP</p>
  <img class="img-circle half-vertical-space" src="holder.js/64x64/auto/ink" alt="">
</div>


<!-- MENSAGEM 1: painel direito (conteúdo) -->
<div class="column all-85 medium-80 small-75 tiny-75">


<!-- MENSAGEM 1: cabeçalho -->
<div class="message-header">
  <b>Lorem ipsum dolor sit amet</b>
  <p class="slab">
    <small><i class="fa fa-calendar"></i>&nbsp;01/03/2016 21:24</small>
  </p>
</div>


<!-- MENSAGEM 1: conteúdo -->
<div class="message-content half-bottom-space">
  <p class="medium half-vertical-space">
  Vestibulum quis placerat metus. In <b>pharetra metus</b> vel tincidunt feugiat. Ut vulputate sem vitae velit <em>sagittis</em> congue. Mauris blandit felis sed velit eleifend semper.
  </p>
  <p class="medium half-vertical-space">
  Nullam suscipit, lectus non congue ultricies, lectus <a href="#">mauris efficitur</a> ex, nec tempor turpis arcu et ex. Maecenas porta posuere turpis et dapibus. Phasellus ac aliquam eros, nec rutrum dolor. Aliquam ac vestibulum eros.
  </p>
</div>


<!-- MENSAGEM 1: buton group -->
<div class="message-buttons quarter-vertical-padding align-right">
  <small>
    <a href="#" class="ink-button black"><i class="fa fa-pencil"></i>&nbsp;Responder</a>
  </small>
  <small>
    <a href="#" class="ink-button black"><i class="fa fa-quote-right"></i>&nbsp;Citação</a>
  </small>
</div>
</div>
</div>


<!-- MENSAGEM 2 -->
<div id="last-message" class="message column-group half-vertical-space">


<!-- MENSAGEM 2: painel esquerdo (informações autor) -->
<div class="column all-15 medium-20 small-25 tiny-25">
  <b class="no-margin"><a href="view_profile.php">mellus</a></b>
  <p class="medium no-margin">FEUP</p>
  <img class="img-circle half-vertical-space" src="holder.js/64x64/auto/ink" alt="">
  <p class="small"><b>Last Online:</b> Wednesday, 09/03/2016 17:55</p>
</div>


<!-- MENSAGEM 2: painel direito (conteúdo) -->
<div class="column all-85 medium-80 small-75 tiny-75">


<!-- MENSAGEM 2: cabeçalho -->
<div class="message-header">
  <b>RE: Lorem ipsum dolor sit amet</b>
  <p class="slab">
    <small><i class="fa fa-calendar"></i>&nbsp;01/03/2016 22:55</small>
  </p>
</div>


<!-- MENSAGEM 2: corpo -->
<div class="message-content half-bottom-space">
  <p class="half-vertical-space">
  <small class="no-margin">marques999 wrote:</small>
  <blockquote class="no-margin medium fw-300">
  Nullam suscipit, lectus non congue ultricies, lectus <a href="#">mauris efficitur</a> ex, nec tempor turpis arcu et ex. Maecenas porta posuere turpis et dapibus. Phasellus ac aliquam eros, nec rutrum dolor. Aliquam ac vestibulum eros.
  </blockquote>
  </p>
  <p class="medium half-vertical-space">
  Cras suscipit purus vel nibh mattis, eu feugiat purus porttitor. Nulla eget <b>odio tempus</b> libero consequat vehicula placerat non nibh. Nulla a condimentum felis. Pellentesque quis laoreet tellus. Donec euismod, tellus non porta varius, mauris libero faucibus lectus, in vulputate est massa feugiat nulla.
  </p>
  <p class="medium half-vertical-space">
  Nulla dignissim nisi tortor, et rutrum <em>lacus</em> sollicitudin in. Nulla at lectus volutpat lectus rutrum pellentesque. Suspendisse tempor cursus mauris, at vehicula nisi volutpat quis. Fusce ut mi sapien. Cras nec semper dui, a aliquet orci.
  </p>
</div>


<!-- MENSAGEM 2: button group -->
<div class="message-buttons quarter-vertical-padding align-right">
  <small>
    <a href="#" class="ink-button black"><i class="fa fa-pencil"></i>&nbsp;Responder</a>
  </small>
  <small>
    <a href="#" class="ink-button black"><i class="fa fa-quote-right"></i>&nbsp;Citação</a>
  </small>
</div>
</div>
</div>


<!-- PRIVATE MESSAGE: formulário -->
<div class="message half-top-space bottom-space">
<form action="actions/action_create_event.php" method="post" enctype="multipart/form-data" class="ink-form ink-formvalidator medium half-vertical-padding">


<!-- PRIVATE MESSAGE: assunto -->
<div class="control-group required column-group half-gutters">
  <label for="subject" class="all-15 align-right fw-700">Assunto:</label>
  <div class="control all-80">
    <input name="subject" id="subject" type="text" data-rules="required|text[true,true]" placeholder="Por favor indique o assunto da sua mensagem...">
  </div>
</div>


<!-- PRIVATE MESSAGE: mensagem -->
<div class="control-group required column-group half-gutters ">
  <label for="message" class="all-15 align-right fw-700">Mensagem:</label>
  <div class="control all-80">
    <textarea name="message" id="message" rows="8" cols="60" data-rules="required" placeholder="Por favor escreva aqui a sua mensagem..."></textarea>
  </div>
</div>


<!-- PRIVATE MESSAGE: botões -->
<div class="control-group column-group half-gutters no-margin">
  <div class="align-center">
    <button class="ink-button black" type="submit">
      <i class="fa fa-pencil"></i>
      Enviar
    </button>
    <button class="ink-button black" type="reset">
      <i class="fa fa-eraser"></i>
      Limpar
    </button>
  </div>
</div>
</form>
</div>
</div>

<?
  include('templates/footer.php');
?>