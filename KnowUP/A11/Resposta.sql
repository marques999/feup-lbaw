/*--------------------------------------------*/
/* INSERIR RESPOSTA                           */
/*--------------------------------------------*/
INSERT INTO Contribuicao(idContribuicao, idUtilizador. descricao)
VALUES(DEFAULT, :idUtilizador, :descricao);

/*--------------------------------------------*/
/* EDITAR RESPOSTA                            */
/*--------------------------------------------*/
UPDATE Contribuicao
SET descricao = :descricao
WHERE idContribuicao = :idResposta
AND idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* APAGAR RESPOSTA                            */
/*--------------------------------------------*/
DELETE FROM Contribuicao WHERE idContribuicao = :idResposta;

/*--------------------------------------------*/
/* DESTACAR RESPOSTA                          */
/*--------------------------------------------*/
UPDATE Resposta
SET melhorResposta = TRUE
WHERE idPergunta = :idPergunta
AND idResposta = :idResposta;

/*--------------------------------------------*/
/* INSERIR COMENTÁRIO (RESPOSTA)              */
/*--------------------------------------------*/
INSERT INTO Contribuicao(idContribuicao, idUtilizador, descricao)
    VALUES(DEFAULT, :idUtilizador, :descricao);

SELECT contribuicao_idcontribuicao_seq;

INSERT INTO ComentarioResposta(idComentario, idResposta)
    VALUES(:idComentario, :idResposta);

/*--------------------------------------------*/
/* REMOVER COMENTÁRIO (RESPOSTA)              */
/*--------------------------------------------*/
DELETE FROM ComentarioResposta
WHERE idComentario = :idComentario
AND idResposta = :idResposta;

DELETE FROM Contribuicao
WHERE idContribuicao = :idComentario
AND idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* REGISTAR VOTO (RESPOSTA)                   */
/*--------------------------------------------*/
SELECT registarVotoResposta(:idResposta, :idUtilizador, :valor);

/*--------------------------------------------*/
/* OBTER VOTOS (RESPOSTA)                     */
/*--------------------------------------------*/
SELECT COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(COUNT(*), 0) AS pontuacao
FROM VotoResposta
WHERE idResposta = :idResposta
GROUP BY idResposta;

/*--------------------------------------------*/
/* OBTER COMENTÁRIOS (RESPOSTA)               */
/*--------------------------------------------*/
SELECT ComentarioResposta.idComentario,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.removido,
       Contribuicao.descricao,
       to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') as dataHora
FROM ComentarioResposta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
NATURAL JOIN Utilizador
WHERE idResposta = :idResposta;

/*--------------------------------------------*/
/* OBTER COMENTÁRIOS APÓS ÚLTIMO (RESPOSTA)   */
/*--------------------------------------------*/
SELECT ComentarioResposta.idComentario,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.removido,
       Contribuicao.descricao,
       to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') as dataHora
FROM ComentarioResposta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
NATURAL JOIN Utilizador
WHERE ComentarioResposta.idResposta = :idResposta
AND ComentarioResposta.idComentario > :ultimoComentario;