<?
  include_once('../../config/init.php');
  include_once('../../database/resposta.php');

  if (safe_check($_SESSION, 'idUtilizador')) {
    $idUtilizador = safe_getId($_SESSION, 'idUtilizador');
  }
  else {
    safe_login();
  }

  if (safe_check($_POST, 'idPergunta')) {
    $idPergunta = safe_getId($_POST, 'idPergunta');
  }
  else {
    safe_formerror('Deve especificar uma pergunta primeiro!');
  }

  if (safe_strcheck($_POST, 'descricao')) {
    $descricao = safe_trim($_POST, 'descricao');
  }
  else {
    safe_formerror('O corpo da resposta não pode estar em branco!');
  }

  try {

    $idResposta = resposta_inserirResposta($idPergunta, $idUtilizador, $descricao);

    if ($idResposta > 0) {
      safe_redirect("pergunta/view.php?id=$idPergunta#reply-$idResposta");
    }
    else {
      safe_formerror('Erro desconhecido: outra resposta com este identificador já existe?');
    }
  }
  catch (PDOException $e) {
    safe_formerror($e->getMessage());
  }
?>