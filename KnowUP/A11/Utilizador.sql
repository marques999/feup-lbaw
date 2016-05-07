/*-----------------------------------------------*/
/* SQL101: VERIFICAR PERMISSÕES DE ADMINISTRADOR */
/*-----------------------------------------------*/
SELECT * FROM Administrador WHERE idAdministrador = :idUtilizador;

/*-----------------------------------------------*/
/* SQL102: VERIFICAR PERMISSÕES DE MODERADOR     */
/*-----------------------------------------------*/
SELECT * FROM Moderador WHERE idModerador = :idUtilizador;

/*--------------------------------------------*/
/* SQL103: OBTER INFORMAÇÕES DO UTILIZADOR    */
/*--------------------------------------------*/
SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome,
       Utilizador.ultimoNome,
       Utilizador.primeiroNome || ' '  || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.email,
       Instituicao.idInstituicao,
       Instituicao.sigla,
       Instituicao.website,
       Utilizador.localidade,
       Utilizador.codigoPais,
       Utilizador.dataRegisto,
       Utilizador.ultimaSessao,
       Utilizador.ativo,
       Utilizador.removido,
       COALESCE(COUNT(DISTINCT Pergunta.idPergunta), 0) AS numeroPerguntas,
       COALESCE(COUNT(DISTINCT Resposta.idResposta), 0) AS numeroRespostas
FROM Utilizador
LEFT JOIN Contribuicao USING(idUtilizador)
LEFT JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
LEFT JOIN Pergunta ON Pergunta.idAutor = Utilizador.idUtilizador
LEFT JOIN Instituicao USING(idInstituicao)
WHERE Utilizador.idUtilizador = :idUtilizador
GROUP BY Utilizador.idUtilizador, Instituicao.idInstituicao;

/*--------------------------------------------*/
/* SQL104: DENUNCIAR UTILIZADOR               */
/*--------------------------------------------*/
INSERT INTO Report(idReport, idModerador, idUtilizador, descricao)
VALUES(DEFAULT, :idModerador, :idUtilizador, :descricao);

/*--------------------------------------------*/
/* SQL105: REGISTAR UTILIZADOR                */
/*--------------------------------------------*/
INSERT INTO Utilizador(idUtilizador, username, password, primeiroNome, ultimoNome)
VALUES(DEFAULT, :username, :password, :email, :primeiroNome, :ultimoNome)

/*--------------------------------------------*/
/* SQL106: ATUALIZAR UTILIZADOR               */
/*--------------------------------------------*/

/*--------------------------------------------*/
/* SQL107: ALTERAR PASSWORD                   */
/*--------------------------------------------*/
UPDATE Utilizador SET password = :password WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL108: BANIR UTILIZADOR                   */
/*--------------------------------------------*/
UPDATE Utilizador SET ativo = FALSE WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* SQL109: APAGAR UTILIZADOR                  */
/*--------------------------------------------*/
UPDATE Utilizador SET removido = TRUE WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* LISTAR UTILIZADORES ATIVOS                 */
/*--------------------------------------------*/
SELECT Utilizador.idUtilizador,
      Utilizador.username,
      Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
      Utilizador.email,
      Utilizador.localidade,
      Utilizador.codigoPais,
      Utilizador.ultimaSessao,
      Instituicao.sigla,
      COALESCE(COUNT(DISTINCT Pergunta.idPergunta), 0) AS numeroPerguntas,
      COALESCE(COUNT(DISTINCT Resposta.idResposta), 0) AS numeroRespostas
    FROM Utilizador
    LEFT JOIN Contribuicao USING(idUtilizador)
    LEFT JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
    LEFT JOIN Pergunta ON Pergunta.idAutor = Utilizador.idUtilizador
    LEFT JOIN Instituicao USING(idInstituicao)
    WHERE Utilizador.ativo AND NOT Utilizador.removido
    AND Utilizador.idUtilizador <> 1
    GROUP BY Utilizador.idUtilizador, Instituicao.sigla
    ORDER BY Utilizador.idUtilizador;

/*--------------------------------------------*/
/* LISTAR UTILIZADORES BANIDOS                */
/*--------------------------------------------*/
SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.email,
       Utilizador.localidade,
       Utilizador.codigoPais,
       Utilizador.ultimaSessao,
       Instituicao.sigla,
       COALESCE(COUNT(DISTINCT Pergunta.idPergunta), 0) AS numeroPerguntas,
       COALESCE(COUNT(DISTINCT Resposta.idResposta), 0) AS numeroRespostas
FROM Utilizador
LEFT JOIN Contribuicao USING(idUtilizador)
LEFT JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
LEFT JOIN Pergunta ON Pergunta.idAutor = Utilizador.idUtilizador
LEFT JOIN Instituicao USING(idInstituicao)
WHERE NOT Utilizador.ativo AND NOT Utilizador.removido
AND Utilizador.idUtilizador <> 1
GROUP BY Utilizador.idUtilizador, Instituicao.sigla
ORDER BY Utilizador.idUtilizador;

/*--------------------------------------------*/
/* LISTAR UTILIZADORES REMOVIDOS              */
/*--------------------------------------------*/
SELECT Utilizador.idUtilizador,
       Utilizador.username,
       Utilizador.primeiroNome || ' ' || Utilizador.ultimoNome AS nomeUtilizador,
       Utilizador.email,
       Utilizador.localidade,
       Utilizador.codigoPais,
       Utilizador.ultimaSessao,
       Instituicao.sigla,
       COALESCE(COUNT(DISTINCT Pergunta.idPergunta), 0) AS numeroPerguntas,
       COALESCE(COUNT(DISTINCT Resposta.idResposta), 0) AS numeroRespostas
FROM Utilizador
LEFT JOIN Contribuicao USING(idUtilizador)
LEFT JOIN Resposta ON Resposta.idResposta = Contribuicao.idContribuicao
LEFT JOIN Pergunta ON Pergunta.idAutor = Utilizador.idUtilizador
LEFT JOIN Instituicao USING(idInstituicao)
WHERE Utilizador.removido
AND Utilizador.idUtilizador <> 1
GROUP BY Utilizador.idUtilizador, Instituicao.sigla
ORDER BY Utilizador.idUtilizador;