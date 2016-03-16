<?
$question1 = array(
  "title" => "Porque é o Linux parece ser mais rápido que o Windows?",
  "content" => "<p class=\"medium no-margin align-justify\">
Desta maneira, a percepção das dificuldades promove a alavancagem do sistema de participação geral. O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais. O incentivo ao avanço tecnológico, assim como a execução dos pontos do programa representa uma abertura para a melhoria das novas proposições. Neste sentido, a expansão dos mercados mundiais estimula a padronização das condições inegavelmente apropriadas?
</p>",
  "idAutor" => "Diogo Marques",
  "numberAnswers" => 4,
  "numberFollowers" => 865,
  "votosPositivos" => 64,
  "votosNegativos" => 8,
  "date" => 1456850220,
  "active" => true
);

  $question2 = array(
  "title" => "Que país tem a pior gastronomia na vossa opinião?",
  "content" => "<p class=\"medium no-margin align-justify\">
Desta maneira, a percepção das dificuldades promove a alavancagem do sistema de participação geral. O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais. O incentivo ao avanço tecnológico, assim como a execução dos pontos do programa representa uma abertura para a melhoria das novas proposições. Neste sentido, a expansão dos mercados mundiais estimula a padronização das condições inegavelmente apropriadas?
</p>",
  "idAutor" => "Diogo Marques",
  "numberAnswers" => 4,
  "numberFollowers" => 865,
  "votosPositivos" => 2,
  "votosNegativos" => 23,
  "date" => 1456850220,
  "active" => true
);

  $question3 = array(
  "title" => "Qual foi o comentário mais hilariante que encontraram em código?",
  "content" => "<p class=\"medium no-margin align-justify\">
Desta maneira, a percepção das dificuldades promove a alavancagem do sistema de participação geral. O cuidado em identificar pontos críticos no início da atividade geral de formação de atitudes cumpre um papel essencial na formulação do remanejamento dos quadros funcionais. O incentivo ao avanço tecnológico, assim como a execução dos pontos do programa representa uma abertura para a melhoria das novas proposições. Neste sentido, a expansão dos mercados mundiais estimula a padronização das condições inegavelmente apropriadas?
</p>",
  "idAutor" => "Diogo Marques",
  "numberAnswers" => 4,
  "numberFollowers" => 865,
  "votosPositivos" => 7,
  "votosNegativos" => 1,
  "date" => 1456850220,
  "active" => false
);

function printFirstQuestion($questionData){
  printQuestion($questionData, true, false);
}

function printLastQuestion($questionData){
  printQuestion($questionData, false, true);
}

function printQuestionSmall($questionData, $lastQuestion) {
  $questionScore = $questionData["votosPositivos"] - $questionData["votosNegativos"];?>
  <article class="question">
  <h5 class="slab quarter-vertical-space">
    <a class="black" href="view_question.php"><?=$questionData["title"]?></a>
    <?if(!$questionData["active"]){?>
      <small class="ink-badge black"><i class="fa fa-check"></i>&nbsp;fechada</small>
    <?}?>
  </h5>
  <div class="condensed author-panel quarter-vertical-space">
    <div>
      <p class="no-margin">
        <a class="medium" href="view_profile.php"><?=$questionData["idAutor"]?></a>
        &bull;
        <small>Terça-feira, 1 de Março de 2016</small>
        &bull;
        <span class="medium">
          <strong><?=$questionData["numberAnswers"]?></strong>&nbsp;respostas
        </span>
        &bull;
        <span class="medium">
          <?if($questionScore>0) echo "<strong class=\"positive-score\">";
            elseif($questionScore<0) echo "<strong class=\"negative-score\">";
            else echo "<strong>";
          ?><?=$questionScore?>
          </strong>pontos
        </span>
      </p>
    </div>
  </div>
  <?=$questionData["content"]?>
  </article>   
  <?if(!$lastQuestion){
    echo "<hr>";
  }
}

function printQuestion($questionData, $firstQuestion, $lastQuestion){
  $questionScore = $questionData["votosPositivos"] - $questionData["votosNegativos"];
?>

  <!-- PERGUNTA 1: título -->
  <article class="question">
    <?if($firstQuestion){?>
      <h4 class="slab half-top-padding quarter-vertical-space">
    <?}else{?>
      <h4 class="slab quarter-vertical-space">
    <?}?>
    <a class="black" href="view_question.php"><?=$questionData["title"]?></a>
    <?if(!$questionData["active"]){?>
      <span class="ink-badge black small"><i class="fa fa-check"></i>&nbsp;fechada</span>
    <?}?>
  </h4>

  <!-- PERGUNTA 1: pontuação -->
  <div class="align-center quarter-padding push-right">
    <?
    if($questionScore>0) echo "<h3 class=\"quarter-vertical-space positive-score\">";
    elseif($questionScore<0) echo "<h3 class=\"quarter-vertical-space negative-score\">";
    else echo "<h3 class=\"quarter-vertical-space\">";
    ?>
    <?=$questionScore?>
    </h3>
    <p class="medium">(
    <?=$questionData["votosPositivos"]?>
    <i class="fa fa-thumbs-up"></i>
    <?=$questionData["votosNegativos"]?>
    <i class="fa fa-thumbs-down"></i>
    )</p>
  </div>

  <!-- PERGUNTA 1: autor -->
  <div class="author-panel quarter-vertical-space">
    <img class="img-circle push-left quarter-padding" src="holder.js/64x64/auto/ink" alt="">
    <div class="half-padding">
      <p class="no-margin">
        <a href="view_profile.php"><strong><?=$questionData["idAutor"]?></strong></a>
        <span class="small">FEUP</span>
      </p>
      <p class="medium no-margin">
        <small>Terça-feira, 1 de Março de 2016</small>
        &bull;
        <span class="medium">
          <strong><?=$questionData["numberAnswers"]?></strong>&nbsp;Respostas
        </span>
      </p>
    </div>
  </div>


  <!-- PERGUNTA 1: conteúdo -->
  <?=$questionData["content"]?>


  <!-- PERGUNTA 1:: button group -->
  <div class="button-toolbar quarter-top-padding">
    <div class="button-group small">
      <a class="ink-button black" href="reply.php#reply-form">
        <i class="fa fa-pencil"></i>&nbsp;Responder
      </a>
      <button class="ink-button black">
        <i class="fa fa-feed"></i>&nbsp;Seguir&nbsp;
        <strong><?=$questionData["numberFollowers"]?></strong>
      </button>
    </div>
    <div class="button-group small">
      <button class="ink-button black">
        <i class="fa fa-thumbs-up"></i>&nbsp;Gosto&nbsp;
        <strong><?=$questionData["votosPositivos"]?></strong>
      </button>
      <button class="ink-button black">
        <i class="fa fa-thumbs-down"></i>&nbsp;Não gosto&nbsp;
        <strong><?=$questionData["votosNegativos"]?></strong>
      </button>
    </div>
  </div>
  </article>
  <?if(!$lastQuestion){
    echo "<hr>";
  }
}?>