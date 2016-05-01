{extends file='common/header.tpl'}
{block name=content}
{literal}
<script>
var numberNotifications = 5;
$(function(){
  $("button.dismiss").click(function(){
    $(this).parent().parent().parent().remove();
    numberNotifications--;
    if (numberNotifications <= 0) {
      $("table").replaceWith("<p>You have no pending notifications :(</p>");
    }
  });
});
</script>
{/literal}
<!-- PÁGINA -->
<div class="ink-grid">
  <div class="message all-100 half-vertical-space">
    <h5 class="slab no-margin">
      <i class="fa fa-user fa-fw"></i>
      <a class="black" href="{$BASE_URL}pages/utilizador/profile.php">Utilizador</a>
      &nbsp;<i class="fa fa-angle-right"></i>&nbsp;
      <a class="black" href="{$BASE_URL}pages/utilizador/notifications.php">Notificações</a>
    </h5>
  </div>


<!-- LISTA DE NOTIFICAÇÕES -->
<table class="ink-table alternating hover"
       data-page-size="4"
       data-pagination="#myTablePagination">
  <thead>
    <tr>
      <th style="width:50%"></th>
      <th style="width:25%"></th>
      <th style="width:25%"></th>
    </tr>
  </thead>
<tbody>


<!-- MENSAGEM 1 -->
<tr class="notification-row">
  <td class="medium">
    <b><a class="black" href="{$BASE_URL}pages/pergunta/view.php?id=1">Porque é o Linux parece ser mais rápido que o Windows?</a><span class="ink-badge black">nova resposta!</span></b>
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
      <a href="{$BASE_URL}pages/pergunta/view.php?id=1" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver resposta" data-tip-color="black">
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
    <b><a class="black" href="{$BASE_URL}pages/pergunta/view.php?id=1">Porque é o Linux parece ser mais rápido que o Windows?</a><span class="ink-badge black">nova resposta!</span></b>
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
      <a href="{$BASE_URL}pages/pergunta/view.php?id=1" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver comentário" data-tip-color="black">
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
    <b><a class="black" href="{$BASE_URL}pages/pergunta/view.php?id=1">Que país tem a pior gastronomia na vossa opinião?</a><span class="ink-badge black">novo comentário!</span></b>
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
      <a href="{$BASE_URL}pages/pergunta/view.php?id=1" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver comentário" data-tip-color="black">
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
    <b><a class="black" href="{$BASE_URL}pages/pergunta/view.php?id=1">Que país tem a pior gastronomia na vossa opinião?</a><span class="ink-badge black">nova resposta!</span></b>
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
      <a href="{$BASE_URL}pages/pergunta/view.php?id=1" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver resposta" data-tip-color="black">
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
    <b><a class="black" href="{$BASE_URL}pages/pergunta/view.php?id=1">Qual foi o comentário mais hilariante que encontraram em código?</a><span class="ink-badge black"><i class="fa fa-check"></i>&nbsp;fechada</span></b>
    <p class="quarter-vertical-space">
      <strong>melhor resposta:</strong>
      O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.
    </p>
  </td>
  <td>
    <i class="fa fa-user"></i>
    <a href="{$BASE_URL}pages/utilizador/profile.php">marques999</a>
    <p><small>Wednesday, 02/12/2015 23:32</small></p>
  </td>
  <td>
    <div class="button-group">
      <a href="{$BASE_URL}pages/pergunta/view.php?id=1"
        class="all-50 ink-button ink-tooltip medium"
        data-tip-text="Ver resposta"
        data-tip-color="black">
        <i class="fa fa-reply"></i>
      </a>
      <button class="all-50 ink-button ink-tooltip medium dismiss"
          data-tip-text="Ignorar"
          data-tip-color="black">
        <i class="fa fa-close"></i>
      </button>
    </div>
  </td>
</tr>
</tbody>
</table>
<div class="column align-center all-100">
  <nav class="ink-navigation" id="myTablePagination">
    <ul class="pagination black medium"></ul>
  </nav>
</div>
{/block}
{block name=footer}
{/block}