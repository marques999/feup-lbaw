/*--------------------------------------------*/
/* 1. EDITAR UTILIZADOR                       */
/*--------------------------------------------*/
UPDATE knowUP.Utilizador
SET
	knowUP.Utilizador.primeiroNome = $novoPrimeiroNome,
	knowUP.Utilizador.ultimoNome = $novoUltimoNome,
	knowUP.Utilizador.email = $novoEmail,
	knowUP.Utilizador.localizacao = $novaLocalizacao,
	knowUP.Utilizador.codigoPais = $novoContrycode,
	knowUP.Utilizador.biografia = $novaBiografia
WHERE knowUP.Utilizador.idUtilizador = $idUtilizador;

/*--------------------------------------------*/
/* 2. EDITAR PERGUNTA                         */
/*--------------------------------------------*/
UPDATE knowUP.Pergunta
SET 
	knowUP.Pergunta.titulo = $novoTitulo,
	knowUP.Pergunta.descricao = $novaDescricao
WHERE knowUP.Pergunta.idPergunta = $idPergunta;

/*--------------------------------------------*/
/* 3. EDITAR RESPOSTA                         */
/*--------------------------------------------*/
UPDATE knowUP.Resposta
SET knowUP.Resposta.descricao = $novaDescricao
WHERE knowUP.Resposta.idResposta = $idResposta;

/*--------------------------------------------*/
/* 1. APAGAR UTILIZADOR                       */
/*--------------------------------------------*/
DELETE FROM knowUP.Utilizador
WHERE knowUP.Utilizador.idUtilizador = $idUtilizador;

/*--------------------------------------------*/
/* 2. APAGAR PERGUNTA                         */
/*--------------------------------------------*/
DELETE FROM knowUP.Pergunta
WHERE knowUP.Pergunta.idPergunta = $idPergunta;

/*--------------------------------------------*/
/* 3. APAGAR SEGUIDOR                         */
/*--------------------------------------------*/
DELETE FROM knowUP.Seguidor
WHERE knowUP.Seguidor.idSeguidor = $idUtilizador;

/*--------------------------------------------*/
/* 4. APAGAR RESPOSTA                         */
/*--------------------------------------------*/
DELETE FROM knowUP.Resposta
WHERE knowUP.Resposta.idResposta = $idResposta;

/*--------------------------------------------*/
/* 5. APAGAR COMENTÁRIO A PERGUNTA            */
/*--------------------------------------------*/
DELETE FROM knowUP.ComentarioPergunta
WHERE knowUP.ComentarioPergunta.idComentario = $idComentario;

/*--------------------------------------------*/
/* 6. APAGAR COMENTÁRIO A RESPOSTA            */
/*--------------------------------------------*/
DELETE FROM knowUP.ComentarioResposta
WHERE knowUP.ComentarioResposta.idComentario = $idComentario;