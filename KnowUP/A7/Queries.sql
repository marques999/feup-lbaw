/*--------------------------------------------*/
/* 1. EDITAR UTILIZADOR                       */
/*--------------------------------------------*/
UPDATE Utilizador
SET
	Utilizador.primeiroNome = COALESCE(:primeiroNome, Utilizador.primeiroNome),
	Utilizador.ultimoNome =  COALESCE(:novoUltimoNome, Utilizador.ultimoNome),
	Utilizador.email =  COALESCE(:novoEmail, Utilizador.email),
	Utilizador.localidade =  COALESCE(:novaLocalidade, Utilizador.localidade),
	Utilizador.codigoPais =  COALESCE(:novoCodigoPais, Utilizador.codigoPais)
WHERE Utilizador.idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* 2. EDITAR PERGUNTA                         */
/*--------------------------------------------*/
UPDATE Pergunta
SET
	Pergunta.titulo = COALESCE(:novoTitulo, Pergunta.titulo),
	Pergunta.descricao = COALESCE(:novaDescricao, Pergunta.descricao)
WHERE Pergunta.idPergunta = :idPergunta;

/*--------------------------------------------*/
/* 3. EDITAR RESPOSTA                         */
/*--------------------------------------------*/
UPDATE Contribuicao
SET Contribuicao.descricao = COALESCE(:novaDescricao, Contribuicao.descricao)
WHERE Contribuicao.idContribuicao = :idResposta;

--------------------------------------------------

/*--------------------------------------------*/
/* 1. SEGUIR PERGUNTA                         */
/*--------------------------------------------*/
INSERT INTO Seguidor(idPergunta, idAutor)
VALUES(:idPergunta, :idAutor);

/*--------------------------------------------*/
/* 2. DEIXAR DE SEGUIR PERGUNTA               */
/*--------------------------------------------*/
DELETE FROM Seguidor
WHERE Seguidor.idSeguidor = :idSeguidor
AND Seguidor.idPergunta = :idPergunta;

/*--------------------------------------------*/
/* 3. FECHAR PERGUNTA                         */
/*--------------------------------------------*/
UPDATE Pergunta
SET Pergunta.ativa = FALSE
WHERE Pergunta.idPergunta = :idPergunta;

/*--------------------------------------------*/
/* 4. ESCOLHER MELHOR RESPOSTA                */
/*--------------------------------------------*/
UPDATE Resposta
SET Resposta.melhorResposta = TRUE
WHERE Resposta.idResposta = :idResposta;

/*--------------------------------------------*/
/* 5. CLASSIFICAR PERGUNTA                    */
/*--------------------------------------------*/
SELECT registarVotoPergunta(:idPergunta, :valor);

/*--------------------------------------------*/
/* 6. CLASSIFICAR RESPOSTA                    */
/*--------------------------------------------*/
SELECT registarVotoResposta(:idResposta, :valor);

--------------------------------------------------

/*--------------------------------------------*/
/* 1. INSERIR UTILIZADOR                      */
/*--------------------------------------------*/
INSERT INTO Utilizador(username, password, email, primeiroNome, ultimoNome)
VALUES(:username, :password, :email, :primeiroNome, :ultimoNome);

UPDATE Utilizador
SET
	Utilizador.idInstituicao = COALESCE(:idInstituicao, Utilizador.idInstituicao),
	Utilizador.localidade = COALESCE(:localidade, Utilizador.localidade),
	Utilizador.codigoPais = COALESCE(:codigoPais, Utilizador.codigoPais)
WHERE Utilizador.idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* 1. INSERIR PERGUNTA                        */
/*--------------------------------------------*/
INSERT INTO Pergunta(idCategoria, idAutor, titulo, descricao)
VALUES(:idCategoria, :idAutor, :titulo, :descricao);

/*--------------------------------------------*/
/* 2. INSERIR RESPOSTA                        */
/*--------------------------------------------*/
INSERT INTO Contribuicao(idAutor, descricao)
VALUES(:idAutor, :descricao);

SELECT currval(pg_get_serial_sequence('contribuicao', 'idContribuicao'))
AS novaResposta;

INSERT INTO Resposta(idResposta, idPergunta) 
VALUES(novaResposta, :idPergunta);

/*--------------------------------------------*/
/* 3. INSERIR COMENTÁRIO NUMA PERGUNTA        */
/*--------------------------------------------*/
INSERT INTO Contribuicao(idAutor, descricao)
VALUES(:idAutor, :descricao);

SELECT currval(pg_get_serial_sequence('contribuicao', 'idContribuicao'))
AS novoComentario;

INSERT INTO ComentarioPergunta(idComentario, idPergunta)
VALUES(novoComentario, :idPergunta);

/*--------------------------------------------*/
/* 4. INSERIR COMENTÁRIO NUMA RESPOSTA        */
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
SET Utilizador.removido = TRUE
WHERE Utilizador.idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* 2. APAGAR PERGUNTA                         */
/*--------------------------------------------*/
DELETE FROM Pergunta
WHERE Pergunta.idPergunta = :idPergunta;

/*--------------------------------------------*/
/* 3. APAGAR SEGUIDOR                         */
/*--------------------------------------------*/
DELETE FROM Seguidor
WHERE Seguidor.idSeguidor = :idUtilizador;

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
WHERE Mensagem.idMensagem = :idMensagem;

--------------------------------------------------

/*--------------------------------------------*/
/* 1. DENUNCIAR UTILIZADOR                    */
/*--------------------------------------------*/
INSERT INTO Report(idModerador, idUtilizador, descricao)
VALUES(:idModerador, :idUtilizador, :descricao);

/*--------------------------------------------*/
/* 2. BANIR UTILIZADOR                        */
/*--------------------------------------------*/
UPDATE Utilizador
SET Utilizador.activo = FALSE
WHERE Utilizador.idUtilizador = :idUtilizador;