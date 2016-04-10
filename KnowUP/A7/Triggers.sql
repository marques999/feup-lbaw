SET SCHEMA 'knowup';

/*--------------------------------------------*/
/*              classificarPergunta           */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION classificarPergunta() RETURNS trigger AS $classificarPergunta$
DECLARE
	AutorPergunta integer;
	AutorVoto integer;
BEGIN
	AutorVoto = NEW.idAutor;
	SELECT Pergunta.idAutor INTO AutorPergunta
	FROM Pergunta WHERE NEW.idPergunta = Pergunta.idPergunta;
	IF (AutorVoto == AutorPergunta) THEN
	RETURN NULL;
	END IF;
	RETURN NEW;
END;

$classificarPergunta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_classificarPergunta
	BEFORE INSERT ON VotoPergunta
	FOR EACH ROW
	EXECUTE PROCEDURE classificarPergunta();

/*--------------------------------------------*/
/*              classificarResposta           */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION classificarResposta() RETURNS trigger AS $classificarResposta$
DECLARE
	AutorResposta integer;
	AutorVoto integer;
BEGIN
	AutorVoto = NEW.idAutor;
	SELECT Contribuicao.idAutor INTO AutorResposta
	FROM Resposta
	JOIN Contribuicao WHERE Contribuicao.idContribuicao = Resposta.idResposta;
	IF (AutorVoto == AutorResposta) THEN
	RETURN NULL;
	END IF;
	RETURN NEW;
END;

$classificarResposta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_classificarResposta
	BEFORE INSERT ON VotoResposta
	FOR EACH ROW
	EXECUTE PROCEDURE classificarResposta();

/*--------------------------------------------*/
/*               responderPergunta            */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION responderPergunta() RETURNS trigger AS $responderPergunta$
DECLARE
	AutorPergunta integer;
	AutorResposta integer;
	EstadoPergunta boolean;
BEGIN
	EstadoPergunta = Pergunta.ativa;
	IF (NOT EstadoPergunta) THEN
	RETURN NULL;
	END IF;
	SELECT Pergunta.idAutor INTO AutorPergunta
	FROM Pergunta WHERE NEW.idPergunta = Pergunta.idPergunta;
	SELECT Contribuicao.idAutor INTO AutorResposta
	FROM Contribuicao WHERE NEW.idContribuicao = Contribuicao.idContribuicao;
	IF (AutorResposta == AutorPergunta) THEN
	RETURN NULL;
	END IF;
	RETURN NEW;
END;

$responderPergunta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_responderPergunta
	BEFORE INSERT ON Resposta
	FOR EACH ROW
	EXECUTE PROCEDURE responderPergunta();

/*--------------------------------------------*/
/*                melhorResposta              */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION knowUP.melhorResposta() RETURNS trigger AS $melhorResposta$
BEGIN
	IF EXISTS (SELECT * FROM knowUP.Pergunta WHERE knowUP.Pergunta.melhorResposta) THEN
		RETURN NULL;
	END IF;
	RETURN NEW;
END;

$melhorResposta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_melhorResposta
	BEFORE INSERT OR UPDATE ON Resposta
	FOR EACH ROW
	WHEN (NEW.melhorResposta)
	EXECUTE PROCEDURE melhorResposta();

/*--------------------------------------------*/
/*             registarVotoPergunta           */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION registarVotoPergunta(integer, integer, integer)
RETURNS void AS $registarVotoPergunta$
BEGIN
	IF EXISTS(SELECT 1 FROM knowUP.VotoPergunta WHERE idPergunta = $1 AND idAutor = $2) THEN
		UPDATE knowUP.VotoPergunta SET valor = $3 WHERE idPergunta = $1 AND idAutor = $2);
		RETURN;
	ELSE
		INSERT INTO knowUP.VotoPergunta VALUES ($1, $2, $3);
		RETURN;
	END IF;
END;

$registarVotoPergunta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*             registarVotoResposta           */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION registarVotoResposta(integer, integer, integer)
RETURNS void AS $registarVotoResposta$
BEGIN
	IF EXISTS(SELECT 1 FROM knowUP.VotoResposta WHERE idResposta = $1 AND idAutor = $2) THEN
		UPDATE knowUP.VotoResposta SET valor = $3 WHERE idResposta = $1 AND idAutor = $2);
		RETURN;
	ELSE
		NSERT INTO knowUP.VotoResposta VALUES ($1, $2, $3);
		RETURN;
	END IF;
END;

$registarVotoResposta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*       verificarOverlapAdministrador        */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION knowUP.verificarOverlapAdministrador()
RETURNS trigger AS $verificarOverlapAdministrador$
BEGIN
	IF EXISTS (SELECT 1 FROM knowUP.Moderador WHERE Moderador.idModerador = NEW.idAdministrador)
	RETURN NULL;
	END IF;
	RETURN NEW;
END;

$verificarOverlapAdministrador$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_verificarOverlapAdministrador
	BEFORE INSERT OR UPDATE ON Administrador
	FOR EACH ROW
	EXECUTE PROCEDURE verificarOverlapAdministrador();

/*--------------------------------------------*/
/*          verificarOverlapModerador         */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION knowUP.verificarOverlapModerador()
RETURNS trigger AS $verificarOverlapModerador$
BEGIN
	IF EXISTS (SELECT 1 FROM knowUP.Administrador WHERE Administrador.idAdministrador = NEW.idModerador)
	RETURN NULL;
	END IF;
	RETURN NEW;
END;

$verificarOverlapModerador$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_verificarOverlapModerador
	BEFORE INSERT OF UPDATE ON Moderador
	FOR EACH ROW
	EXECUTE PROCEDURE verificarOverlapModerador();

/*--------------------------------------------*/
/*          calcularPontuacaoPergunta         */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION calcularPontuacaoPergunta(integer) RETURNS integer AS $calcularPontuacaoPergunta$
BEGIN
	SELECT SUM(VotoPergunta.valor) AS pontuacao FROM VotoPergunta
	WHERE VotoPergunta.idPergunta = $1;
END;

$calcularPontuacaoPergunta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*          calcularPontuacaoResposta         */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION calcularPontuacaoResposta(integer) RETURNS integer AS $calcularPontuacaoResposta$
BEGIN
	SELECT SUM(VotoResposta.valor) AS pontuacao FROM VotoResposta
	WHERE VotoResposta.idResposta = $1;
END;

$calcularPontuacaoResposta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*                 formatarData               */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION knowUP.formatarData(timestamp) RETURNS text AS $formatarData$
BEGIN
	SELECT to_char($1, 'Day, DD/MM/SS HH:MI');
END;

$formatarData$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*                seguirPergunta              */
/*--------------------------------------------*/

CREATE TRIGGER TRIGGER_seguirPergunta
	AFTER INSERT ON knowUP.Pergunta
	FOR EACH ROW
	BEGIN
	INSERT INTO Seguidor(NEW.idAutor, NEW.idPergunta, now(), now());
	END;