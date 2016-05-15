/*--------------------------------------------*/
/* SQL601: LISTAR INSTITUIÇÕES                */
/*--------------------------------------------*/
SELECT Instituicao.idInstituicao,
       Instituicao.nome,
       Instituicao.sigla,
       COUNT(DISTINCT CategoriaInstituicao.idCategoria) AS numeroCategorias,
       COUNT(DISTINCT Pergunta.idPergunta) AS numeroPerguntas,
       COUNT(DISTINCT Utilizador.idUtilizador) AS numeroUtilizadores
FROM Instituicao
LEFT JOIN CategoriaInstituicao USING(idInstituicao)
LEFT JOIN Utilizador USING(idInstituicao)
LEFT JOIN Pergunta USING (idCategoria)
GROUP BY idInstituicao
ORDER BY sigla;

/*--------------------------------------------*/
/* SQL602: LISTAR CATEGORIAS ASSOCIADAS       */
/*--------------------------------------------*/
SELECT Categoria.*
FROM CategoriaInstituicao
NATURAL JOIN Categoria
WHERE idInstituicao = :idInstituicao
ORDER BY nome;

/*--------------------------------------------*/
/* SQL603: OBTER INFORMAÇÕES DA INSTITUIÇÃO   */
/*--------------------------------------------*/
-- no caso de ser passado um identificador
SELECT * FROM Instituicao WHERE idInstituicao = :idInstituicao;

-- no caso de ser passada uma sigla
SELECT * FROM Instituicao WHERE sigla = :sigla;

/*--------------------------------------------*/
/* SQL604: OBTER PERGUNTAS DA INSTITUIÇÃO     */
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
FROM CategoriaInstituicao
NATURAL JOIN Pergunta
INNER JOIN Utilizador USING(idUtilizador)
LEFT JOIN VotoPergunta USING(idPergunta)
WHERE CategoriaInstituicao.idInstituicao = :idInstituicao
GROUP BY idPergunta, Utilizador.idUtilizador
ORDER BY dataHora DESC;

/*--------------------------------------------*/
/* SQL605: ADICIONAR INSTITUIÇÃO              */
/*--------------------------------------------*/
INSERT INTO Instituicao(idInstituicao, nome, sigla, morada, contacto, website)
VALUES(DEFAULT, :nome, :sigla, :morada, :contacto, :website);

/*--------------------------------------------*/
/* SQL606: ATUALIZAR INSTITUIÇÃO              */
/*--------------------------------------------*/
UPDATE Instituicao
SET nome = :nome,
    sigla = :sigla,
    morada = :morada,
    contacto = :contacto,
    website = website
WHERE idInstituicao = :idInstituicao;

/*--------------------------------------------*/
/* SQL607: APAGAR INSTITUIÇÃO                 */
/*--------------------------------------------*/
DELETE FROM Instituicao
WHERE idInstituicao = :idInstituicao;

/*--------------------------------------------*/
/* SQL608: ASSOCIAR CATEGORIA                 */
/*--------------------------------------------*/
INSERT INTO CategoriaInstituicao(idInstituicao, idCategoria)
VALUES(:idInstituicao, :idCategoria);

/*--------------------------------------------*/
/* SQL609: REMOVER CATEGORIA                  */
/*--------------------------------------------*/
DELETE FROM CategoriaInstituicao
WHERE idInstituicao = :idInstituicao
AND idCategoria = :idCategoria;