/*--------------------------------------------*/
/* SQL401: SUBMETER RESPOSTA                  */
/*--------------------------------------------*/
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
WITH NovaResposta AS (
  INSERT INTO Contribuicao(idContribuicao, idUtilizador, descricao)
  VALUES(DEFAULT, :idUtilizador, :descricao) RETURNING idContribuicao
) INSERT INTO Resposta(idResposta, idPergunta)
  SELECT idContribuicao, :idPergunta
  FROM NovaResposta;
COMMIT;

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
DELETE FROM Contribuicao
WHERE idContribuicao = :idResposta;

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
SELECT COALESCE(COUNT(valor) FILTER (WHERE valor = 1), 0) AS votosPositivos,
       COALESCE(COUNT(valor) FILTER (WHERE valor = -1), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao
FROM VotoResposta
WHERE idResposta = :idResposta
GROUP BY idResposta;

/*--------------------------------------------*/
/* SQL407: OBTER COMENTÁRIOS                  */
/*--------------------------------------------*/

-- se não for especificado nenhum comentário como referência
SELECT Contribuicao.idContribuicao,
       Contribuicao.descricao,
       to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') as dataHora,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.removido
FROM ComentarioResposta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
NATURAL JOIN Utilizador
WHERE idResposta = :idResposta;

-- se for especificado um ultimoComentario como referência
SELECT Contribuicao.idContribuicao,
       Contribuicao.descricao,
       to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') as dataHora,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.removido
FROM ComentarioResposta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
NATURAL JOIN Utilizador
WHERE idResposta = :idResposta
AND idComentario > :ultimoComentario;

/*--------------------------------------------*/
/* SQL408: INSERIR COMENTÁRIO                 */
/*--------------------------------------------*/
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
WITH NovoComentario AS (
  INSERT INTO Contribuicao(idContribuicao, idUtilizador, descricao)
  VALUES(DEFAULT, :idUtilizador, :descricao) RETURNING idContribuicao
) INSERT INTO ComentarioResposta(idComentario, idResposta)
  SELECT idContribuicao, :idResposta
  FROM NovoComentario;
COMMIT;

/*--------------------------------------------*/
/* SQL409: APAGAR COMENTÁRIO                  */
/*--------------------------------------------*/
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
       COALESCE(COUNT(valor) FILTER (WHERE valor = 1), 0) AS votosPositivos,
       COALESCE(COUNT(valor) FILTER (WHERE valor = -1), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao
FROM Contribuicao
INNER JOIN Resposta ON Contribuicao.idContribuicao = Resposta.idResposta
INNER JOIN Utilizador USING(idUtilizador)
INNER JOIN Pergunta USING (idPergunta)
LEFT JOIN VotoResposta USING(idResposta)
WHERE Contribuicao.idUtilizador = :idUtilizador
GROUP BY Contribuicao.idContribuicao, Pergunta.idPergunta, Resposta.idResposta
ORDER BY Contribuicao.dataHora DESC;