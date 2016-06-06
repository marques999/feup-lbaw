SET SCHEMA 'knowup';

DROP VIEW IF EXISTS PerguntasMaisRecentes;
DROP VIEW IF EXISTS PerguntasMelhorClassificadas;
DROP VIEW IF EXISTS PerguntasSemResposta;
DROP VIEW IF EXISTS VistaInstituicao;

DROP MATERIALIZED VIEW IF EXISTS PerguntasPesquisa;
DROP MATERIALIZED VIEW IF EXISTS UtilizadoresPesquisa;

/*--------------------------------------------*/
/* 1. LISTAR PERGUNTAS MAIS RECENTES          */
/*--------------------------------------------*/

CREATE VIEW PerguntasMaisRecentes AS
SELECT Pergunta.idPergunta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Pergunta.titulo,
       Pergunta.dataHora,
       Pergunta.descricao,
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
    JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    GROUP BY TabelaRespostas.count, Pergunta.idPergunta, Utilizador.idUtilizador
    ORDER BY Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* 2. LISTAR PERGUNTAS MELHOR CLASSIFICADAS   */
/*--------------------------------------------*/

CREATE VIEW PerguntasMelhorClassificadas AS
SELECT Pergunta.idPergunta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.ativa,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao,
       EXTRACT(EPOCH FROM Pergunta.dataHora) as dataHora
    FROM Pergunta
    LEFT JOIN VotoPergunta USING(idPergunta)
    LEFT JOIN (SELECT idPergunta, COUNT(*)
        FROM Resposta
        GROUP BY idPergunta)
        AS TabelaRespostas
        USING (idPergunta)
    JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    GROUP BY TabelaRespostas.count, Pergunta.idPergunta, Utilizador.idUtilizador
    ORDER BY pontuacao DESC;

/*--------------------------------------------*/
/* 3. LISTAR PERGUNTAS NÃO RESPONDIDAS        */
/*--------------------------------------------*/

CREATE VIEW PerguntasSemResposta AS
SELECT Pergunta.idPergunta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.ativa,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao,
       EXTRACT(EPOCH FROM Pergunta.dataHora) as dataHora
    FROM Pergunta
    LEFT JOIN VotoPergunta USING(idPergunta)
    LEFT JOIN (SELECT idPergunta, COUNT(*)
        FROM Resposta
        GROUP BY idPergunta)
        AS TabelaRespostas
        USING (idPergunta)
    LEFT JOIN Resposta USING(idPergunta)
    JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    WHERE Resposta.idPergunta IS NULL
    GROUP BY TabelaRespostas.count, Pergunta.idPergunta, Utilizador.idUtilizador
    ORDER BY Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* 4. PESQUISA FULL-TEXT DE PERGUNTAS         */
/*--------------------------------------------*/

CREATE MATERIALIZED VIEW PerguntasPesquisa AS
SELECT QueryPrincipal.*, to_tsvector('portuguese', conteudo) AS pesquisa
FROM (SELECT Pergunta.idPergunta,
             Utilizador.idUtilizador,
             Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
             Utilizador.removido,
             Pergunta.titulo,
             Pergunta.dataHora,
             Pergunta.pontuacao,
             Pergunta.respostas,
             Pergunta.ativa,
             Pergunta.titulo || ' ' ||
             COALESCE(Pergunta.descricao, '') ||
             COALESCE(string_agg(Contribuicao.descricao, ' '), '') AS conteudo
FROM Pergunta
LEFT JOIN Resposta USING(idPergunta)
LEFT JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
LEFT JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
GROUP BY idPergunta, Utilizador.idUtilizador) AS QueryPrincipal;

/*--------------------------------------------*/
/* 5. PESQUISA FULL-TEXT DE UTILIZADORES      */
/*--------------------------------------------*/

CREATE MATERIALIZED VIEW UtilizadoresPesquisa AS
SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.email,
       Utilizador.ultimaSessao,
       to_tsvector('english', Utilizador.username || ' ' ||
           Utilizador.primeiroNome || ' ' ||
           Utilizador.ultimoNome || ' ' ||
           Utilizador.email) AS pesquisa
    FROM Utilizador;

/*--------------------------------------------*/
/* 6. LISTAR INSTITUIÇÕES                     */
/*--------------------------------------------*/

CREATE VIEW VistaInstituicao AS
SELECT Instituicao.idInstituicao,
       Instituicao.nome,
       Instituicao.sigla,
       COALESCE(COUNT(DISTINCT Utilizador.idUtilizador), 0) AS numeroUtilizadores,
       COALESCE(COUNT(DISTINCT CategoriaInstituicao.idCategoria), 0) AS numeroCategorias,
       COALESCE(COUNT(DISTINCT Pergunta.idPergunta), 0) AS numeroPerguntas
    FROM Instituicao
    LEFT JOIN Utilizador USING(idInstituicao)
    LEFT JOIN CategoriaInstituicao USING(idInstituicao)
    LEFT JOIN Pergunta USING (idCategoria)
    GROUP BY Instituicao.idInstituicao
    ORDER BY Instituicao.nome;