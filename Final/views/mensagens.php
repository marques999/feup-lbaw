<?
  require_once(__DIR__ . '/template/header.php');
  require_once(__DIR__ . '/template/navigation.php');
?>

<div class="ink-grid">
<h3 class="half-top-padding">Mensagens Privadas<span class="ink-badge black">3&nbsp;<span class="small fw-300">não lidas</span></span></h3>


<!-- LISTA DE MENSAGENS -->
<table class="ink-table alternating hover">
<thead>
  <th style="width:25%">Conversa</th>
  <th>Mensagens</th>
  <th>Última Mensagem</th>
  <th style="width:20%">Autor</th>
</thead>
<tbody>


<!-- MENSAGEM 1 -->
<tr>
  <td class="fw-700">
    <img class="img-circle push-left quarter-padding" src="holder.js/64x64/auto/ink" alt="">
    <div class="half-vertical-padding all-50 medium-20 small-30">
      <p class="no-margin">
        <a href="view_thread.php#last-message">Pedro Melo</a>
      </p>
      <note class="medium">FEUP</note>
    </div>
  </td>
  <td class="align-center fw-700">3</td>
  <td class="medium">
    <b>Oláaaaa :DD<span class="ink-badge black">2</span></b>
    <p class="quarter-vertical-space">O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.</p>
  </td>
  <td class="fw-700">
      <i class="fa fa-user"></i>
      <a href="view_profile.php">mellus</a>
      <p><small>Tuesday, 01/03/2016 18:49</small></p>
  </td>
</tr>


<!-- MENSAGEM 2 -->
<tr>
  <td class="fw-700">
    <img class="img-circle push-left quarter-padding" src="holder.js/64x64/auto/ink" alt="">
    <div class="half-vertical-padding all-50">
      <p class="no-margin">
        <a href="view_thread.php#last-message">Vitor Esteves</a>
      </p>
      <note class="medium">FEUP</note>
    </div>
  </td>
  <td class="align-center fw-700">6</td>
  <td class="medium">
    <b>Entrega A3<span class="ink-badge black">1</span></b>
      <p class="quarter-vertical-space">O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.</p>
  </td>
  <td class="fw-700">
      <i class="fa fa-user"></i>
      <a href="view_profile.php">darklord</a>
      <p><small>Tuesday, 01/03/2016 16:09</small></p>
  </td>
</tr>


<!-- MENSAGEM 3 -->
<tr>
  <td>
    <img class="img-circle push-left quarter-padding" src="holder.js/64x64/auto/ink" alt="">
    <div class="half-padding">
      <p class="no-margin"><b>
        <a href="view_thread.php#last-message">Administrator</a>
      </b></p>
      <note class="medium">FEUP</note>
    </div>
  </td>
  <td class="align-center">0</td>
  <td class="medium">
    <b>Sem assunto</b>
    <p class="quarter-vertical-space">O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.</p>
  </td>
  <td>
    <i class="fa fa-user"></i>
    <a href="view_profile.php">marques999</a>
    <p><small>Sunday, 06/12/2015 20:01</small></p>
  </td>
</tr>
</tbody>
</table>
</div>

<?
  require_once(__DIR__ . '/template/footer.php');
?>