/*--------------------------------------------*/
/* SQL501: LISTAR CATEGORIAS                  */
/*--------------------------------------------*/
SELECT Categoria.*, COUNT(DISTINCT idPergunta) AS numeroPerguntas
FROM Categoria
NATURAL LEFT JOIN Pergunta
GROUP BY idCategoria
ORDER BY nome;

/*--------------------------------------------*/
/* SQL502: LISTAR CATEGORIAS RELACIONADAS     */
/*--------------------------------------------*/
SELECT Categorias.*
FROM Categoria
INNER JOIN CategoriaInstituicao CI1 USING(idCategoria)
INNER JOIN CategoriaInstituicao CI2 USING(idInstituicao)
INNER JOIN Categoria Categorias ON Categorias.idCategoria = CI2.idCategoria
WHERE Categoria.idCategoria = :idCategoria
AND Categorias.idCategoria <> Categoria.idCategoria
GROUP BY Categorias.idCategoria
ORDER BY random() LIMIT 5;

/*--------------------------------------------*/
/* SQL503: LISTAR INSTITUIÇÕES ASSOCIADAS     */
/*--------------------------------------------*/
SELECT idInstituicao, sigla
FROM Instituicao
NATURAL JOIN CategoriaInstituicao
WHERE idCategoria = :idCategoria;

/*--------------------------------------------*/
/* SQL504: OBTER INFOMRAÇÕES DA CATEGORIA     */
/*--------------------------------------------*/
SELECT * FROM Categoria
WHERE idCategoria = :idCategoria;

/*--------------------------------------------*/
/* SQL505: OBTER PERGUNTAS DA CATEGORIA       */
/*--------------------------------------------*/
SELECT Pergunta.idPergunta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.username,
       Utilizador.removido,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.dataHora,
       Pergunta.ativa,
       Pergunta.respostas,
       Pergunta.pontuacao,
       COALESCE(COUNT(valor) FILTER (WHERE valor = 1), 0) AS votosPositivos,
       COALESCE(COUNT(valor) FILTER (WHERE valor = -1), 0) AS votosNegativos
FROM Pergunta
INNER JOIN Utilizador USING(idUtilizador)
LEFT JOIN VotoPergunta USING(idPergunta)
WHERE idCategoria = :idCategoria
GROUP BY idPergunta, Utilizador.idUtilizador
ORDER BY dataHora DESC;

/*--------------------------------------------*/
/* SQL506: EDITAR CATEGORIA                   */
/*--------------------------------------------*/
UPDATE Categoria
SET nome = :nome
WHERE idCategoria = :idCategoria;

/*--------------------------------------------*/
/* SQL507: ADICIONAR CATEGORIA                */
/*--------------------------------------------*/
INSERT INTO Categoria(idCategoria, nome) VALUES(DEFAULT, :nome);

/*--------------------------------------------*/
/* SQL508: APAGAR CATEGORIA                   */
/*--------------------------------------------*/
DELETE FROM Categoria WHERE idCategoria = :idCategoria;

/*--------------------------------------------*/
/* SQL509: LISTAR CATEGORIAS POPULARES        */
/*--------------------------------------------*/
SELECT Categoria.*, COUNT(DISTINCT idPergunta) AS numeroPerguntas
FROM Categoria
INNER JOIN Pergunta USING(idCategoria)
GROUP BY idCategoria, idPergunta
ORDER BY numeroPerguntas DESC LIMIT 5;