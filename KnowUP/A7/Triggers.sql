CREATE OR REPLACE FUNCTION knowUP.classificarPergunta() RETURNS trigger AS $classificarPergunta$
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

CREATE OR REPLACE FUNCTION knowUP.classificarResposta() RETURNS TRIGGER AS $classificarResposta$
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

CREATE OR REPLACE FUNCTION knowUP.responderPergunta() RETURNS TRIGGER as $responderPergunta$
DECLARE
	AutorPergunta integer;
	AutorResposta integer;
BEGIN
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

CREATE OR REPLACE FUNCTION knowUP.melhorResposta() RETURNS trigger AS $melhorResposta$
BEGIN
	IF EXISTS (SELECT * FROM knowUP.Pergunta WHERE knowUP.Pergunta.melhorResposta) THEN
		RETURN NULL;
	END IF;
	RETURN NEW;
END;

$melhorResposta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION knowUP.registarVotoPergunta(integer, integer, integer)
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

CREATE OR REPLACE FUNCTION knowUP.registarVotoPergunta(integer, integer, integer)
RETURNS void AS $registerVotoResposta$
BEGIN
	IF EXISTS(SELECT 1 FROM knowUP.VotoResposta WHERE idResposta = $1 AND idAutor = $2) THEN
		UPDATE knowUP.VotoResposta SET valor = $3 WHERE idResposta = $1 AND idAutor = $2);
		RETURN;
	ELSE
		INSERT INTO knowUP.VotoResposta VALUES ($1, $2, $3);
		RETURN;
	END IF;
END;

$registarVotoResposta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION calcularPontuacaoPergunta(integer) RETURNS integer AS $calcularPontuacaoPergunta$
BEGIN
	SELECT SUM(VotoPergunta.valor) AS pontuacao FROM VotoPergunta
	WHERE VotoPergunta.idPergunta = $1;
END;

$calcularPontuacaoPergunta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION calcularPontuacaoResposat(integer) RETURNS integer AS $calcularPontuacaoResposat$
BEGIN
	SELECT SUM(VotoResposta.valor) AS pontuacao FROM VotoResposta
	WHERE VotoResposta.idResposta = $;
END;

$calcularPontuacaoResposta$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION knowUP.formatarData(timestamp) RETURNS text AS $formatarData$
BEGIN
	SELECT to_char($1, 'Day, DD/MM/SS HH:MI');
END;

$formatarData$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_seguirPergunta
	AFTER INSERT ON knowUP.Pergunta
	FOR EACH ROW
	BEGIN
		INSERT INTO Seguidor(NEW.idAutor, NEW.idPergunta, now(), now());
	END;

CREATE TRIGGER TRIGGER_classificarPergunta
	BEFORE INSERT ON knowUP.VotoPergunta
	FOR EACH ROW
	EXECUTE PROCEDURE knowUP.FUNC_classificarPergunta();

CREATE TRIGGER TRIGGER_classificarResposta
	BEFORE INSERT ON knowUP.VotoResposta
	FOR EACH ROW
	EXECUTE PROCEDURE knowUP.FUNC_classificarResposta();

CREATE TRIGGER TRIGGER_responderPergunta
	BEFORE INSERT ON knowUP.Resposta
	FOR EACH ROW
	EXECUTE PROCEDURE knowUP.FUNC_responderPergunta();

CREATE TRIGGER TRIGGER_melhorResposta
	BEFORE INSERT OR UPDATE ON knowUP.Resposta
	FOR EACH ROW
	WHEN (NEW.melhorResposta)
	EXECUTE PROCEDURE knowUP.FUNC_melhorResposta();

CREATE TRIGGER TRIGGER_alterarVotoPergunta
	BEFORE INSERT ON knowUP.VotoPergunta
	FOR EACH ROW
	WHEN EXISTS (SELECT * FROM VotoPergunta
		WHERE VotoPergunta.idPergunta == NEW.idPergunta
		AND VotoPergunta.idAutor == NEW.idAutor)
	EXECUTE PROCEDURE knowUP.FUNC_alterarVoto();
