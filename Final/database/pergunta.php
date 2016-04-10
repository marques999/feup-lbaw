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
  "score" => 56,
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
  "score" => -21,
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
  "score" => 6,
  "date" => 1456850220,
  "active" => false
);

$questions = array($question1, $question2, $question3);
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
    <a class="black" href="view/1"><?=$questionData["title"]?></a>
    <?if(!$questionData["active"]){?>
      <small class="ink-badge black"><i class="fa fa-check"></i>&nbsp;fechada</small>
    <?}?>
  </h5>
  <div class="condensed author-panel quarter-vertical-space">
    <div>
      <p class="no-margin">
        <a class="medium" href="profile/2"><?=$questionData["idAutor"]?></a>
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
}?>