<?
  include('templates/header.php');
  include('templates/navigation.php');
?>

<script>
var numberNotifications = 5;
$(function(){
  $("button.dismiss").click(function(){
    $(this).parent().parent().parent().remove();
    numberNotifications--;
    $("#number-notifications").text(numberNotifications);
    if (numberNotifications <= 0) {
      $("table").replaceWith("<p>You have no pending notifications :(</p>");
    }
  });
});
</script>


<!-- PÁGINA -->
<div class="ink-grid bottom-padding">
<h3 class="half-top-padding">Notificações<span class="ink-badge black"><span id="number-notifications">5</span><span class="small fw-300">&nbsp;não lidas</span></span></h3>


<!-- LISTA DE NOTIFICAÇÕES -->
<table class="ink-table alternating hover">
<thead>
  <th style="width:50%">Pergunta</th>
  <th style="width:25%">Autor</th>
  <th style="width:25%">Acções</th>
</thead>
<tbody>


<!-- MENSAGEM 1 -->
<tr class="notification-row">
  <td class="medium">
    <b><a class="black" href="view_question.php">Porque é o Linux parece ser mais rápido que o Windows?</a><span class="ink-badge black">nova resposta!</span></b>
    <p class="quarter-vertical-space">
      <strong>mellus respondeu:</strong>
      O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.
    </p>
  </td>
  <td>
    <i class="fa fa-user"></i>
    <a href="view_profile.php">mellus</a>
    <p><small>Tuesday, 01/03/2016 16:09</small></p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver resposta" data-tip-color="black">
        <i class="fa fa-reply"></i>
      </a>
      <button class="all-50 ink-button ink-tooltip medium dismiss" data-tip-text="Ignorar" data-tip-color="black">
        <i class="fa fa-close"></i>
      </button>
    </div>
    </div>
  </td>
</tr>


<!-- MENSAGEM 2 -->
<tr class="notification-row">
  <td class="medium">
    <b><a class="black" href="view_question.php">Porque é o Linux parece ser mais rápido que o Windows?</a><span class="ink-badge black">nova resposta!</span></b>
    <p class="quarter-vertical-space">
      <strong>darklord comentou:</strong>
      O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.
    </p>
  </td>
  <td>
    <i class="fa fa-user"></i>
    <a href="view_profile.php">darklord</a>
    <p><small>Tuesday, 01/03/2016 16:09</small></p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver comentário" data-tip-color="black">
        <i class="fa fa-reply"></i>
      </a>
      <button class="all-50 ink-button ink-tooltip medium dismiss" data-tip-text="Ignorar" data-tip-color="black">
        <i class="fa fa-close"></i>
      </button>
    </div>
  </td>
</tr>


<!-- MENSAGEM 3 -->
<tr class="notification-row">
  <td class="medium">
    <b><a class="black" href="view_question.php">Que país tem a pior gastronomia na vossa opinião?</a><span class="ink-badge black">novo comentário!</span></b>
    <p class="quarter-vertical-space">
      <strong>marques999 comentou:</strong>
      O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.
    </p>
  </td>
  <td>
    <i class="fa fa-user"></i>
    <a href="view_profile.php">marques999</a>
    <p><small>Sunday, 06/12/2015 20:01</small></p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver comentário" data-tip-color="black">
        <i class="fa fa-reply"></i>
      </a>
      <button class="all-50 ink-button ink-tooltip medium dismiss" data-tip-text="Ignorar" data-tip-color="black">
        <i class="fa fa-close"></i>
      </button>
    </div>
  </td>
</tr>


<!-- MENSAGEM 4 -->
<tr class="notification-row">
  <td class="medium">
    <b><a class="black" href="view_question.php">Que país tem a pior gastronomia na vossa opinião?</a><span class="ink-badge black">nova resposta!</span></b>
    <p class="quarter-vertical-space">
      <strong>marques999 respondeu:</strong>
      O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.
    </p>
  </td>
  <td>
    <i class="fa fa-user"></i>
    <a href="view_profile.php">marques999</a>
    <p><small>Saturday, 05/12/2015 00:45</small></p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver resposta" data-tip-color="black">
        <i class="fa fa-reply"></i>
      </a>
      <button class="all-50 ink-button ink-tooltip medium dismiss" data-tip-text="Ignorar" data-tip-color="black">
        <i class="fa fa-close"></i>
      </button>
    </div>
  </td>
</tr>


<!-- MENSAGEM 5 -->
<tr class="notification-row">
  <td class="medium">
    <b><a class="black" href="view_question.php">Qual foi o comentário mais hilariante que encontraram em código?</a><span class="ink-badge black"><i class="fa fa-check"></i>&nbsp;fechada</span></b>
    <p class="quarter-vertical-space">
      <strong>melhor resposta:</strong>
      O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.
    </p>
  </td>
  <td>
    <i class="fa fa-user"></i>
    <a href="view_profile.php">marques999</a>
    <p><small>Wednesday, 02/12/2015 23:32</small></p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver resposta" data-tip-color="black">
        <i class="fa fa-reply"></i>
      </a>
<button class="all-50 ink-button ink-tooltip medium dismiss" data-tip-text="Ignorar" data-tip-color="black">
        <i class="fa fa-close"></i>
      </button>
    </div>
  </td>
</tr>
</tbody>
</table>
</div>

<?
  include('templates/footer.php');
?>