<?
  include_once('../../config/init.php');
  include_once('../../config/security.php');

  if (safe_check($_GET, 'idPergunta')) {

    $idPergunta = safe_getId($_GET, 'idPergunta');

    if (safe_check($_POST, 'ultimaResposta')) {

      $ultimaResposta = safe_getId($_POST, 'ultimaResposta');
      $stmt = $db->prepare("SELECT Resposta.idResposta,
          Utilizador.idUtilizador,
          Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
          Utilizador.username,
          Instituicao.sigla,
          Contribuicao.descricao,
          COALESCE(TabelaComentarios.count, 0) AS numeroComentarios,
          COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
          COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
          COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
          EXTRACT(EPOCH FROM Contribuicao.dataHora) as dataHora,
          Resposta.melhorResposta
        FROM Resposta
        JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
        JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
        JOIN Instituicao ON Instituicao.idInstituicao = Utilizador.idInstituicao
        LEFT JOIN (SELECT idResposta,
          SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
          SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
          FROM VotoResposta
          GROUP BY idResposta)
          AS TabelaVotos
          USING (idResposta)
        LEFT JOIN (SELECT idResposta, COUNT(*)
          FROM ComentarioResposta
          GROUP BY idResposta)
          AS TabelaComentarios
          USING (idResposta)
        WHERE Resposta.idPergunta = :idPergunta
        AND Resposta.idResposta > :ultimaResposta
        ORDER BY Contribuicao.dataHora DESC");
      $stmt->bindParam(":ultimaResposta", $ultimaResposta, PDO::PARAM_INT);
    }
    else {

      $stmt = $db->prepare("SELECT Resposta.idResposta,
          Utilizador.idUtilizador,
          Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
          Utilizador.username,
          Instituicao.sigla,
          Contribuicao.descricao,
          COALESCE(TabelaComentarios.count, 0) AS numeroComentarios,
          COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
          COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
          COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
          EXTRACT(EPOCH FROM Contribuicao.dataHora) as dataHora,
          Resposta.melhorResposta
        FROM Resposta
        JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
        JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
        JOIN Instituicao ON Instituicao.idInstituicao = Utilizador.idInstituicao
        LEFT JOIN (SELECT idResposta,
            SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
            SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
            FROM VotoResposta
            GROUP BY idResposta)
            AS TabelaVotos
            USING (idResposta)
        LEFT JOIN (SELECT idResposta, COUNT(*)
            FROM ComentarioResposta
            GROUP BY idResposta)
            AS TabelaComentarios
            USING (idResposta)
        WHERE Resposta.idPergunta = :idPergunta
        ORDER BY Contribuicao.dataHora DESC");
    }

    $stmt->bindParam(":idPergunta", $idPergunta, PDO::PARAM_INT);
    $stmt->execute();
    echo json_encode($stmt->fetchAll());
  }
  else {
    http_response_code(400);
  }
?>