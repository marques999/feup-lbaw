/*--------------------------------------------*/
/* ADICIONAR INSTITUIÇÃO                      */
/*--------------------------------------------*/
INSERT INTO Instituicao(idInstituicao, nome, sigla, morada, contacto, website)
VALUES(DEFAULT, :nome, :sigla, :morada, :contacto, :website);

/*--------------------------------------------*/
/* EDITAR INSTITUIÇÃO                         */
/*--------------------------------------------*/
UPDATE Instituicao
SET nome = :nome,
    sigla = :sigla,
    morada = :morada,
    contacto = :contacto,
    website = website
WHERE idInstituicao = :idInstituicao;

/*--------------------------------------------*/
/* APAGAR INSTITUIÇÃO                         */
/*--------------------------------------------*/
DELETE FROM Instituicao WHERE sigla = :sigla;

/*--------------------------------------------*/
/* ASSOCIAR CATEGORIA                         */
/*--------------------------------------------*/
INSERT INTO CategoriaInstituicao(idInstituicao, idCategoria)
VALUES(:idInstituicao, :idCategoria);

/*--------------------------------------------*/
/* RETIRAR CATEGORIA                          */
/*--------------------------------------------*/
DELETE FROM CategoriaInstituicao
WHERE idInstituicao = :idInstituicao
AND idCategoria = :idCategoria;

/*--------------------------------------------*/
/* LISTAR INSTITUIÇÕES                        */
/*--------------------------------------------*/
SELECT Instituicao.idInstituicao,
       Instituicao.nome,
       Instituicao.sigla,
       COUNT(DISTINCT CategoriaInstituicao.idCategoria) AS numeroCategorias,
       COUNT(DISTINCT Pergunta.idPergunta) AS numeroPerguntas,
       COUNT(DISTINCT Utilizador.idUtilizador) AS numeroUtilizadores
FROM Instituicao
NATURAL LEFT JOIN CategoriaInstituicao
NATURAL LEFT JOIN Pergunta
NATURAL LEFT JOIN Utilizador
GROUP BY idInstituicao
ORDER BY sigla;

/*--------------------------------------------*/
/* LISTAR INSTITUIÇÕES RELACIONADAS           */
/*--------------------------------------------*/
SELECT Instituicao.idInstituicao, Instituicao.sigla
FROM Categoria
NATURAL JOIN CategoriaInstituicao
INNER JOIN Instituicao USING(idInstituicao)
WHERE idCategoria = :idCategoria;

/*--------------------------------------------*/
/* OBTER INFORMAÇÕES DA INSTITUIÇÃO           */
/*--------------------------------------------*/

-- no caso de ser passado um identificador
SELECT * FROM Instituicao WHERE idInstituicao = :idInstituicao;

-- no caso de ser passada uma sigla
SELECT * FROM Instituicao WHERE sigla = :sigla;

/*--------------------------------------------*/
/* OBTER PERGUNTAS DA INSTITUIÇÃO             */
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
FROM CategoriaInstituicao
NATURAL JOIN Pergunta
INNER JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
LEFT JOIN VotoPergunta USING(idPergunta)
LEFT JOIN (SELECT idPergunta, COUNT(*)
  FROM Resposta
  GROUP BY idPergunta)
  AS TabelaRespostas
  USING (idPergunta)
WHERE CategoriaInstituicao.idInstituicao = :idInstituicao
GROUP BY Pergunta.idPergunta, TabelaRespostas.count, Utilizador.idUtilizador
ORDER BY Pergunta.dataHora DESC;