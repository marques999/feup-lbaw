SET SCHEMA 'knowup';

DROP VIEW IF EXISTS PerguntasSemResposta;
DROP VIEW IF EXISTS PerguntasMaisRecentes;
DROP VIEW IF EXISTS PerguntasMelhorClassificadas;
DROP VIEW IF EXISTS UtilizadoresBanidos;
DROP VIEW IF EXISTS UtilizadoresActivos;
DROP VIEW IF EXISTS UtilizadoresRemovidos;
DROP VIEW IF EXISTS VistaInstituicao;

/*--------------------------------------------*/
/* LISTA DAS PERGUNTAS MAIS RECENTES          */
/*--------------------------------------------*/

CREATE VIEW PerguntasMaisRecentes AS
SELECT Pergunta.idPergunta,
    Utilizador.idUtilizador,
    Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
    Pergunta.titulo,
    Pergunta.descricao,
    COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
    COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
    COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
    to_char(Pergunta.dataHora, 'Day DD/MM/YYYY HH:MM') as dataHora,
    Pergunta.ativa
FROM Pergunta
JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
LEFT JOIN (SELECT idPergunta,
    SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
    SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
    FROM VotoPergunta
    GROUP BY idPergunta)
    AS TabelaVotos
    USING(idPergunta)
ORDER BY dataHora DESC;

/*--------------------------------------------*/
/* LISTA DAS PERGUNTAS MELHOR CLASSIFICADAS   */
/*--------------------------------------------*/

CREATE VIEW PerguntasMelhorClassificadas AS
SELECT Pergunta.idPergunta,
    Utilizador.idUtilizador,
    Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
    Pergunta.titulo,
    Pergunta.descricao,
    COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
    COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
    COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
    to_char(Pergunta.dataHora, 'Day DD/MM/YYYY HH:MM') as dataHora,
    Pergunta.ativa
FROM Pergunta
JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
LEFT JOIN (SELECT idPergunta,
    SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
    SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
    FROM VotoPergunta
    GROUP BY idPergunta)
    AS TabelaVotos
    USING(idPergunta)
ORDER BY pontuacao DESC;

/*--------------------------------------------*/
/* LISTA DAS PERGUNTAS SEM RESPOSTA           */
/*--------------------------------------------*/

CREATE VIEW PerguntasSemResposta AS
SELECT Pergunta.idPergunta,
    Utilizador.idUtilizador,
    Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
    Pergunta.titulo,
    Pergunta.descricao,
    COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
    COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
    COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
    to_char(Pergunta.dataHora, 'Day DD/MM/YYYY HH:MM') as dataHora,
    Pergunta.ativa
FROM Pergunta
LEFT JOIN (SELECT idPergunta,
    SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
    SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
    FROM VotoPergunta
    GROUP BY idPergunta)
    AS TabelaVotos
    USING(idPergunta)
LEFT JOIN Resposta USING(idPergunta)
JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
WHERE Resposta.idPergunta IS NULL
ORDER BY dataHora DESC;

/*--------------------------------------------*/
/* LISTA DE INSTITUIÇÕES                      */
/*--------------------------------------------*/

CREATE VIEW VistaInstituicao AS
SELECT Instituicao.idInstituicao,
       Instituicao.nome,
       Instituicao.sigla,
       Instituicao.morada,
       Instituicao.contacto,
       Instituicao.website,
       COALESCE(TabelaUtilizadores.count, 0) AS numeroUtilizadores,
       COALESCE(TabelaCategorias.count, 0) AS numeroCategorias,
       COALESCE(TabelaPerguntas.count, 0) AS numeroPerguntas
FROM Instituicao
LEFT JOIN (SELECT idInstituicao, COUNT(*)
    FROM Utilizador
    GROUP BY idInstituicao)
    AS TabelaUtilizadores
    USING(idInstituicao)
LEFT JOIN (SELECT idInstituicao, COUNT(*)
    FROM CategoriaInstituicao
    GROUP BY idInstituicao)
    AS TabelaCategorias
    USING(idInstituicao)
LEFT JOIN (SELECT idInstituicao, COUNT(*)
    FROM Pergunta
    NATURAL JOIN CategoriaInstituicao
    GROUP BY idInstituicao)
    AS TabelaPerguntas
    USING(idInstituicao);

/*--------------------------------------------*/
/* LISTA DE UTILIZADORES ACTIVOS              */
/*--------------------------------------------*/

CREATE VIEW UtilizadoresActivos
SELECT Utilizador.*, 
       Instituicao.sigla,
       Instituicao.website,
       COALESCE(TabelaPerguntas.count, 0) AS numeroPerguntas,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas
FROM Utilizador
NATURAL LEFT JOIN Instituicao
LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Pergunta
    GROUP BY idAutor)
    AS TabelaPerguntas
    USING(idUtilizador)
LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Resposta 
    JOIN Contribuicao
    ON Contribuicao.idContribuicao = Resposta.idResposta
    GROUP BY idAutor)
    AS TabelaRespostas
    USING(idUtilizador)
WHERE Utilizador.ativo = TRUE AND Utilizador.removido = FALSE;

/*--------------------------------------------*/
/* LISTA DE UTILIZADORES BANIDOS              */
/*--------------------------------------------*/

CREATE VIEW UtilizadoresBanidos
SELECT Utilizador.*, 
       Instituicao.sigla,
       Instituicao.website,
       COALESCE(TabelaPerguntas.count, 0) AS numeroPerguntas,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas
FROM Utilizador
NATURAL LEFT JOIN Instituicao
LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Pergunta
    GROUP BY idAutor)
    AS TabelaPerguntas
    USING(idUtilizador)
LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Resposta 
    JOIN Contribuicao
    ON Contribuicao.idContribuicao = Resposta.idResposta
    GROUP BY idAutor)
    AS TabelaRespostas
    USING(idUtilizador)
WHERE Utilizador.ativo = FALSE;

/*--------------------------------------------*/
/* LISTA DE UTILIZADORES REMOVIDOS            */
/*--------------------------------------------*/

CREATE VIEW UtilizadoresRemovidos
SELECT Utilizador.*, 
       Instituicao.sigla,
       Instituicao.website,
       COALESCE(TabelaPerguntas.count, 0) AS numeroPerguntas,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas
FROM Utilizador
NATURAL LEFT JOIN Instituicao
LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Pergunta
    GROUP BY idAutor)
    AS TabelaPerguntas
    USING(idUtilizador)
LEFT JOIN (SELECT idAutor AS idUtilizador, COUNT(*)
    FROM Resposta 
    JOIN Contribuicao
    ON Contribuicao.idContribuicao = Resposta.idResposta
    GROUP BY idAutor)
    AS TabelaRespostas
    USING(idUtilizador)
WHERE Utilizador.ativo = TRUE AND Utilizador.removido = TRUE;