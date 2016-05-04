/*--------------------------------------------*/
/* ADICIONAR CATEGORIA                        */
/*--------------------------------------------*/
INSERT INTO Categoria(idCategoria, nome) VALUES(DEFAULT, :nome);

/*--------------------------------------------*/
/* EDITAR CATEGORIA                           */
/*--------------------------------------------*/
UPDATE Categoria SET nome = :nome WHERE idCategoria = :idCategoria;

/*--------------------------------------------*/
/* APAGAR CATEGORIA                           */
/*--------------------------------------------*/
DELETE FROM Categoria WHERE idCategoria = :idCategoria;

/*--------------------------------------------*/
/* LISTAR CATEGORIAS                          */
/*--------------------------------------------*/
SELECT Categoria.*, COUNT(DISTINCT Pergunta.idPergunta) AS numeroPerguntas
FROM Categoria
NATURAL LEFT JOIN Pergunta
GROUP BY idCategoria
ORDER BY nome;

/*--------------------------------------------*/
/* LISTAR CATEGORIAS MAIS POPULARES           */
/*--------------------------------------------*/
SELECT Categoria.*, COUNT(DISTINCT Pergunta.idPergunta) AS numeroPerguntas
FROM Categoria
INNER JOIN Pergunta USING(idCategoria)
GROUP BY Categoria.idCategoria, Pergunta.idPergunta
ORDER BY numeroPerguntas DESC
LIMIT 5;

/*--------------------------------------------*/
/* LISTAR CATEGORIAS RELACIONADAS             */
/*--------------------------------------------*/
SELECT Categorias.idCategoria, Categorias.nome
FROM Categoria
INNER JOIN CategoriaInstituicao CI1 USING(idCategoria)
INNER JOIN CategoriaInstituicao CI2 USING(idInstituicao)
INNER JOIN Categoria Categorias ON Categorias.idCategoria = CI2.idCategoria
WHERE Categoria.idCategoria = :idCategoria
AND Categorias.idCategoria <> Categoria.idCategoria
GROUP BY Categorias.idCategoria
ORDER BY random()
LIMIT 5;

/*--------------------------------------------*/
/* OBTER INFOMRAÇÕES DA CATEGORIA             */
/*--------------------------------------------*/
SELECT * FROM Categoria WHERE idCategoria = :idCategoria;

/*--------------------------------------------*/
/* OBTER PERGUNTAS DA CATEGORIA               */
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
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao
FROM Pergunta
LEFT JOIN VotoPergunta USING(idPergunta)
LEFT JOIN (SELECT idPergunta, COUNT(*)
  FROM Resposta
  GROUP BY idPergunta)
  AS TabelaRespostas
  USING (idPergunta)
INNER JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
WHERE Pergunta.idCategoria = :idCategoria
GROUP BY Pergunta.idPergunta, TabelaRespostas.count, Utilizador.idUtilizador
ORDER BY Pergunta.dataHora DESC;