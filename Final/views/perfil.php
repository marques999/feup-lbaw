<?
  require_once(__DIR__ . '/template/header.php');
  require_once(__DIR__ . '/template/navigation.php');
  require_once(__DIR__ . '/../core/database.php');
  $queryResult = pg_prepare($db, "userQuery", "SELECT * FROM knowup.Utilizador WHERE idUtilizador = $1");
  $queryResult = pg_execute($db, "userQuery", array($idUtilizador));
  $thisUser = pg_fetch_array($queryResult, 0, PGSQL_ASSOC);
?>


<!-- PÁGINA -->
<div class="ink-grid column-group half-gutters">


<!-- PAINEL LATERAL -->
<div class="column half-padding all-30 large-40 medium-40 small-100 tiny-100">


<!-- PERFIL: informações do utilizador (bandeira) -->
<div class="half-padding push-right">
  <img src="img/flags/pt.png" alt="Portugal">
</div>


<!-- PERFIL: informações do utilizador (username, nome completo, avatar) -->
<div>
  <h2 class="slab no-margin"><?=$thisUser['username']?></h2>
  <p class="no-margin"><?="{$thisUser['primeironome']} {$thisUser['ultimonome']}"?></p>
  <a href="update_profile.php?field=5">
    <img class="half-vertical-space" src="holder.js/480x480/auto/ink" alt="">
  </a>
</div>


<!-- PERFIL: informações do utilizador (instituição) -->
<p class="no-margin">
  <a class="ink-tooltip" href="#"
    data-tip-text="Alterar instituição" data-tip-color="black">
    <i class="fa fa-plus-circle"></i>
  </a>
  <b>Instituição:</b>
    <a href="hub.php">FEUP</a>
    <a href="https://sigarra.up.pt/feup/pt/web_page.inicial">
      <i class="fa fa-external-link"></i>
    </a>
</p>


<!-- PERFIL: informações do utilizador (endereço e-mail) -->
<p class="no-margin">
  <a class="ink-tooltip" href="#"
    data-tip-text="Alterar endereço de e-mail" data-tip-color="black">
    <i class="fa fa-plus-circle"></i>
  </a>
  <b>E-mail:</b>
  <a href="mailto:up2013056@fe.up.pt"><?=$thisUser['email']?></a>
</p>


<!-- PERFIL: informações do utilizador (localização) -->
<p class="no-margin">
  <a class="ink-tooltip" href="#"
    data-tip-text="Alterar localização" data-tip-color="black">
    <i class="fa fa-plus-circle"></i>
  </a>
  <b>Localização:&nbsp;</b>Valongo, Portugal
</p>
</div>


<!-- PAINEL CENTRAL -->
<div class="column all-70 large-60 medium-60 small-100 tiny-100">


<!-- PERFIL: separadores -->
<div class="ink-tabs top">
<ul class="tabs-nav">
  <li><a class="tabs-tab tabs-black" href="#profile">Perfil</a></li>
  <li><a class="tabs-tab tabs-black" href="#questions">Perguntas
    <strong>3</strong>
  </a></li>
  <li><a class="tabs-tab tabs-black" href="#answers">Respostas
    <strong>3</strong>
  </a></li>
</ul>


<!-- PERFIL: informações (grupo, início de ssessão) -->
<div class="half-horizontal-padding" id="profile">
<div class="column-group half-gutters">
  <div class="column all-25">
    <p class="half-vertical-space">
      <strong>Grupo:</strong>
    </p>
    <p class="half-vertical-space">
      <strong>Membro desde:</strong>
    </p>
    <p class="half-vertical-space">
      <strong>Último inicio de sessão:</strong>
    </p>
  </div>
  <div class="column all-75">
    <p class="half-vertical-space">Moderadores</p>
    <p class="half-vertical-space">Wednesday, 02/12/2015 23:34</p>
    <p class="half-vertical-space"><?=$thisUser['ultimasessao']?></p>
  </div>
</div>


<!-- PERFIL: gestão (palavra-passe, bio) -->
<div class="column-group half-gutters">
  <div class="column all-25 medium-40 small-30 tiny-40">
    <p class="half-vertical-space">
      <strong>Palavra-passe:</strong>
    </p>
    <p class="vertical-space">
      <strong>Sobre mim:</strong>
    </p>
  </div>
  <div class="column all-40 large-60 small-50 tiny-40">
    <p class="vertical-space">&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;</p>
    <p class="vertical-space">Estudante, Entusiasta Retrogaming</p>
  </div>
  <div class="column all-15">
    <p class="align-center">
      <a class="ink-button small" href="#">
      <i class="fa fa-edit"></i>&nbsp;Alterar</a>
    </p>
    <p class="align-center">
      <a class="ink-button small" href="#">
      <i class="fa fa-edit"></i>&nbsp;Alterar</a>
    </p>
  </div>
</div>
</div>


<!-- PERFIL: grelha de perguntas -->
<div id="questions" class="tabs-content">
<table class="ink-table alternating hover">
<thead>
  <th style="width:50%">Pergunta</th>
  <th style="width:25%">Pontuação</th>
  <th style="width:25%">Acções</th>
</thead>
<tbody>


<!-- PERGUNTA 1 -->
<tr>
  <td class="medium">
    <b><a class="black" href="view_question.php">Porque é o Linux parece ser mais rápido que o Windows?</a></b>
    <p class="quarter-vertical-space">O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.</p>
  </td>
  <td class="align-center">
    <h3 class="quarter-vertical-space positive-score">56</h3>
    <p class="medium">(&nbsp;64&nbsp;<i class="fa fa-thumbs-up"></i>&nbsp;&nbsp;8&nbsp;<i class="fa fa-thumbs-down"></i>&nbsp;)</p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Responder" data-tip-color="black">
        <i class="fa fa-reply"></i>
      </a>
      <button class="all-50 ink-button ink-tooltip medium dismiss" data-tip-text="Apagar pergunta" data-tip-color="black">
        <i class="fa fa-close"></i>
      </button>
    </div>
    </div>
  </td>
</tr>


<!-- PERGUNTA 2 -->
<tr>
  <td class="medium">
    <b><a class="black" href="view_question.php">Qual foi o comentário mais hilariante que encontraram em código?</a><span class="ink-badge black"><i class="fa fa-check"></i>&nbsp;fechada</span></b>
    <p class="quarter-vertical-space">O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.</p>
  </td>
  <td class="align-center">
    <h3 class="quarter-vertical-space positive-score">6</h3>
    <p class="medium">(&nbsp;7&nbsp;<i class="fa fa-thumbs-up"></i>&nbsp;&nbsp;1&nbsp;<i class="fa fa-thumbs-down"></i>&nbsp;)</p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Responder" data-tip-color="black">
        <i class="fa fa-reply"></i>
      </a>
<button class="all-50 ink-button ink-tooltip medium" data-tip-text="Apagar pergunta" data-tip-color="black">
        <i class="fa fa-close"></i>
      </button>
    </div>
  </td>
</tr>


<!-- PERGUNTA 3 -->
<tr>
  <td class="medium">
    <b><a class="black" href="view_question.php">Que país tem a pior gastronomia na vossa opinião?</a></b>
    <p class="quarter-vertical-space">O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.</p>
  </td>
  <td class="align-center">
    <h3 class="quarter-vertical-space negative-score">-21</h3>
    <p class="medium">(&nbsp;2&nbsp;<i class="fa fa-thumbs-up"></i>&nbsp;&nbsp;23&nbsp;<i class="fa fa-thumbs-down"></i>&nbsp;)</p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Responder" data-tip-color="black">
        <i class="fa fa-reply"></i>
      </a>
      <button class="all-50 ink-button ink-tooltip medium" data-tip-text="Apagar pergunta" data-tip-color="black">
        <i class="fa fa-close"></i>
      </button>
    </div>
  </td>
</tr>
</tbody>
</table>
</div>


<!-- PERFIL: grelha de respostas -->
<div id="answers" class="tabs-content">
<table class="ink-table alternating hover">
<thead>
  <th style="width:50%">Pergunta</th>
  <th style="width:25%">Pontuação</th>
  <th style="width:25%">Acções</th>
</thead>
<tbody>


<!-- RESPOSTA 1 -->
<tr>
  <td class="medium">
    <b><a class="black" href="view_question.php">Porque é o Linux parece ser mais rápido que o Windows?</a></b>
    <p class="quarter-vertical-space">O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.</p>
  </td>
  <td class="align-center">
    <h3 class="quarter-vertical-space positive-score">56</h3>
    <p class="medium">(&nbsp;64&nbsp;<i class="fa fa-thumbs-up"></i>&nbsp;&nbsp;8&nbsp;<i class="fa fa-thumbs-down"></i>&nbsp;)</p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver resposta" data-tip-color="black">
        <i class="fa fa-external-link"></i>
      </a>
      <a class="all-50 ink-button ink-tooltip medium" data-tip-text="Apagar resposta" data-tip-color="black">
        <i class="fa fa-close"></i>
      </a>
    </div>
  </td>
</tr>


<!-- RESPOSTA 2 -->
<tr>
  <td class="medium">
    <b><a class="black" href="view_question.php">Qual foi o comentário mais hilariante que encontraram em código?</a><span class="ink-badge black"><i class="fa fa-check"></i>&nbsp;fechada</span></b>
    <p class="quarter-vertical-space">O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.</p>
  </td>
  <td class="align-center">
    <h3 class="quarter-vertical-space positive-score">6</h3>
    <p class="medium">(&nbsp;7&nbsp;<i class="fa fa-thumbs-up"></i>&nbsp;&nbsp;1&nbsp;<i class="fa fa-thumbs-down"></i>&nbsp;)</p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver resposta" data-tip-color="black">
        <i class="fa fa-external-link"></i>
      </a>
      <a class="all-50 ink-button ink-tooltip medium" data-tip-text="Apagar resposta" data-tip-color="black">
        <i class="fa fa-close"></i>
      </a>
    </div>
  </td>
</tr>


<!-- RESPOSTA 3 -->
<tr>
  <td class="medium">
    <b><a class="black" href="view_question.php">Que país tem a pior gastronomia na vossa opinião?</a></b>
    <p class="quarter-vertical-space">O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais.</p>
  </td>
  <td class="align-center">
    <h3 class="quarter-vertical-space negative-score">-21</h3>
    <p class="medium">(&nbsp;2&nbsp;<i class="fa fa-thumbs-up"></i>&nbsp;&nbsp;23&nbsp;<i class="fa fa-thumbs-down"></i>&nbsp;)</p>
  </td>
  <td>
    <div class="button-group">
      <a href="view_question.php" class="all-50 ink-button ink-tooltip medium" data-tip-text="Ver resposta" data-tip-color="black">
        <i class="fa fa-external-link"></i>
      </a>
      <a class="all-50 ink-button ink-tooltip medium" data-tip-text="Apagar resposta" data-tip-color="black">
        <i class="fa fa-close"></i>
      </a>
    </div>
  </td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>

<?
  require_once(__DIR__ . '/template/footer.php');
?>