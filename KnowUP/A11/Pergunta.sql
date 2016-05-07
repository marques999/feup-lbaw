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
       COALESCE(TabelaSeguidores.count, 0) AS numeroSeguidores,
       COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
       COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
       COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao
FROM Pergunta
JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
JOIN Instituicao USING(idInstituicao)
LEFT JOIN (SELECT idPergunta,
  SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
  SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
  FROM VotoPergunta
  WHERE idPergunta = :idPergunta
  GROUP BY idPergunta)
  AS TabelaVotos
  USING (idPergunta)
LEFT JOIN (SELECT idPergunta, COUNT(*)
  FROM Seguidor
  WHERE idPergunta = :idPergunta
  GROUP BY idPergunta)
  AS TabelaSeguidores
  USING (idPergunta)
WHERE Pergunta.idPergunta = :idPergunta

/*--------------------------------------------*/
/* SQL302: OBTER INFORMAÇÕES DO UTILIZADOR    */
/*--------------------------------------------*/
SELECT VotoPergunta.valor, Seguidor.idSeguidor
FROM Pergunta
LEFT JOIN VotoPergunta 
ON VotoPergunta.idPergunta = Pergunta.idPergunta 
AND VotoPergunta.idAutor = :idUtilizador
LEFT JOIN Seguidor 
ON Seguidor.idPergunta = Pergunta.idPergunta 
AND Seguidor.idSeguidor = :idUtilizador
WHERE Pergunta.idPergunta = :idPergunta;

/*--------------------------------------------*/
/* SQL303: OBTER RESPOSTAS                    */
/*--------------------------------------------*/
SELECT Resposta.idResposta,
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
       COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
       Resposta.melhorResposta
FROM Resposta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
INNER JOIN Utilizador USING(idUtilizador)
LEFT JOIN Instituicao ON Instituicao.idInstituicao = Utilizador.idInstituicao
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
INNER JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
WHERE CategoriaInstituicao.idCategoria = :idCategoria
AND Pergunta.idPergunta <> :idPergunta
GROUP BY Pergunta.idPergunta, Utilizador.username
ORDER BY random()
LIMIT 5;

/*--------------------------------------------*/
/* SQL305: SUBMETER PERGUNTA                  */
/*--------------------------------------------*/
-- se utilizador não preencher formulário a descrição da pergunta
INSERT INTO Pergunta(idPergunta, idCategoria, idAutor, titulo)
VALUES(DEFAULT, :idCategoria, :idUtilizador, :titulo);

-- se utilizador preencher formulário com a descrição da pergunta
INSERT INTO Pergunta(idPergunta, idCategoria, idAutor, titulo, descricao)
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
AND idAutor = :idUtilizador;

/*--------------------------------------------*/
/* SQL308: APAGAR PERGUNTA                    */
/*--------------------------------------------*/
DELETE FROM Pergunta
WHERE idPergunta = :idPergunta
AND idAutor = :idUtilizador;

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
SELECT COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(COUNT(*), 0) AS pontuacao
FROM VotoPergunta
WHERE idPergunta = :idPergunta
GROUP BY idPergunta;

/*--------------------------------------------*/
/* SQL313: OBTER COMENTÁRIOS                  */
/*--------------------------------------------*/
SELECT ComentarioPergunta.idComentario,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.removido,
       Contribuicao.descricao,
       to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') as dataHora
FROM ComentarioPergunta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
NATURAL JOIN Utilizador
WHERE idPergunta = :idPergunta
ORDER BY idComentario;

SELECT ComentarioPergunta.idComentario,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.removido,
       Contribuicao.descricao,
       to_char(Contribuicao.dataHora, 'FMDay, DD FMMonth YYYY HH24:MI') as dataHora
FROM ComentarioPergunta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
NATURAL JOIN Utilizador
WHERE idPergunta = :idPergunta
AND idComentario > :ultimoComentario
ORDER BY idComentario;

/*--------------------------------------------*/
/* SQL314: INSERIR COMENTÁRIO                 */
/*--------------------------------------------*/
INSERT INTO Contribuicao(idContribuicao, idAutor, descricao)
VALUES(DEFAULT, :idUtilizador, :descricao);

SELECT contribuicao_idcontribuicao_seq AS idComentario;

INSERT INTO ComentarioPergunta(idComentario, idPergunta)
VALUES(:idComentario, :idPergunta);

/*--------------------------------------------*/
/* SQL315: APAGAR COMENTÁRIO                  */
/*--------------------------------------------*/
DELETE FROM ComentarioPergunta
WHERE idComentario = :idComentario
AND idPergunta = :idPergunta;

DELETE FROM Contribuicao
WHERE idContribuicao = :idComentario
AND idAutor = :idUtilizador;

/*--------------------------------------------*/
/* SQL316: VERIFICAR AUTOR DA PERGUNTA        */
/*--------------------------------------------*/
SELECT FROM Pergunta
WHERE idPergunta = :idPergunta
AND idAutor = :idUtilizador;

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
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
      COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao
    FROM Utilizador
    JOIN Pergunta ON Utilizador.idUtilizador = Pergunta.idAutor
    LEFT JOIN VotoPergunta USING(idPergunta)
    WHERE Utilizador.idUtilizador = :idUtilizador
    GROUP BY Pergunta.idPergunta
    ORDER BY Pergunta.dataHora DESC;