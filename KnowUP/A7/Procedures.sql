SET SCHEMA 'knowup';

/*--------------------------------------------*/
/*            registarVotoPergunta            */
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
/*            registarVotoResposta            */
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
/*          FUNÇÃO: visitarPergunta           */
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
/*            FUNÇÃO: lerMensagens            */
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