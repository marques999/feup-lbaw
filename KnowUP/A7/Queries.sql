SET SCHEMA 'knowup';

/*--------------------------------------------*/
/* 1. EDITAR INFORMAÇÕES DO UTILIZADOR        */
/*--------------------------------------------*/
UPDATE Utilizador
SET
    primeiroNome = COALESCE(:primeiroNome, primeiroNome),
    ultimoNome =  COALESCE(:novoUltimoNome, ultimoNome),
    email =  COALESCE(:novoEmail, email),
    localidade =  COALESCE(:novaLocalidade, localidade),
    codigoPais =  COALESCE(:novoCodigoPais, codigoPais)
WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* 2. EDITAR CONTEÚDO DA PERGUNTA             */
/*--------------------------------------------*/
UPDATE Pergunta
SET
    titulo = COALESCE(:novoTitulo, titulo),
    descricao = COALESCE(:novaDescricao, descricao)
WHERE idPergunta = :idPergunta;

/*--------------------------------------------*/
/* 3. EDITAR CONTEÚDO DA RESPOSTA             */
/*--------------------------------------------*/
UPDATE Contribuicao
SET descricao = COALESCE(:novaDescricao, descricao)
WHERE idContribuicao = :idResposta;

/*--------------------------------------------*/
/* 4. ESCOLHER MELHOR RESPOSTA                */
/*--------------------------------------------*/
UPDATE Resposta
SET melhorResposta = TRUE
WHERE idResposta = :idResposta;

/*--------------------------------------------*/
/* 5. FECHAR PERGUNTA                         */
/*--------------------------------------------*/
UPDATE Pergunta
SET ativa = FALSE
WHERE idPergunta = :idPergunta;

/*--------------------------------------------*/
/* 6. SEGUIR PERGUNTA                         */
/*--------------------------------------------*/
INSERT INTO Seguidor(idPergunta, idAutor)
VALUES(:idPergunta, :idAutor);

/*--------------------------------------------*/
/* 7. UNFOLLOW PERGUNTA                       */
/*--------------------------------------------*/
DELETE FROM Seguidor
WHERE idSeguidor = :idSeguidor
AND idPergunta = :idPergunta;

/*--------------------------------------------*/
/* 8. CLASSIFICAR PERGUNTA                    */
/*--------------------------------------------*/
SELECT registarVotoPergunta(:idPergunta, :valor);

/*--------------------------------------------*/
/* 9. CLASSIFICAR RESPOSTA                    */
/*--------------------------------------------*/
SELECT registarVotoResposta(:idResposta, :valor);

/*--------------------------------------------*/
/* 10. DENUNCIAR UTILIZADOR                   */
/*--------------------------------------------*/
INSERT INTO Report(idModerador, idUtilizador, descricao)
VALUES(:idModerador, :idUtilizador, :descricao);

/*--------------------------------------------*/
/* 11. BANIR UTILIZADOR                       */
/*--------------------------------------------*/
UPDATE Utilizador
SET activo = FALSE
WHERE idUtilizador = :idUtilizador;

--------------------------------------------------

/*--------------------------------------------*/
/* 1. INSERIR UTILIZADOR                      */
/*--------------------------------------------*/
INSERT INTO Utilizador(username, password, email, primeiroNome, ultimoNome)
VALUES(:username, :password, :email, :primeiroNome, :ultimoNome);

UPDATE Utilizador
SET
    idInstituicao = COALESCE(:idInstituicao, idInstituicao),
    localidade = COALESCE(:localidade, localidade),
    codigoPais = COALESCE(:codigoPais, codigoPais)
WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* 2. INSERIR PERGUNTA                        */
/*--------------------------------------------*/
INSERT INTO Pergunta(idCategoria, idAutor, titulo, descricao)
VALUES(:idCategoria, :idAutor, :titulo, :descricao);

/*--------------------------------------------*/
/* 3. INSERIR RESPOSTA                        */
/*--------------------------------------------*/
INSERT INTO Contribuicao(idAutor, descricao)
VALUES(:idAutor, :descricao);

SELECT currval(pg_get_serial_sequence('contribuicao', 'idContribuicao'))
AS novaResposta;

INSERT INTO Resposta(idResposta, idPergunta)
VALUES(novaResposta, :idPergunta);

/*--------------------------------------------*/
/* 4. INSERIR COMENTÁRIO NUMA PERGUNTA        */
/*--------------------------------------------*/
INSERT INTO Contribuicao(idAutor, descricao)
VALUES(:idAutor, :descricao);

SELECT currval(pg_get_serial_sequence('contribuicao', 'idContribuicao'))
AS novoComentario;

INSERT INTO ComentarioPergunta(idComentario, idPergunta)
VALUES(novoComentario, :idPergunta);

/*--------------------------------------------*/
/* 5. INSERIR COMENTÁRIO NUMA RESPOSTA        */
/*--------------------------------------------*/
INSERT INTO Contribuicao(idAutor, descricao)
VALUES(:idAutor, :descricao);

SELECT currval(pg_get_serial_sequence('contribuicao', 'idContribuicao'))
AS novoComentario;

INSERT INTO ComentarioResposta(idComentario, idResposta)
VALUES(novoComentario, :idResposta);

/*--------------------------------------------*/
/* 5. CRIAR CONVERSA                          */
/*--------------------------------------------*/

INSERT INTO Conversa(idUtilizador1, idUtilizador2, titulo)
VALUES(:idRemetente, :idDestinatario, :titulo);

/*--------------------------------------------*/
/* 5. ENVIAR MENSAGEM PRIVADA                 */
/*--------------------------------------------*/

INSERT INTO Mensagem(idConversa, idAutor, descricao)
VALUES(:idConversa, :idAutor, :descricao);

--------------------------------------------------

/*--------------------------------------------*/
/* 1. APAGAR UTILIZADOR                       */
/*--------------------------------------------*/
UPDATE Utilizador
SET removido = TRUE
WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* 2. APAGAR PERGUNTA                         */
/*--------------------------------------------*/
DELETE FROM Pergunta
WHERE idPergunta = :idPergunta;

/*--------------------------------------------*/
/* 3. APAGAR SEGUIDOR                         */
/*--------------------------------------------*/
DELETE FROM Seguidor
WHERE idSeguidor = :idUtilizador;

/*--------------------------------------------*/
/* 4. APAGAR RESPOSTA                         */
/*--------------------------------------------*/
SELECT apagarResposta(:idResposta);

/*--------------------------------------------*/
/* 5. APAGAR COMENTÁRIO A PERGUNTA            */
/*--------------------------------------------*/
SELECT apagarComentarioPergunta(:idComentario);

/*--------------------------------------------*/
/* 6. APAGAR COMENTÁRIO A RESPOSTA            */
/*--------------------------------------------*/
SELECT apagarComentarioResposta(:idComentario);

/*--------------------------------------------*/
/* 7. APAGAR MENSAGEM                         */
/*--------------------------------------------*/
DELETE FROM Mensagem
WHERE idMensagem = :idMensagem;

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
    to_char(Pergunta.dataHora, 'Day DD/MM/YYYY HH:MM') as dataHora
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
/* 1. LISTAS DE RESPOSTAS A UMA PERGUNTA      */
/*--------------------------------------------*/

SELECT Resposta.idResposta,
    Utilizador.idUtilizador,
    Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
    Utilizador.username,
    Instituicao.sigla,
    Contribuicao.descricao,
    COALESCE(TabelaComentarios.count, 0) AS numeroComentarios,
    COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
    COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
    COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
    to_char(Contribuicao.dataHora, 'Day DD/MM/YYYY HH:MM') as dataHora,
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
    COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
    COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
    COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
    to_char(Pergunta.dataHora, 'Day DD/MM/YYYY HH:MM') as dataHora
    --numeroSeguidores(Pergunta.idPergunta) AS numeroSeguidores
    FROM Pergunta
    JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    NATURAL LEFT JOIN (SELECT idPergunta,
        SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
        SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
        FROM VotoPergunta
        GROUP BY idPergunta)
        AS TabelaVotos
    WHERE Pergunta.idCategoria = :idCategoria
    ORDER BY Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* 1. LISTA DE PERGUNTAS POR INSTITUICAO      */
/*--------------------------------------------*/

SELECT Pergunta.idPergunta,
    Utilizador.idUtilizador,
    Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome,
    Utilizador.username,
    Pergunta.titulo,
    Pergunta.descricao,
    COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
    COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
    COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
    to_char(Pergunta.dataHora, 'Day DD/MM/YYYY HH:MM') as dataHora
  --  numeroSeguidores(Pergunta.idPergunta) AS numeroSeguidores
    FROM CategoriaInstituicao
    JOIN Pergunta USING(idCategoria)
    JOIN Utilizador ON Utilizador.idUtilizador = Pergunta.idAutor
    NATURAL LEFT JOIN (SELECT idPergunta,
        SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
        SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
        FROM VotoPergunta
        GROUP BY idPergunta)
        AS TabelaVotos
    WHERE CategoriaInstituicao.idInstituicao = 5
    ORDER BY Pergunta.dataHora DESC;

/*--------------------------------------------*/
/* 1. LISTA DE PERGUNTAS POR AUTOR            */
/*--------------------------------------------*/

SELECT Pergunta.idPergunta,
    Pergunta.titulo,
    Pergunta.descricao,    
    COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
    COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
    COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
    to_char(Pergunta.dataHora, 'Day DD/MM/YYYY HH:MM') as dataHora,
    Pergunta.ativa
    FROM Utilizador
    JOIN Pergunta ON Utilizador.idUtilizador = Pergunta.idAutor
    NATURAL LEFT JOIN (SELECT idPergunta,
        SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
        SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
        FROM VotoPergunta
        GROUP BY idPergunta)
        AS TabelaVotos
    WHERE Utilizador.idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* 2. LISTA DE RESPOSTAS POR AUTOR            */
/*--------------------------------------------*/

SELECT Resposta.idResposta,
    Resposta.idPergunta,
    Contribuicao.descricao,
    Resposta.melhorResposta,
    COALESCE(TabelaVotos.votosPositivos, 0) AS votosPositivos,
    COALESCE(TabelaVotos.votosNegativos, 0) AS votosNegativos,
    COALESCE(votosPositivos - votosNegativos, 0) AS pontuacao,
    to_char(Contribuicao.dataHora, 'Day DD/MM/YYYY HH:MM') as dataHora
    FROM Utilizador
    JOIN Contribuicao ON Contribuicao.idAutor = Utilizador.idUtilizador
    JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
    LEFT JOIN (SELECT idResposta,
        SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END) AS votosPositivos,
        SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END) AS votosNegativos
        FROM VotoResposta
        GROUP BY idResposta)
        AS TabelaVotos
        USING(idResposta)
    WHERE Utilizador.idUtilizador = 2;

/*--------------------------------------------*/
/* 3. LISTA DE COMENTÁRIOS A UMA PERGUNTA     */
/*--------------------------------------------*/

SELECT ComentarioPergunta.idComentario,
    Utilizador.idUtilizador,
    Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
    Contribuicao.descricao,
    to_char(Contribuicao.dataHora, 'Day DD/MM/YYYY HH:MM') as dataHora
    FROM ComentarioPergunta
    JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioPergunta.idComentario
    JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
    WHERE ComentarioPergunta.idPergunta = :idPergunta;

/*--------------------------------------------*/
/* 4. LISTA DE COMENTÁRIOS A UMA RESPOSTA     */
/*--------------------------------------------*/

SELECT ComentarioResposta.idComentario,
    Utilizador.idUtilizador,
    Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
    Contribuicao.descricao,
    to_char(Contribuicao.dataHora, 'Day DD/MM/YYYY HH:MM') as dataHora
    FROM ComentarioResposta
    JOIN Contribuicao ON Contribuicao.idContribuicao = ComentarioResposta.idComentario
    JOIN Utilizador ON Utilizador.idUtilizador = Contribuicao.idAutor
    WHERE ComentarioResposta.idResposta = :idResposta;