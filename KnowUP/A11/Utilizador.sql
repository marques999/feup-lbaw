/*--------------------------------------------*/
/* REGISTAR UTILIZADOR                        */
/*--------------------------------------------*/
INSERT INTO Utilizador(idUtilizador, username, password, primeiroNome, ultimoNome)
VALUES(DEFAULT, :username, :password, :email, :primeiroNome, :ultimoNome)

/*--------------------------------------------*/
/* APAGAR UTILIZADOR                          */
/*--------------------------------------------*/
UPDATE Utilizador SET removido = TRUE WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* BANIR UTILIZADOR                           */
/*--------------------------------------------*/
UPDATE Utilizador SET ativo = FALSE WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* DENUNCIAR UTILIZADOR                       */
/*--------------------------------------------*/
INSERT INTO Report(idReport, idModerador, idUtilizador, descricao)
VALUES(DEFAULT, :idModerador, :idUtilizador, :descricao);

/*--------------------------------------------*/
/* VERIFICAR PERMISSÕES DE ADMINISTRADOR      */
/*--------------------------------------------*/
SELECT * FROM Administrador WHERE idAdministrador = :idUtilizador;

/*--------------------------------------------*/
/* VERIFICAR PERMISSÕES DE MODEAADOR          */
/*--------------------------------------------*/
SELECT * FROM Moderador WHERE idModerador = :idUtilizador;

/*--------------------------------------------*/
/* ALTERAR PASSWORD                           */
/*--------------------------------------------*/
UPDATE Utilizador SET password = :password WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* OBTER INFORMAÇÕES DA INSTITUIÇÃO           */
/*--------------------------------------------*/
SELECT idInstituicao, sigla
FROM Utilizador
LEFT JOIN Instituicao USING (idInstituicao)
WHERE idUtilizador = :idUtilizador;

/*--------------------------------------------*/
/* OBTER INFORMAÇÕES DO UTILIZADOR            */
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
/* LISTAR RESPOSTAS DO UTILIZADOR             */
/*--------------------------------------------*/
SELECT Resposta.idResposta,
       Pergunta.idPergunta,
       Pergunta.titulo,
       Pergunta.ativa,
       Contribuicao.descricao,
       Contribuicao.dataHora,
       Resposta.melhorResposta,
       COALESCE(SUM(CASE WHEN valor = 1 THEN 1 ELSE 0 END), 0) AS votosPositivos,
       COALESCE(SUM(CASE WHEN valor = -1 THEN 1 ELSE 0 END), 0) AS votosNegativos,
       COALESCE(SUM(valor), 0) AS pontuacao
FROM Resposta
INNER JOIN Contribuicao ON Contribuicao.idContribuicao = Resposta.idResposta
LEFT JOIN VotoResposta USING(idResposta)
INNER JOIN Pergunta USING (idPergunta)
INNER JOIN Utilizador USING(idUtilizador)
WHERE Contribuicao.idUtilizador = :idUtilizador
GROUP BY Contribuicao.idContribuicao, Pergunta.idPergunta, Resposta.idResposta
ORDER BY Contribuicao.dataHora DESC;

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