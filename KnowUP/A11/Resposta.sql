/*--------------------------------------------*/
/* SQL401: SUBMETER RESPOSTA                  */
/*--------------------------------------------*/
INSERT INTO Contribuicao(idContribuicao, idUtilizador. descricao)
VALUES(DEFAULT, :idUtilizador, :descricao);

/*--------------------------------------------*/
/* SQL402: ATUALIZAR RESPOSTA                 */
/*--------------------------------------------*/
UPDATE Contribuicao
SET descricao = :descricao
WHERE idContribuicao = :idResposta
AND idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL403: APAGAR RESPOSTA                    */
/*--------------------------------------------*/
DELETE FROM Contribuicao WHERE idContribuicao = :idResposta;

/*--------------------------------------------*/
/* SQL404: DESTACAR RESPOSTA                  */
/*--------------------------------------------*/
UPDATE Resposta
SET melhorResposta = TRUE
WHERE idPergunta = :idPergunta
AND idResposta = :idResposta;

/*--------------------------------------------*/
/* SQL405: REGISTAR VOTO                      */
/*--------------------------------------------*/
SELECT registarVotoResposta(:idResposta, :idUtilizador, :valor);

/*--------------------------------------------*/
/* SQL406: OBTER VOTOS                        */
/*--------------------------------------------*/
SELECT COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(COUNT(*), 0) AS pontuacao
FROM VotoResposta
WHERE idResposta = :idResposta
GROUP BY idResposta;

/*--------------------------------------------*/
/* SQL407: OBTER COMENTÁRIOS                  */
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

/*--------------------------------------------*/
/* SQL408: INSERIR COMENTÁRIO                 */
/*--------------------------------------------*/
INSERT INTO Contribuicao(idContribuicao, idUtilizador, descricao)
    VALUES(DEFAULT, :idUtilizador, :descricao);

SELECT contribuicao_idcontribuicao_seq AS idComentario;

INSERT INTO ComentarioResposta(idComentario, idResposta)
    VALUES(:idComentario, :idResposta);

/*--------------------------------------------*/
/* SQL409: APAGAR COMENTÁRIO                  */
/*--------------------------------------------*/
DELETE FROM ComentarioResposta
WHERE idComentario = :idComentario
AND idResposta = :idResposta;

DELETE FROM Contribuicao
WHERE idContribuicao = :idComentario
AND idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL410: VERIFICAR AUTOR DA RESPOSTA        */
/*--------------------------------------------*/
SELECT FROM Contribuicao
WHERE idContribuicao = :idContribuicao
AND idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL411: VERIFICAR AUTOR DO COMENTÀRIO      */
/*--------------------------------------------*/
SELECT idUtilizador FROM Contribuicao
WHERE idContribuicao = :idContribuicao
AND idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL412: LISTAR RESPOSTAS DO UTILIZADOR     */
/*--------------------------------------------*/
SELECT Resposta.idResposta,
       Pergunta.idPergunta,
       Pergunta.titulo,
       Pergunta.ativa,
       Contribuicao.descricao,
       Contribuicao.dataHora,
       Resposta.melhorResposta,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao
FROM Resposta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
LEFT JOIN VotoResposta USING(idResposta)
INNER JOIN Pergunta USING (idPergunta)
INNER JOIN Utilizador USING(idUtilizador)
WHERE Contribuicao.idUtilizador = :idUtilizador
GROUP BY Contribuicao.idContribuicao, Pergunta.idPergunta, Resposta.idResposta
ORDER BY Contribuicao.dataHora DESC;