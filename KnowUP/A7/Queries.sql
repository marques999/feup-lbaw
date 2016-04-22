SET SCHEMA 'knowup';

/*--------------------------------------------*/
/* 1. LISTA DE CATEGORIAS DE UMA INSTITUIÇÂO  */
/*--------------------------------------------*/
SELECT Categoria.idCategoria, Categoria.nome
    FROM Instituicao
    JOIN CategoriaInstituicao USING(idInstituicao)
    JOIN Categoria USING(idCategoria)
    WHERE idInstituicao = :idInstituicao
    ORDER BY Categoria.nome ASC;

/*--------------------------------------------*/
/* 2. LISTA DE INSTITUIÇÕES DE UMA CATEGORIA  */
/*--------------------------------------------*/
SELECT Instituicao.idInstituicao, Instituicao.sigla
    FROM Categoria
    JOIN CategoriaInstituicao USING(idCategoria)
    JOIN Instituicao USING(idInstituicao)
    WHERE Categoria.idCategoria = :idCategoria
    ORDER BY Instituicao.sigla ASC;

/*--------------------------------------------*/
/* 2. VER PERGUNTA                            */
/*--------------------------------------------*/
SELECT Pergunta.idPergunta,
    Utilizador.idUtilizador,
    Utilizador.username,
    Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
    Utilizador.removido,
    Instituicao.sigla,
    Pergunta.titulo,
    Pergunta.descricao,
    Pergunta.ativa,
    COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
    COALESCE(TabelaComentarios.count, 0) AS numeroComentarios,
    COALESCE(TabelaSeguidores.count, 0) AS numeroSeguidores,
    COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
    COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
    COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
    EXTRACT(EPOCH FROM Pergunta.dataHora) as dataHora
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
        FROM Resposta
        WHERE idPergunta = :idPergunta
        GROUP BY idPergunta)
        AS TabelaRespostas
        USING (idPergunta)
    LEFT JOIN (SELECT idPergunta, COUNT(*)
        FROM ComentarioPergunta
        WHERE idPergunta = :idPergunta
        GROUP BY idPergunta)
        AS TabelaComentarios
        USING (idPergunta)
    LEFT JOIN (SELECT idPergunta, COUNT(*)
        FROM Seguidor
        WHERE idPergunta = :idPergunta
        GROUP BY idPergunta)
        AS TabelaSeguidores
        USING (idPergunta)
    WHERE Pergunta.idPergunta = :idPergunta;

/*--------------------------------------------*/
/* 1. LISTA DE RESPOSTAS A UMA PERGUNTA       */
/*--------------------------------------------*/

SELECT Resposta.idResposta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.username,
       Utilizador.removido,
       Instituicao.sigla,
       Contribuicao.descricao,
       COALESCE(TabelaComentarios.count, 0) AS numeroComentarios,
       COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
       COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
       COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
       EXTRACT(EPOCH FROM Contribuicao.dataHora) as dataHora
       Resposta.melhorResposta
    FROM Resposta
    JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
    JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
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
    ORDER BY Contribuicao.dataHora DESC;

/*--------------------------------------------*/
/* 1. LISTA DE PERGUNTAS POR CATEGORIA        */
/*--------------------------------------------*/

SELECT Pergunta.idPergunta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.username,
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
    WHERE Pergunta.idCategoria = :idCategoria
    GROUP BY Pergunta.idPergunta, TabelaRespostas.count, Utilizador.idUtilizador
    ORDER BY Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* 1. LISTA DE PERGUNTAS POR INSTITUICAO      */
/*--------------------------------------------*/

SELECT Pergunta.idPergunta,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.username,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.ativa,
       COALESCE(TabelaRespostas.count, 0) AS numeroRespostas,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao,
       EXTRACT(EPOCH FROM Pergunta.dataHora) as dataHora
    FROM CategoriaInstituicao
    JOIN Pergunta USING(idCategoria)
    JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    LEFT JOIN VotoPergunta USING(idPergunta)
    LEFT JOIN (SELECT idPergunta, COUNT(*)
        FROM Resposta
        GROUP BY idPergunta)
        AS TabelaRespostas
        USING (idPergunta)
    WHERE CategoriaInstituicao.idInstituicao = 12
    GROUP BY Pergunta.idPergunta, TabelaRespostas.count, Utilizador.idUtilizador
    ORDER BY Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* 1. LISTA DE PERGUNTAS POR AUTOR            */ -- CHECK
/*--------------------------------------------*/

SELECT Pergunta.idPergunta,
       Pergunta.titulo,
       Pergunta.descricao,
       Pergunta.ativa,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao,
       EXTRACT(EPOCH FROM Pergunta.dataHora) as dataHora
    FROM Utilizador
    JOIN Pergunta ON Utilizador.idUtilizador = Pergunta.idAutor
    LEFT JOIN VotoPergunta USING(idPergunta)
    WHERE Utilizador.idUtilizador = :idUtilizador
    GROUP BY Pergunta.idPergunta;

/*--------------------------------------------*/
/* 2. LISTA DE RESPOSTAS POR AUTOR            */
/*--------------------------------------------*/

SELECT Resposta.idResposta,
       Pergunta.idPergunta,
       Pergunta.titulo,
       Contribuicao.descricao,
       Resposta.melhorResposta,
       Pergunta.ativa,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao,
       EXTRACT(EPOCH FROM Contribuicao.dataHora) as dataHora
    FROM Contribuicao
    JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
    JOIN Pergunta ON Pergunta.idPergunta = Resposta.idPergunta
    JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
    LEFT JOIN VotoResposta USING(idResposta)
    WHERE Contribuicao.idAutor = :idUtilizador
    GROUP BY Contribuicao.idContribuicao, Pergunta.idPergunta, Resposta.idResposta
    ORDER BY Resposta.idResposta DESC;

/*--------------------------------------------*/
/* 2. PESQUISAR PERGUNTAS                     */
/*--------------------------------------------*/

SELECT QueryPrincipal.idPergunta,
       QueryPrincipal.idUtilizador,
       QueryPrincipal.nomeUtilizador,
       QueryPrincipal.titulo,
       QueryPrincipal.dataHora,
       QueryPrincipal.ativa,
       ts_headline('portuguese', QueryPrincipal.conteudo, query) AS descricao,
       QueryPrincipal.rank
    FROM (SELECT PerguntasPesquisa.*, query, ts_rank_cd(pesquisa, query) AS rank
          FROM PerguntasPesquisa, plainto_tsquery('portuguese', :stringPesquisa) AS query
          WHERE query @@ pesquisa
          ORDER BY rank DESC) AS QueryPrincipal;

/*--------------------------------------------*/
/* 3. PESQUISAR UTILIZADORES                  */
/*--------------------------------------------*/

SELECT UtilizadoresPesquisa.idUtilizador,
       UtilizadoresPesquisa.username,
       UtilizadoresPesquisa.nomeUtilizador,
       UtilizadoresPesquisa.email,
       ts_rank_cd(UtilizadoresPesquisa.pesquisa, query) AS rank
    FROM UtilizadoresPesquisa, plainto_tsquery('english', :stringPesquisa) AS query
    WHERE query @@ pesquisa
    ORDER BY rank DESC;

/*--------------------------------------------*/
/* 3. LISTA DE COMENTÁRIOS A UMA PERGUNTA     */ -- CHECK
/*--------------------------------------------*/

SELECT ComentarioPergunta.idComentario,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Contribuicao.descricao,
       EXTRACT(EPOCH FROM Contribuicao.dataHora) as dataHora
    FROM ComentarioPergunta
    JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
    JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
    WHERE ComentarioPergunta.idPergunta = :idPergunta;

/*--------------------------------------------*/
/* 4. LISTA DE COMENTÁRIOS A UMA RESPOSTA     */ -- CHECK
/*--------------------------------------------*/

SELECT ComentarioResposta.idComentario,
       Utilizador.idUtilizador,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Contribuicao.descricao,
       EXTRACT(EPOCH FROM Contribuicao.dataHora) as dataHora
    FROM ComentarioResposta
    JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
    JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
    WHERE ComentarioResposta.idResposta = :idResposta;

/*--------------------------------------------*/
/* 5. LISTA DE CATEGORIAS RELACIONADAS        */ -- CHECK
/*--------------------------------------------*/

SELECT Instituicao.idInstituicao,
       Instituicao.sigla,
       Categorias.idCategoria,
       Categorias.nome
    FROM Categoria
    JOIN CategoriaInstituicao CI1 ON CI1.idCategoria = Categoria.idCategoria
    JOIN CategoriaInstituicao CI2 ON CI2.idInstituicao = CI1.idInstituicao
    JOIN Categoria Categorias ON Categorias.idCategoria = CI2.idCategoria
    JOIN Instituicao ON Instituicao.idInstituicao = CI2.idInstituicao
    WHERE Categoria.idCategoria = :idCategoria
    GROUP BY Categorias.idCategoria, Instituicao.idInstituicao
    ORDER BY Instituicao.idInstituicao;

/*--------------------------------------------*/
/* LISTA DE UTILIZADORES ACTIVOS              */ -- CHECK
/*--------------------------------------------*/

SELECT Utilizador.*,
       Instituicao.sigla,
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
    WHERE Utilizador.ativo AND NOT Utilizador.removido
    ORDER BY Utilizador.idUtilizador;

/*--------------------------------------------*/
/* LISTA DE UTILIZADORES BANIDOS              */ -- CHECK
/*--------------------------------------------*/

SELECT Utilizador.*,
       Instituicao.sigla,
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
    WHERE NOT Utilizador.ativo
    ORDER BY Utilizador.idUtilizador;

/*--------------------------------------------*/
/* LISTA DE UTILIZADORES REMOVIDOS            */ -- CHECK
/*--------------------------------------------*/

SELECT Utilizador.*,
       Instituicao.sigla,
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
    WHERE Utilizador.ativo AND Utilizador.removido
    ORDER BY Utilizador.idUtilizador;