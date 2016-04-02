CREATE FUNCTION knowUP.apagarVoto() RETURNS trigger AS $decrementVotes$
	BEGIN
		IF new.valor = 1
			THEN UPDATE knowUP.Perguntas SET
				votosPositivos = votosPositivos - 1,
				pontuacao = pontuacao - 1
			WHERE new.contribuicaoID = contribuicaoID;
		ELSE IF new.valor = -1
			THEN UPDATE knowUP.Perguntas SET
				votosNegativos = votosNegativos - 1,
				pontuacao = pontuacao + 1
			WHERE new.contribuicaoID = contribuicaoID;
		END IF;
		return new;
	END;
$decrementVotes$ LANGUAGE plpgsql;

CREATE TRIGGER incrementarVotosPergunta
	AFTER INSERT ON knowUP.VotosPergunta
	FOR EACH ROW
	EXECUTE PROCEDURE knowUP.incrementVotes();
CREATE TRIGGER incrementarVotosResposta
	AFTER INSERT ON knowUP.incrementVotes();
	FOR EACH ROW
	EXECUTE PROCEDURE knowUP.incrementVotes();

CREATE TRIGGER decrementarVotosPergunta
	BEFORE DELETE ON knowUP.VotosPergunta
	FOR EACH ROW
	EXECUTE PROCEDURE knowUP.decrementVotes();
CREATE TRIGGER decrementarVotosResposta
	BEFORE DELETE ON knowUP.VotosResposta
	FOR EACH ROW
	EXECUTE PROCEDURE knowUP.decrementVotes();