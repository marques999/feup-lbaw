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

INSERT INTO "Instituicoes"
VALUES (1, 'Faculdade de Desporto da Universidade do Porto', 'fadeup', 'Rua Dr. Plácido da Costa 91, 4200-450 PORTO', '22 042 5200', 'https://sigarra.up.pt/fadeup/pt/web_page.inicial');

INSERT INTO "Instituicoes"
VALUES (2, 'Faculdade de Ciências da Universidade do Porto', 'fcup', 'Rua do Campo Alegre 1021, 4169-007 PORTO', '22 040 2900', 'https://sigarra.up.pt/fcup/pt/web_page.inicial');

INSERT INTO "Instituicoes"
VALUES (3, 'Faculdade de Direito da Universidade do Porto', 'fdup', 'Rua dos Bragas 223, 4050-123 PORTO', '22 204 1600', 'https://sigarra.up.pt/fdup/pt/web_page.inicial');

INSERT INTO "Instituicoes" 
VALUES (4, 'Faculdade de Economia da Universidade do Porto', 'fep', 'Rua Dr. Roberto Frias s/n, 4200-464 PORTO', '22 557 1100', 'https://sigarra.up.pt/fep/pt/web_page.inicial');

INSERT INTO "Instituicoes" 
VALUES (5, 'Faculdade de Engenharia da Universidade do Porto', 'feup', 'Rua Dr. Roberto Frias s/n, 4200-465 PORTO', '22 508 1400', 'https://sigarra.up.pt/feup/pt/web_page.inicial');

INSERT INTO "Instituicoes" 
VALUES (6, 'Faculdade de Farmácia da Universidade do Porto', 'ffup', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8500', 'https://sigarra.up.pt/ffup/pt/web_page.inicial');

INSERT INTO "Instituicoes" 
VALUES (7, 'Faculdade de Letras da Universidade do Porto', 'flup', 'Via Panorâmica Edgar Cardoso s/n, 4150-564 PORTO', '22 607 7100', 'https://sigarra.up.pt/flup/pt/web_page.inicial');

INSERT INTO "Instituicoes"
VALUES (8, 'Faculdade de Medicina da Universidade do Porto', 'fmup', 'Alameda Prof. Hernâni Monteiro, 4200-319 PORTO', '22 551 3600', 'https://sigarra.up.pt/fmup/pt/web_page.inicial');

INSERT INTO "Instituicoes"
VALUES (9, 'Instituto de Ciências Biomédicas Abel Salazar', 'icbas', 'Rua de Jorge Viterbo Ferreira 228, 4050-313 PORTO', '22 042 8000', 'https://sigarra.up.pt/icbas/pt/web_page.inicial');