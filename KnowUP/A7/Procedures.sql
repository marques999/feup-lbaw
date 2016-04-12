SET SCHEMA 'knowup';

/*--------------------------------------------*/
/*             registarVotoPergunta           */
/*--------------------------------------------*/

-- registarVotoPergunta(idPergunta, idAutor, valor)

CREATE OR REPLACE FUNCTION registarVotoPergunta(integer, integer, integer)
RETURNS BOOLEAN AS $registarVotoPergunta$
BEGIN
	IF ($3 = 0) THEN
		RETURN FALSE;
	END IF;
	IF EXISTS(SELECT 1 FROM VotoPergunta WHERE idPergunta = $1 AND idAutor = $2) THEN
		UPDATE VotoPergunta
		SET valor = $3 WHERE (idPergunta = $1 AND idAutor = $2);
		RETURN TRUE;
	ELSE
		INSERT INTO VotoPergunta(idPergunta, idAutor, valor)
		VALUES ($1, $2, $3);
		RETURN TRUE;
	END IF;
	RETURN FALSE;
END;

$registarVotoPergunta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*             registarVotoResposta           */
/*--------------------------------------------*/

-- registarVotoResposta(idResposta, idAutor, valor)

CREATE OR REPLACE FUNCTION registarVotoResposta(integer, integer, integer)
RETURNS BOOLEAN AS $registarVotoResposta$
BEGIN
	IF ($3 = 0) THEN
		RETURN FALSE;
	END IF;
	IF EXISTS(SELECT 1 FROM VotoResposta WHERE idResposta = $1 AND idAutor = $2) THEN
		UPDATE VotoResposta
		SET valor = $3 WHERE (idResposta = $1 AND idAutor = $2);
		RETURN TRUE;
	ELSE
		INSERT INTO VotoResposta(idResposta, idAutor, valor)
		VALUES ($1, $2, $3);
		RETURN TRUE;
	END IF;
	RETURN FALSE;
END;

$registarVotoResposta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*     FUNÇÃO: calcularPontuacaoPergunta      */
/*--------------------------------------------*/

-- calcularPontuacaoPergunta(idPergunta)

CREATE OR REPLACE FUNCTION calcularPontuacaoPergunta(INTEGER)
RETURNS TABLE(votosPositivos BIGINT, votosNegativos BIGINT, pontuacao BIGINT)
AS $calcularPontuacaoPergunta$
BEGIN
	RETURN QUERY (SELECT TabelaVotos.*, TabelaVotos.votosPositivos - TabelaVotos.votosNegativos FROM
		(SELECT
		COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
		COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos
	FROM VotoPergunta WHERE idPergunta = $1) AS TabelaVotos);
END;

$calcularPontuacaoPergunta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*     FUNÇÃO: calcularPontuacaoResposta      */
/*--------------------------------------------*/

-- calcularPontuacaoResposta(idResposta)

CREATE OR REPLACE FUNCTION calcularPontuacaoResposta(INTEGER)
RETURNS TABLE(votosPositivos BIGINT, votosNegativos BIGINT, pontuacao BIGINT)
AS $calcularPontuacaoResposta$
BEGIN
	RETURN QUERY (SELECT TabelaVotos.*, TabelaVotos.votosPositivos + TabelaVotos.votosNegativos FROM
		(SELECT
		COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
		COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos
	FROM VotoResposta WHERE idResposta = $1) AS TabelaVotos);
END;

$calcularPontuacaoResposta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*     FUNÇÃO: numeroComentariosPergunta      */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION numeroComentariosPergunta(INTEGER)
RETURNS INTEGER AS $numeroComentariosPergunta$
BEGIN
	RETURN (SELECT COALESCE((SELECT COUNT(*) FROM ComentarioPergunta WHERE idPergunta = $1), 0));
END;

$numeroComentariosPergunta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION numeroComentariosResposta(INTEGER)
RETURNS INTEGER AS $numeroComentariosResposta$
BEGIN
	RETURN (SELECT COALESCE((SELECT COUNT(*) FROM ComentarioResposta WHERE idResposta = $1), 0));
END;

$numeroComentariosResposta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*           FUNÇÃO: visitarPergunta          */
/*--------------------------------------------*/

-- visitarPergunta(idPergunta, idUtilizador)

CREATE OR REPLACE FUNCTION visitarPergunta(integer, integer)
RETURNS VOID AS $visitarPergunta$
BEGIN
	UPDATE Seguidor
	SET dataAcesso = now()
	WHERE idPergunta = $1 AND idSeguidor = $2;
	UPDATE Pergunta
	SET visualizacoes = visualizacoes + 1
	WHERE idPergunta = $1;
	RETURN;
END;

$visitarPergunta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*             FUNÇÃO: lerMensagens           */
/*--------------------------------------------*/

-- lerMensagens(idConversa, idUtilizador)

CREATE OR REPLACE FUNCTION lerMensagens(integer, integer)
RETURNS VOID AS $lerMensagens$
BEGIN
	UPDATE Conversa
	SET ultimoAcesso1 = now()
	WHERE idConversa = $1 AND idUtilizador1 = $2;
	UPDATE Conversa
	SET ultimoAcesso2 = now()
	WHERE idConversa = $1 AND idUtilizador2 = $2;
	RETURN;
END;

$lerMensagens$ LANGUAGE plpgsql;