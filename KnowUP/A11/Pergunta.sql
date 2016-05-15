/*--------------------------------------------*/
/* SQL301: OBTER INFORMAÇÕES DA PERGUNTA      */
/*--------------------------------------------*/
SELECT Pergunta.idPergunta,
       Pergunta.idCategoria,
       Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeutilizador,
       Utilizador.removido,
       Instituicao.sigla,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.dataHora,
       Pergunta.ativa,
       Pergunta.pontuacao,
       COALESCE(TabelaSeguidores.count, 0) AS numeroSeguidores,
       COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
       COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos
FROM Pergunta
INNER JOIN Utilizador USING(idUtilizador)
LEFT JOIN Instituicao USING(idInstituicao)
LEFT JOIN (SELECT idPergunta,
  COUNT(valor) FILTER (WHERE valor = 1) AS votosPositivos,
  COUNT(valor) FILTER (WHERE valor = -1) AS votosNegativos
  FROM VotoPergunta
  WHERE idPergunta = idPergunta
  GROUP BY idPergunta)
  AS TabelaVotos
  USING (idPergunta)
LEFT JOIN (SELECT idPergunta, COUNT(*)
  FROM Seguidor
  WHERE idPergunta = idPergunta
  GROUP BY idPergunta)
  AS TabelaSeguidores
  USING (idPergunta)
WHERE idPergunta = :idPergunta;

/*--------------------------------------------*/
/* SQL302: OBTER INFORMAÇÕES DO UTILIZADOR    */
/*--------------------------------------------*/
SELECT VotoPergunta.valor, Seguidor.idSeguidor
FROM Pergunta
LEFT JOIN VotoPergunta
  ON VotoPergunta.idPergunta = Pergunta.idPergunta
  AND VotoPergunta.idUtilizador = :idUtilizador
LEFT JOIN Seguidor
  ON Seguidor.idPergunta = Pergunta.idPergunta
  AND Seguidor.idSeguidor = :idUtilizador
WHERE Pergunta.idPergunta = :idPergunta;

/*--------------------------------------------*/
/* SQL303: OBTER RESPOSTAS                    */
/*--------------------------------------------*/
SELECT Resposta.idResposta,
       Resposta.melhorResposta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.username,
       Utilizador.removido,
       Instituicao.sigla,
       Contribuicao.descricao,
       Contribuicao.dataHora,
       COALESCE(TabelaComentarios.count, 0) AS numeroComentarios,
       COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
       COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
       COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao
FROM Resposta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
INNER JOIN Utilizador USING(idUtilizador)
LEFT JOIN Instituicao USING(idInstituicao)
LEFT JOIN (SELECT idResposta,
  COUNT(valor) FILTER (WHERE valor = 1) AS votosPositivos,
  COUNT(valor) FILTER (WHERE valor = -1) AS votosNegativos
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
ORDER BY Resposta.idResposta;

/*--------------------------------------------*/
/* SQL304: LISTAR PERGUNTAS RELACIONADAS      */
/*--------------------------------------------*/
SELECT Pergunta.idPergunta,
       Pergunta.titulo,
       Utilizador.username
FROM CategoriaInstituicao
INNER JOIN CategoriaInstituicao CategoriasRelacionadas USING(idInstituicao)
INNER JOIN Pergunta ON Pergunta.idCategoria = CategoriasRelacionadas.idCategoria
INNER JOIN Utilizador USING(idUtilizador)
WHERE CategoriaInstituicao.idCategoria = :idCategoria
AND Pergunta.idPergunta <> :idPergunta
GROUP BY Pergunta.idPergunta, Utilizador.username
ORDER BY random() LIMIT 5;

/*--------------------------------------------*/
/* SQL305: SUBMETER PERGUNTA                  */
/*--------------------------------------------*/
-- se utilizador não preencher a descrição da pergunta no formulário
INSERT INTO Pergunta(idPergunta, idCategoria, idUtilizador, titulo)
VALUES(DEFAULT, :idCategoria, :idUtilizador, :titulo);

-- se utilizador preencher formulário com a descrição da pergunta
INSERT INTO Pergunta(idPergunta, idCategoria, idUtilizador, titulo, descricao)
VALUES(DEFAULT, :idCategoria, :idUtilizador, :titulo, :descricao);

/*--------------------------------------------*/
/* SQL306: ATUALIZAR PERGUNTA                 */
/*--------------------------------------------*/
UPDATE Pergunta
SET idCategoria = :idCategoria,
    titulo = :titulo,
    descricao = :descricao
WHERE idPergunta = :idPergunta;

/*--------------------------------------------*/
/* SQL307: FECHAR PERGUNTA                    */
/*--------------------------------------------*/
UPDATE Pergunta
SET ativa = FALSE
WHERE idPergunta = :idPergunta
AND idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL308: APAGAR PERGUNTA                    */
/*--------------------------------------------*/
DELETE FROM Pergunta
WHERE idPergunta = :idPergunta
AND idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL309: SEGUIR PERGUNTA                    */
/*--------------------------------------------*/
INSERT INTO Seguidor(idSeguidor, idPergunta)
VALUES(:idUtilizador, :idPergunta);

/*--------------------------------------------*/
/* SQL310: UNFOLLOW PERGUNTA                  */
/*--------------------------------------------*/
DELETE FROM Seguidor
WHERE idSeguidor = :idUtilizador
AND idPergunta = :idPergunta;

/*--------------------------------------------*/
/* SQL311: REGISTAR VOTO                      */
/*--------------------------------------------*/
SELECT registarVotoPergunta(:idPergunta, :idUtilizador, :valor);

/*--------------------------------------------*/
/* SQL312: OBTER VOTOS                        */
/*--------------------------------------------*/
SELECT COALESCE(COUNT(valor) FILTER (WHERE valor = 1), 0) AS votosPositivos,
       COALESCE(COUNT(valor) FILTER (WHERE valor = -1), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao
FROM VotoPergunta
WHERE idPergunta = :idPergunta
GROUP BY idPergunta;

/*--------------------------------------------*/
/* SQL313: OBTER COMENTÁRIOS                  */
/*--------------------------------------------*/

-- se não for especificado nenhum comentário como referência
SELECT ComentarioPergunta.idComentario,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.removido,
       Contribuicao.descricao,
       to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') AS dataHora
FROM ComentarioPergunta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
NATURAL JOIN Utilizador
WHERE idPergunta = :idPergunta
ORDER BY idComentario;

-- se for especificado um ultimoComentario como referência
SELECT ComentarioPergunta.idComentario,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.removido,
       Contribuicao.descricao,
       to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') AS dataHora
FROM ComentarioPergunta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
NATURAL JOIN Utilizador
WHERE idPergunta = :idPergunta
AND idComentario > :ultimoComentario
ORDER BY idComentario;

/*--------------------------------------------*/
/* SQL314: INSERIR COMENTÁRIO                 */
/*--------------------------------------------*/
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
WITH NovoComentario AS (
  INSERT INTO Contribuicao(idContribuicao, idUtilizador, descricao)
  VALUES(DEFAULT, :idUtilizador, :descricao) RETURNING idContribuicao
) INSERT INTO ComentarioPergunta(idComentario, idPergunta)
  SELECT idContribuicao, :idPergunta
  FROM NovoComentario;
COMMIT;

/*--------------------------------------------*/
/* SQL315: APAGAR COMENTÁRIO                  */
/*--------------------------------------------*/
DELETE FROM Contribuicao
WHERE idContribuicao = :idComentario
AND idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL316: VERIFICAR AUTOR DA PERGUNTA        */
/*--------------------------------------------*/
SELECT idPergunta FROM Pergunta
WHERE idPergunta = :idPergunta
AND idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL317: VERIFICAR AUTOR DO COMENTÀRIO      */
/*--------------------------------------------*/
SELECT idUtilizador FROM Contribuicao
WHERE idContribuicao = :idContribuicao
AND idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL318: LISTAR PERGUNTAS DO UTILIZADOR     */
/*--------------------------------------------*/
SELECT Pergunta.idPergunta,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.dataHora,
       Pergunta.ativa,
       Pergunta.pontuacao,
       COALESCE(COUNT(valor) FILTER (WHERE valor = 1), 0) AS votosPositivos,
       COALESCE(COUNT(valor) FILTER (WHERE valor = -1), 0) AS votosNegativos
FROM Pergunta
NATURAL JOIN Utilizador
LEFT JOIN VotoPergunta USING(idPergunta)
WHERE Pergunta.idUtilizador = :idUtilizador
GROUP BY idPergunta
ORDER BY dataHora DESC;