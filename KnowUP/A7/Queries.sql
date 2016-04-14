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