SET SCHEMA 'knowup';

/*--------------------------------------------*/
/*            registarVotoPergunta            */
/*--------------------------------------------*/

-- registarVotoPergunta(idPergunta, idUtilizador, valor)

CREATE OR REPLACE FUNCTION registarVotoPergunta(integer, integer, integer)
RETURNS BOOLEAN AS $registarVotoPergunta$
DECLARE
    VotoActual INTEGER;
BEGIN
    IF ($3 = 0) THEN
        RETURN FALSE;
    END IF;
    SELECT valor INTO VotoActual FROM VotoPergunta WHERE idPergunta = $1 AND idUtilizador = $2;
    IF FOUND THEN
        IF VotoActual = $3 THEN
            DELETE FROM VotoPergunta
            WHERE idPergunta = $1 AND idUtilizador = $2;
        ELSE
            UPDATE VotoPergunta
            SET valor = $3
            WHERE idPergunta = $1 AND idUtilizador = $2;
        END IF;
        RETURN TRUE;
    ELSE
        INSERT INTO VotoPergunta VALUES($1, $2, $3);
        RETURN TRUE;
    END IF;
    RETURN FALSE;
END;

$registarVotoPergunta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*            registarVotoResposta            */
/*--------------------------------------------*/

-- registarVotoResposta(idResposta, idUtilizador, valor)

CREATE OR REPLACE FUNCTION registarVotoResposta(integer, integer, integer)
RETURNS BOOLEAN AS $registarVotoResposta$
DECLARE
    VotoActual INTEGER;
BEGIN
    IF ($3 = 0) THEN
        RETURN FALSE;
    END IF;
    SELECT valor INTO VotoActual FROM VotoResposta WHERE idPergunta = $1 AND idUtilizador = $2;
    IF FOUND THEN
        IF VotoActual = $3 THEN
            DELETE FROM VotoResposta
            WHERE idResposta = $1 AND idUtilizador = $2;
        ELSE
            UPDATE VotoResposta
            SET valor = $3
            WHERE idResposta = $1 AND idUtilizador = $2;
        END IF;
        RETURN TRUE;
    ELSE
        INSERT INTO VotoResposta VALUES ($1, $2, $3);
        RETURN TRUE;
    END IF;
    RETURN FALSE;
END;

$registarVotoResposta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*              visitarPergunta               */
/*--------------------------------------------*/

-- visitarPergunta(idPergunta, idUtilizador)

CREATE OR REPLACE FUNCTION visitarPergunta(integer, integer)
RETURNS VOID AS $visitarPergunta$
BEGIN
    UPDATE Seguidor
    SET dataAcesso = now()
    WHERE idPergunta = $1 AND idSeguidor = $2;
    RETURN;
END;

$visitarPergunta$ LANGUAGE plpgsql;

/*--------------------------------------------*/
/*                lerMensagens                */
/*--------------------------------------------*/

-- lerMensagens(idConversa, idUtilizador)

CREATE OR REPLACE FUNCTION lerMensagens(integer, integer)
RETURNS VOID AS $lerMensagens$
BEGIN
    UPDATE Conversa
    SET ultimoAcesso1 = now()
    WHERE idConversa = $1 AND idUtilizador1 = $2;
    IF NOT FOUND THEN
        UPDATE Conversa
        SET ultimoAcesso2 = now()
        WHERE idConversa = $1 AND idUtilizador2 = $2;
    END IF;
    RETURN;
END;

$lerMensagens$ LANGUAGE plpgsql;