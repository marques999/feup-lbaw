SET SCHEMA 'knowup';

/*--------------------------------------------*/
/*        TRIGGER_votarPropriaPergunta        */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION votarPropriaPergunta()
RETURNS TRIGGER AS $votarPropriaPergunta$
DECLARE
    AutorPergunta integer;
BEGIN
    SELECT Pergunta.idAutor INTO AutorPergunta
    FROM Pergunta WHERE Pergunta.idPergunta = NEW.idPergunta;
    IF (AutorPergunta = NEW.idAutor) THEN
        RAISE EXCEPTION 'não pode classificar as suas próprias perguntas!';
        RETURN NULL;
    END IF;
    RETURN NEW;
END;

$votarPropriaPergunta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_votarPropriaPergunta
    BEFORE INSERT ON VotoPergunta
    FOR EACH ROW
    EXECUTE PROCEDURE votarPropriaPergunta();

/*--------------------------------------------*/
/*        TRIGGER_votarPropriaResposta        */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION votarPropriaResposta()
RETURNS TRIGGER AS $votarPropriaResposta$
DECLARE
    AutorResposta integer;
BEGIN
    SELECT Contribuicao.idAutor INTO AutorResposta
    FROM Resposta
    JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
    WHERE Resposta.idResposta = NEW.idResposta;
    IF (AutorResposta = NEW.idAutor) THEN
        RAISE EXCEPTION 'não pode classificar as suas próprias respostas!';
        RETURN NULL;
    END IF;
    RETURN NEW;
END;

$votarPropriaResposta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_votarPropriaResposta
    BEFORE INSERT ON VotoResposta
    FOR EACH ROW
    EXECUTE PROCEDURE votarPropriaResposta();

/*--------------------------------------------*/
/*         TRIGGER_responderPergunta          */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION responderPergunta()
RETURNS TRIGGER AS $responderPergunta$
DECLARE
    AutorPergunta INTEGER;
    AutorResposta INTEGER;
    PerguntaActiva BOOLEAN;
BEGIN
    SELECT Pergunta.ativa INTO PerguntaActiva
    FROM Pergunta WHERE NEW.idPergunta = Pergunta.idPergunta
    LIMIT 1;
    IF (NOT PerguntaActiva) THEN
        RAISE EXCEPTION 'não pode responder a uma pergunta fechada!';
        RETURN NULL;
    END IF;
    SELECT Pergunta.idAutor INTO AutorPergunta
    FROM Pergunta WHERE Pergunta.idPergunta = NEW.idPergunta
    LIMIT 1;
    SELECT Contribuicao.idAutor INTO AutorResposta
    FROM Contribuicao WHERE Contribuicao.idContribuicao = NEW.idResposta
    LIMIT 1;
    IF (AutorResposta = AutorPergunta) THEN
        RAISE EXCEPTION 'não pode responder às suas próprias perguntas!';
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
/*           TRIGGER_melhorResposta           */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION melhorResposta()
RETURNS TRIGGER AS $melhorResposta$
BEGIN
    IF EXISTS (SELECT 1 FROM Resposta WHERE Resposta.melhorResposta AND Resposta.idPergunta = NEW.idPergunta) THEN
        UPDATE Resposta SET melhorResposta = FALSE
        WHERE Resposta.melhorResposta AND Resposta.idPergunta = NEW.idPergunta;
    END IF;
    RETURN NEW;
END;

$melhorResposta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_melhorResposta
    BEFORE UPDATE OF melhorResposta ON Resposta
    FOR EACH ROW
    WHEN (NEW.melhorResposta AND NOT OLD.melhorResposta)
    EXECUTE PROCEDURE melhorResposta();

/*--------------------------------------------*/
/*        TRIGGER_overlapAdministrador        */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION overlapAdministrador()
RETURNS TRIGGER AS $overlapAdministrador$
BEGIN
    IF EXISTS (SELECT 1 FROM Moderador WHERE Moderador.idModerador = NEW.idAdministrador) THEN
        RETURN NULL;
    END IF;
    RETURN NEW;
END;

$overlapAdministrador$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_overlapAdministrador
    BEFORE INSERT OR UPDATE ON Administrador
    FOR EACH ROW
    EXECUTE PROCEDURE overlapAdministrador();

/*--------------------------------------------*/
/*          TRIGGER_overlapModerador          */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION overlapModerador()
RETURNS TRIGGER AS $overlapModerador$
BEGIN
    IF EXISTS (SELECT 1 FROM Administrador WHERE Administrador.idAdministrador = NEW.idModerador) THEN
        RETURN NULL;
    END IF;
    RETURN NEW;
END;

$overlapModerador$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_overlapModerador
    BEFORE INSERT OR UPDATE ON Moderador
    FOR EACH ROW
    EXECUTE PROCEDURE overlapModerador();

/*--------------------------------------------*/
/*         TRIGGER_atualizarPesquisa          */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION atualizarPesquisa()
RETURNS TRIGGER AS $atualizarPesquisa$
BEGIN
    REFRESH MATERIALIZED VIEW PerguntasPesquisa;
    RETURN NULL;
END;

$atualizarPesquisa$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_atualizarPesquisaPergunta
    AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE
    ON Pergunta
    FOR EACH STATEMENT
    EXECUTE PROCEDURE atualizarPesquisa();

CREATE TRIGGER TRIGGER_atualizarPesquisaResposta
    AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE
    ON Resposta
    FOR EACH STATEMENT
    EXECUTE PROCEDURE atualizarPesquisa();

/*--------------------------------------------*/
/*        TRIGGER_atualizarUtilizadores       */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION atualizarUtilizadores()
RETURNS TRIGGER AS $atualizarUtilizadores$
BEGIN
    REFRESH MATERIALIZED VIEW UtilizadoresPesquisa;
    RETURN NULL;
END;
$atualizarUtilizadores$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_atualizarUtilizadores
    AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE
    ON Utilizador
    FOR EACH STATEMENT
    EXECUTE PROCEDURE atualizarUtilizadores();

/*--------------------------------------------*/
/*         TRIGGER_autofollowPergunta         */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION autofollowPergunta()
RETURNS TRIGGER AS $autofollowPergunta$
BEGIN
    INSERT INTO Seguidor(idSeguidor, idPergunta, dataInicio, dataAcesso)
    VALUES(NEW.idAutor, NEW.idPergunta, NEW.dataHora, NEW.dataHora);
    RETURN NEW;
    EXCEPTION WHEN unique_violation THEN
        RETURN NEW;
END;

$autofollowPergunta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_autofollowPergunta
    AFTER INSERT ON Pergunta
    FOR EACH ROW
    EXECUTE PROCEDURE autofollowPergunta();

/*--------------------------------------------*/
/*         TRIGGER_autofollowResposta         */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION autofollowResposta()
RETURNS TRIGGER AS $autofollowResposta$
BEGIN
    INSERT INTO Seguidor
    SELECT Contribuicao.idAutor, NEW.idPergunta, Contribuicao.dataHora, Contribuicao.dataHora
    FROM Contribuicao
    WHERE Contribuicao.idContribuicao = NEW.idResposta
    LIMIT 1;
    RETURN NEW;
    EXCEPTION WHEN unique_violation THEN
        RETURN NEW;
END;

$autofollowResposta$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_autofollowResposta
    AFTER INSERT ON Resposta
    FOR EACH ROW
    EXECUTE PROCEDURE autofollowResposta();

/*--------------------------------------------*/
/*        TRIGGER_autofollowComentario        */
/*--------------------------------------------*/

CREATE OR REPLACE FUNCTION autofollowComentario()
RETURNS TRIGGER AS $autofollowComentario$
BEGIN
    INSERT INTO Seguidor
    SELECT Contribuicao.idAutor, NEW.idPergunta, Contribuicao.dataHora, Contribuicao.dataHora
    FROM Contribuicao
    WHERE Contribuicao.idContribuicao = NEW.idPergunta
    LIMIT 1;
    RETURN NEW;
    EXCEPTION WHEN unique_violation THEN
        RETURN NEW;
END;

$autofollowComentario$ LANGUAGE plpgsql;

CREATE TRIGGER TRIGGER_autofollowComentario
    AFTER INSERT ON ComentarioPergunta
    FOR EACH ROW
    EXECUTE PROCEDURE autofollowComentario();